//
//  LoadingView.m
//  Mall
//
//  Created by Destiny on 15/11/19.
//  Copyright © 2015年 iss. All rights reserved.
//

#import "LoadingView.h"
#import "Common.h"
#import "Constant.h"
#import "Masonry.h"

@implementation LoadingView

#pragma mark - ShareInstance
+(id)shareInstance
{
    static id shareInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        count = 0;
        timeout = 0;
        
        [self setFrame:[[UIScreen mainScreen] bounds]];
        [self setBackgroundColor:[UIColor clearColor]];
        
        //ContentView
        contentView = [[UIView alloc] init];
        [contentView setAlpha:0.7];
        [contentView.layer setCornerRadius:10.0];
        [contentView.layer setMasksToBounds:YES];
        [contentView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 90));
            make.center.equalTo(self);
        }];
        
        //背景
        UIView *contentBackground = [[UIView alloc] init];
        [contentBackground setBackgroundColor:[UIColor blackColor]];
        [contentBackground setAlpha:0.6];
        [contentView addSubview:contentBackground];
        
        [contentBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        //UIActivityIndicatorView
        indicator = [[UIActivityIndicatorView alloc] init];
        [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator stopAnimating];
        [contentView addSubview:indicator];
        
        [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        
    }
    return self;
}

#pragma mark - 显示
-(void)showLoadingView
{
    [self showLoadingView:@"Loading..."];
}

-(void)showLoadingView:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (count == 0)
        {
            [self setAlpha:0.0];
            [[[Common getAppDelegate] window] addSubview:self];
            
            [UIView animateWithDuration:0.2 animations:^{
                [self setAlpha:1.0];
            }];
            
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo([[Common getAppDelegate] window]).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
            [indicator startAnimating];
        }
        
        count ++;
        
        [self performSelector:@selector(hiddenLoadingView) withObject:nil afterDelay:KEYTIMEOUT];
    });
}

-(void)hiddenLoadingView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (count > 0)
        {
            count --;
        }
        else
        {
            count = 0;
        }
        
        if (count == 0 && self && self.superview && [self respondsToSelector:@selector(removeFromSuperview)])
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self setAlpha:0.0];
            }completion:^(BOOL finished) {
                [indicator stopAnimating];
                [self removeFromSuperview];
            }];
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenLoadingView) object:nil];
        }
    });
}

@end
