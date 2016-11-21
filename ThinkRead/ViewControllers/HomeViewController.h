//
//  HomeViewController.h
//  ThinkRead
//
//  Created by Destiny on 2016/10/19.
//  Copyright © 2016年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Constant.h"
#import "HttpRequest.h"
#import "CycleScrollView.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : UIViewController <AVCapturePhotoCaptureDelegate>
{
    //拍照
    AVCaptureDevice *device; 
    AVCaptureSession *session;
    AVCaptureDeviceInput *deviceInput;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_10_0
    AVCapturePhotoOutput *imageOutput;
#else
    AVCaptureStillImageOutput *imageOutput;
#endif
    
    AVCaptureVideoPreviewLayer *previewLayer;
    
    //视频播放
    AVPlayer *video_player;
    AVPlayerItem *video_player_Item;
    AVPlayerLayer *player_layer;
    
    //图片播放
    CycleScrollView *cycleScrollView;
    
    IBOutlet UIView *cover_view;
    IBOutlet UIView *player_view;
    IBOutlet UIView *bottom_button_view;
    IBOutlet UIImageView *preview_image_view;
    
    IBOutlet UIImageView *corner1;
    IBOutlet UIImageView *corner2;
    IBOutlet UIImageView *corner3;
    IBOutlet UIImageView *corner4;
    IBOutlet UIButton *close_button;
    IBOutlet UIButton *take_photo_button;
}

@end
