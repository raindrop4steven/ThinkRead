//
//  Common.h
//  Mall
//
//  Created by Destiny on 15/10/13.
//  Copyright © 2015年 iss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"
#import "AppDelegate.h"
#import "LoadingView.h"



typedef NS_ENUM (NSInteger, LoginStatus) {
    LoginCanceled = 0,
    LoginSuccessed = 1,
};

typedef NS_ENUM (NSInteger, BarButtonItemSide) {
    BarButtonItemCenter = 0,
    BarButtonItemLeft = 1,
    BarButtonItemRight = 2
};

typedef NS_ENUM (NSInteger, BarButtonItemStyle) {
    BarButtonItemDefault = 0,
    BarButtonItemBack = 1,
    BarButtonItemAdd
};

typedef NS_ENUM (NSInteger, ShowTableViewStatus) {
    ShowSearchTableView = 0,
    ShowHistoryTableView
};

typedef NS_ENUM (NSInteger, ShowShakeInfoView) {
	ShowGooodsView = 0,
	ShowCouponView = 1,
	ShowNoneView,
};

typedef NS_ENUM (NSInteger, AlipayBackType) {
    BackToCartPage = 0,
    BackToMinePage = 1,
    BackToNone
};

typedef NS_ENUM (NSInteger, AlipayPayType) {
    PayTypeToOrder = 0,
    PayTypeToRecharge = 1,
    PayTypeNone
};

typedef NS_ENUM (NSInteger, GoodsListCellStatus) {
    GoodsListCellStatusNormal = 0,
    GoodsListCellStatusComment = 1,
    GoodsListCellStatusError
};

typedef NS_ENUM (NSInteger, OrderDetailPaymentStatus) {
	OrderDetailShowReceiveButton = 0,
	OrderDetailShowPaymentButton = 1,
	OrderDetailShowNone
};

@interface Common : NSObject

#pragma mark - AlipayPayType
+(void)setAlipayPayType:(AlipayPayType)type;
+(AlipayPayType)getAlipayPayType;

#pragma mark - AlipayBackType
+(void)setAlipayBackType:(AlipayBackType)type;
+(AlipayBackType)getAlipayBackType;

#pragma mark - AppDelegate
+(AppDelegate *)getAppDelegate;

#pragma mark - Toast
+(void)showToast:(NSString *)message;

#pragma mark - AlertView
+(void)showAlertView:(NSString *)message;
+(void)showAlertView:(NSString *)message title:(NSString *)title;
+(void)showAlertView:(NSString *)message title:(NSString *)title cancelButtonTitle:(NSString *)buttonTitle;

#pragma mark - MBProgressHUD
+(void)showLoadingView;
+(void)showLoadingView:(NSString *)message;
+(void)hiddenLoadingView;

#pragma mark - 判断字符串是否为空
+(BOOL)isBlankString:(NSString *)string;

#pragma mark - 判断手机格式是否正确
+(BOOL)isMobileNumber:(NSString *)mobileNum;

#pragma mark - 计算文字高度
+(CGFloat)getTextHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

#pragma mark - 加载更多计算页数
+(NSString *)getPageNumber:(NSArray *)array refresh:(BOOL)refresh;

#pragma mark - 转化为字符串类型数据
+(NSString *)stringFromValue:(id)value;

@end
