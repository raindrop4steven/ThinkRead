//
//  Common.m
//  Mall
//
//  Created by Destiny on 15/10/13.
//  Copyright © 2015年 iss. All rights reserved.
//

#import "Common.h"

@implementation Common

+(void)setAlipayPayType:(AlipayPayType)type
{
    if (type == PayTypeToOrder)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"PayTypeToOrder" forKey:@"AlipayPayType"];
    }
    else if (type == PayTypeToRecharge)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"PayTypeToRecharge" forKey:@"AlipayPayType"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"AlipayPayType"];
    }
}

+(AlipayPayType)getAlipayPayType
{
    NSString *payType = [[NSUserDefaults standardUserDefaults] objectForKey:@"AlipayPayType"];
    
    if ([payType isEqual:@"PayTypeToOrder"])
    {
        return PayTypeToOrder;
    }
    else if ([payType isEqual:@"PayTypeToRecharge"])
    {
        return PayTypeToRecharge;
    }
    else
    {
        return PayTypeNone;
    }
}

+(void)setAlipayBackType:(AlipayBackType)type
{
    if (type == BackToCartPage)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"BackToCartPage" forKey:@"AlipayBackType"];
    }
    else if (type == BackToMinePage)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"BackToMinePage" forKey:@"AlipayBackType"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"AlipayBackType"];
    }
}

+(AlipayBackType)getAlipayBackType
{
    NSString *backType = [[NSUserDefaults standardUserDefaults] objectForKey:@"AlipayBackType"];
    
    if ([backType isEqual:@"BackToCartPage"])
    {
        return BackToCartPage;
    }
    else if ([backType isEqual:@"BackToMinePage"])
    {
        return BackToMinePage;
    }
    else
    {
        return BackToNone;
    }
}

#pragma mark - AppDelegate
+(AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - 公共函数

#pragma mark - Toast
+(void)showToast:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
		[CSToastManager setQueueEnabled:NO];
        [[[UIApplication sharedApplication] keyWindow] makeToast:message duration:1.5 position:@"bottom"];
    });
}

#pragma mark - AlertView
+(void)showAlertView:(NSString *)message
{
    [self showAlertView:message title:@"提示" cancelButtonTitle:@"确定"];
}

+(void)showAlertView:(NSString *)message title:(NSString *)title
{
    [self showAlertView:message title:title cancelButtonTitle:@"确定"];
}

+(void)showAlertView:(NSString *)message title:(NSString *)title cancelButtonTitle:(NSString *)buttonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - MBProgressHUD
+(void)hiddenLoadingView
{
    [[LoadingView shareInstance] hiddenLoadingView];
}

+(void)showLoadingView;
{
    [[LoadingView shareInstance] showLoadingView];
}

+(void)showLoadingView:(NSString *)message
{
    [[LoadingView shareInstance] showLoadingView:message];
}

#pragma mark - 判断字符串是否为空
+(BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 判断手机格式是否正确
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length == 0)
    {
        return NO;
    }
    
    if ([mobileNum hasPrefix:@"1"])
    {
        if (mobileNum.length == 11)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

#pragma mark - 计算文字高度
+(CGFloat)getTextHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    CGRect textSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil] context:nil];
    return textSize.size.height;
}

#pragma mark - 转化为字符串类型数据
+(NSString *)stringFromValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value stringValue];
    }
    else
    {
        return (NSString *)value;
    }
}

@end
