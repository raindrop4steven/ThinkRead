//
//  Constant.h
//  Mall
//
//  Created by Destiny on 15/10/13.
//  Copyright © 2015年 iss. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//分页加载每页数据个数
#define PageDataCount 10

//接口及LoadingView超时
#define KEYTIMEOUT 30

//钥匙串唯一标识
#define IdentifierService	@"com.fruitdeliver.project"

//NSUserDefault Key
#define KEYUSERINFO			@"USERINFOKEY"
#define KEYSEARCHHISTORY	@"KEYSEARCHHISTORY"
#define KEYSERVICECENTER	@"KEYSERVICECENTER"

#define AlipayPrivateKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMcwcIWxEV8010NnIWBzxf2rd9XNQpd6x8+15bu/yMCquOC/Th8HlDFRUmqDqqhWbr6g8uJnMIAMpqWtOOh/DnUDNQXQNAaAjoFwltt8KkiJu4zrD7H4iSwKnpC91NudbvU1ImO4WbVKNp4L/o3i++f+bUMIes+WO72fJsJ1thGJAgMBAAECgYBELOkmaQ94FZ7j/AVpfNa0Vx7h96omLKj9B9YEp8SvZP94NSIo7rAjHSFnQX+EtGidKHtZUFZCTZIwPJSwxuQMP9ctfvEa7SerB3jeKxva/JqWXonrPbheI8uvPhqEbUbasUFzFAQ0vGRgGuUZkjRewrq6G2ZH7dBy+V235redfQJBAPBGrP6zBNDFeVJ+AWDogO1IIAfrJfdCGK39vorDJ6fHGHwlVkkI9/snUk718PceKWw5n5S47qPOcJqn6RV9voMCQQDUOXBuF385Z7lp2EhXvpDhsnJutNF9dutqTX738TpBjxLxhphv59YIkrsrcEIsxXVbZFmfGUBMtYjkHvejN/IDAkBb7Y5ufCuRfJwoVZFNdGcvYXLv1KXX7e/nUbe++1+Gr4PMq7RRiR7ndmnlT+97fIy4nWtSyVZ0UZ1/blKdKFjlAkEAxnwKKQ0U0i2ufc3oqxfyDQSGff/jRkKonr1oGKCmaZZUk0vc2hysU0xYfaH6YkEzJ4zNPT2yo4vNQf2sghza3QJBANiWo9lwuwsB8ezHhzvsd6NNIOWdf71y3+ZUdkLo3U//1oWBr0R/hUMjj/Rf/GWBP5jrJFO3UkGBBaQ+D+pLU2M="
#define Partner @"2088121429849903"
#define Seller_ID @"guopeisong2016@163.com"

//字符过滤
#define DefaultCharacters	@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@-_."

//默认图片
#define DefaultImage [UIImage imageNamed:@"loading"]


//screen
#define ScreenWidth		[[UIScreen mainScreen] bounds].size.width
#define ScreenHeight	[[UIScreen mainScreen] bounds].size.height


//color
#define RGB(R,G,B)			[UIColor colorWithRed:((R)/255.0) green:((G)/255.0) blue:((B)/255.0) alpha:1.0]
#define RGBAlpha(R,G,B,A)	[UIColor colorWithRed:((R)/255.0) green:((G)/255.0) blue:((B)/255.0) alpha:(A)]


//可拉伸的图片
#define ResizableImage(name,top,left,bottom,right)	[[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageWithMode(name,top,left,bottom,right,mode)	[[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]


//颜色值
#define ColorGrayBackground RGB(223, 222, 222)

//KEY
#define KEY_IS_USER_LOGIN @"KEY_IS_USER_LOGIN"//是否登录
#define KEY_USER_INFO @"KEY_USER_INFO"//用户信息
#define KEY_PWD_CAPTCHA @"KEY_CAPTCHA"//保存忘记密码验证码 key : @"phone" @"captcha"
#define KEY_REGISTER_CAPTCHA @"KEY_CAPTCHA"//保存注册验证码 key : @"phone" @"captcha"
#define NOTIFICATION_MYVIEW_RELOAD @"NOTIFICATION_MYVIEW_RELOAD"//强制下线后，刷新MyViewController

//NSLog
#define MallNSLog(string) NSLog(@"%@",string)

#define EaseMobDidLoginNotification @"EaseMobDidLoginNotification" //环信账号登录

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#endif /* Constant_h */
