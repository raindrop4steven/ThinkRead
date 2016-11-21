//
//  HttpRequest.h
//  Mall
//
//  Created by Destiny on 15/11/5.
//  Copyright © 2015年 iss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Common.h"
#import "Message.h"

#pragma mark - 服务器地址
//#define SERVERIP @"http://118.178.137.211/index.php"
#define SERVERIP @"http://xiaotushuo.com:5005/upload"

@interface HttpRequest : NSObject

@property (nonatomic, retain) AFHTTPSessionManager *session;

+(id)instance;

#pragma mark - 以URL形式请求字典型返回值
-(void)postImage:(UIImage *)image success:(void (^)(NSDictionary *result))success failed:(void(^)(NSString *error))failed;

@end
