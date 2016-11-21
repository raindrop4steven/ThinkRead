//
//  HttpRequest.m
//  Mall
//
//  Created by Destiny on 15/11/5.
//  Copyright © 2015年 iss. All rights reserved.
//

#import "HttpRequest.h"
#import "Constant.h"
#import "Common.h"
#import "MBProgressHUD.h"

@implementation HttpRequest

#pragma mark - ShareInstance
+(id)instance
{
    static id shareInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
		_session = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
		[_session setResponseSerializer:[AFJSONResponseSerializer serializer]];
		[_session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/xml", @"text/plain", nil]];
		[_session.requestSerializer setTimeoutInterval:KEYTIMEOUT];
		[_session.securityPolicy setAllowInvalidCertificates:YES];
    }
    
    return self;
}

-(void)postImage:(UIImage *)image success:(void (^)(NSDictionary *result))success failed:(void(^)(NSString *error))failed
{
    [Common showLoadingView:@"图片解析中..."];
    
	[_session POST:SERVERIP parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
	} progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if ([responseObject isKindOfClass:[NSDictionary class]])
		{
			if ([[[responseObject valueForKey:@"success"] stringValue] isEqual:@"1"])
			{
				success(responseObject);
			}
			else
			{
				failed(HttpResponseDataError);
			}
		}
		else
		{
			failed(HttpResponseDataError);
		}
		
		[Common hiddenLoadingView];
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		failed(HttpRequestTimeout);
		[Common hiddenLoadingView];
	}];
}

@end
