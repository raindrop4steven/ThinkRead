//
//  LoadingView.h
//  Mall
//
//  Created by Destiny on 15/11/19.
//  Copyright © 2015年 iss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    NSInteger count;
    NSInteger timeout;
    NSTimer *timeoutTimer;
    
    UIView *contentView;
    UIActivityIndicatorView *indicator;
}

+(id)shareInstance;

-(void)showLoadingView;
-(void)showLoadingView:(NSString *)message;
-(void)hiddenLoadingView;

@end
