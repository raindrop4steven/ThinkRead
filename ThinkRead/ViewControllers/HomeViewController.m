//
//  HomeViewController.m
//  ThinkRead
//
//  Created by Destiny on 2016/10/19.
//  Copyright © 2016年 Destiny. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    session = [[AVCaptureSession alloc] init];
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    
    AVCapturePhotoSettings *setting = [[AVCapturePhotoSettings alloc] init];
    [setting setFlashMode:AVCaptureFlashModeAuto];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_10_0
    imageOutput = [[AVCapturePhotoOutput alloc] init];
    [imageOutput setPhotoSettingsForSceneMonitoring:setting];
#else
    imageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [imageOutput setOutputSettings:outputSettings];
#endif
    
    previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer addSublayer:previewLayer];
    
    [session setSessionPreset:AVCaptureSessionPreset640x480];
    
    if ([session canAddInput:deviceInput])
    {
        [session addInput:deviceInput];
    }
        
    if ([session canAddOutput:imageOutput])
    {
        [session addOutput:imageOutput];
    }
    
    [session startRunning];
}

-(void)viewDidLayoutSubviews
{
    [previewLayer setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - bottom_button_view.frame.size.height)];
    [self.view bringSubviewToFront:cover_view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ButtonPressed
-(IBAction)takePhotoButtonPressed:(UIButton *)button
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_10_0
    AVCapturePhotoSettings *setting = [[AVCapturePhotoSettings alloc] init];
    [setting setAutoStillImageStabilizationEnabled:YES];
    [setting setFlashMode:AVCaptureFlashModeAuto];
    [imageOutput capturePhotoWithSettings:setting delegate:self];
#else
    AVCaptureConnection * videoConnection = [imageOutput connectionWithMediaType:AVMediaTypeVideo];
    [imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *cut_image = [self cutImage:[UIImage imageWithData:imageData]];
        
        [preview_image_view setImage:cut_image];
        [preview_image_view setUserInteractionEnabled:YES];
        [preview_image_view setContentMode:UIViewContentModeScaleAspectFit];
        
        //上传图片
        [self uploadImageFile:cut_image];
    }];
#endif
}

- (void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error
{
    NSData *imageData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    
    UIImage *cut_image = [self cutImage:[UIImage imageWithData:imageData]];
    //UIImageWriteToSavedPhotosAlbum(cut_image, self, nil, NULL);
    
    [preview_image_view setImage:cut_image];
    [preview_image_view setUserInteractionEnabled:YES];
    [preview_image_view setContentMode:UIViewContentModeScaleAspectFit];
    
    //上传图片
    [self uploadImageFile:cut_image];
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    float x = (image.size.height - (image.size.width - 20) * 3.0 / 4.0) / 2.0;
    
//    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(x, 10, (image.size.width - 20) * 3.0 / 4.0, image.size.width - 20));
    
    // return [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationRight];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(10, x, image.size.width - 20, (image.size.width - 20) * 0.75));
    
    return [UIImage imageWithCGImage:imageRef scale:1.0 orientation:image.imageOrientation];
}

-(void)uploadImageFile:(UIImage *)image
{
    [[HttpRequest instance] postImage:image success:^(NSDictionary *result) {
        if ([[[result valueForKey:@"data"] stringValue] isEqual:@"1"])
        {
            //播放1.mp4
            [self startPlayVideo:@"video1"];
        }
        else if ([[[result valueForKey:@"data"] stringValue] isEqual:@"2"])
        {
            //播放2.mp4
            [self startPlayVideo:@"video2"];
        }
        else
        {
            //播放图片
            [self startPlayPhoto];
        }
    } failed:^(NSString *error) {
        [self stopPlayingMenu];
        [[[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
}

-(void)startPlayVideo:(NSString *)videoName
{
    [self startPlayingMenu];
    
    //设置静音状态也可播放声音
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    CGRect playerFrame = CGRectMake(0, 0, player_view.bounds.size.width, player_view.bounds.size.height);
    AVURLAsset *asset = [AVURLAsset assetWithURL:[[NSBundle mainBundle] URLForResource:videoName withExtension:@"mp4"]];
    
    video_player_Item = [AVPlayerItem playerItemWithAsset:asset];
    video_player = [[AVPlayer alloc] initWithPlayerItem:video_player_Item];
    
    player_layer = [AVPlayerLayer playerLayerWithPlayer:video_player];
    [player_layer setVideoGravity:AVLayerVideoGravityResizeAspect];
    [player_layer setFrame:playerFrame];
    
    [player_view.layer addSublayer:player_layer];
    [video_player play];
}

-(void)startPlayPhoto
{
    CGRect imageRect = CGRectMake(0, 0, ScreenWidth - 20, (ScreenWidth - 20) * 3.0 / 4.0);
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setHidesForSinglePage:YES];
    [pageControl setNumberOfPages:7];
    [pageControl setEnabled:NO];
    
    if (cycleScrollView == nil)
    {
        cycleScrollView = [[CycleScrollView alloc] initWithFrame:imageRect animationDuration:2.0];
    }
    
    [self startPlayingMenu];
    
    [cycleScrollView setFetchContentViewAtIndex:^UIView *(NSInteger index) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon0%ld", index + 1]]];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setTag:index];
        return imageView;
    }];
    
    [cycleScrollView setScrollActionBlock:^(NSInteger pageIndex) {
        [pageControl setCurrentPage:pageIndex];
    }];
    
    [cycleScrollView setTotalPagesCount:^NSInteger {
        return 7;
    }];
    
    [player_view addSubview:cycleScrollView];
    [cycleScrollView addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cycleScrollView.mas_left).with.offset(0);
        make.right.equalTo(cycleScrollView.mas_right).with.offset(0);
        make.bottom.equalTo(cycleScrollView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [cycleScrollView bringSubviewToFront:pageControl];
}

-(IBAction)closeButtonPressed:(UIButton *)button
{
    [self stopPlayingMenu];
}

-(void)startPlayingMenu
{
    [close_button setHidden:NO];
    [take_photo_button setEnabled:NO];
    
    [corner1 setHidden:YES];
    [corner2 setHidden:YES];
    [corner3 setHidden:YES];
    [corner4 setHidden:YES];
    [player_view setBackgroundColor:[UIColor blackColor]];
}

-(void)stopPlayingMenu
{
    [close_button setHidden:YES];
    [take_photo_button setEnabled:YES];
    
    [corner1 setHidden:NO];
    [corner2 setHidden:NO];
    [corner3 setHidden:NO];
    [corner4 setHidden:NO];
    
    [player_view setBackgroundColor:[UIColor clearColor]];
    
    [video_player pause];
    [video_player.currentItem cancelPendingSeeks];
    [video_player.currentItem.asset cancelLoading];
    
    if ([player_layer respondsToSelector:@selector(removeFromSuperlayer)])
    {
        [player_layer removeFromSuperlayer];
    }
    
    for (UIPageControl *page in cycleScrollView.subviews)
    {
        if (page && [page isKindOfClass:[UIPageControl class]])
        {
            if ([page respondsToSelector:@selector(removeFromSuperview)])
            {
                [page removeFromSuperview];
            }
        }
    }
    
    if ([cycleScrollView respondsToSelector:@selector(removeFromSuperview)])
    {
        [cycleScrollView removeFromSuperview];
        cycleScrollView = nil;
    }
}

 @end
