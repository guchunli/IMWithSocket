//
//  ViewController.h
//  IMWIthSocketDemo
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 guchunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XMPPFramework/XMPPFramework.h>

/// 定义 XMPP 服务器相关信息
//注意：只能写IP，不能写127.0.0.1
#define HOST_DOMAIN     @"192.168.1.143"
#define HOST_NAME       @"192.168.1.143"
#define HOST_PORT       5222

@interface ViewController : UIViewController<XMPPStreamDelegate>
    
/// 注册的账号
@property (nonatomic, copy) NSString *registerUserName;

/// 注册的密码
@property (nonatomic, copy) NSString *registerPassWord;

/// XMPP 流
@property (nonatomic, strong) XMPPStream *stream;

/// 登录的账号
@property (nonatomic, copy) NSString *loginUserName;

/// 登录的密码
@property (nonatomic, copy) NSString *loginPassWord;

@end

