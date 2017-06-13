//
//  ViewController.m
//  IMWIthSocketDemo
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 guchunli. All rights reserved.
//

#import "ViewController.h"
#import "SocketManager.h"
#import "GCDAsynManager.h"
#import "WebSocketManager.h"
#import "MQTTManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contentField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     /*
     客户端需要做如下4件事：
     1.客户端调用 socket(...) 创建socket；
     2.客户端调用 connect(...) 向服务器发起连接请求以建立连接；
     3.客户端与服务器建立连接之后，就可以通过send(...)/receive(...)向客户端发送或从客户端接收数据；
     4.客户端调用 close 关闭 socket；
     
     服务端需要做如下5件事：
     1.服务器调用 socket(...) 创建socket；
     2.服务器调用 listen(...) 设置缓冲区；
     3.服务器通过 accept(...)接受客户端请求建立连接；
     4.服务器与客户端建立连接之后，就可以通过 send(...)/receive(...)向客户端发送或从客户端接收数据；
     5.服务器调用 close 关闭 socket；
     */
    
    /*
     1.系统socket
     2.GCDAsynSocket
     3.WebSocket:SocketRocket(npm install ws)
     4.MQTTKit MQTTClient(npm install mosca)
     5.XMPP
     */
    
    //XMPP
    /// 初始化
    self.stream = [[XMPPStream alloc] init];
    self.stream.hostName = HOST_NAME;
    self.stream.hostPort = HOST_PORT;
    [self.stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    self.registerUserName = @"ww";
//    self.registerPassWord = @"ww";
    self.loginUserName = @"zs";
    self.loginPassWord = @"zs";
}

- (IBAction)connectToServer:(id)sender {
    
//    [[SocketManager share] connect];
//    [[GCDAsynManager share]connect];
//    [[WebSocketManager share] connect];
//    [[MQTTManager share] connect];
    
    /// 与服务器建立链接
//    [self connectToSercerWithUserName:self.registerUserName resource:nil];
    [self connectToSercerWithUserName:self.loginUserName resource:nil];

}
- (IBAction)disconnectToServer:(id)sender {
    
//    [[SocketManager share] disConnect];
//    [[GCDAsynManager share] disConnect];
//    [[WebSocketManager share] disConnect];
//    [[MQTTManager share] disConnect];
    
    [self disconnectWithServer];
}
- (IBAction)sendMessage:(id)sender {
    
//    [[SocketManager share] sendMsg:self.contentField.text];
//    [[GCDAsynManager share] sendMsg:self.contentField.text];
//    [[WebSocketManager share] sendMsg:self.contentField.text];
//    [[MQTTManager share] sendMsg:self.contentField.text];
}
    
#pragma mark 与服务器连接通信
/// 与服务器建立链接，自定义方法
- (void)connectToSercerWithUserName:(NSString *)userName resource:(NSString *)resource {
    
    if ([self.stream isConnected]) {
        [self disconnectWithServer];
    }
    
    // jid
    self.stream.myJID = [XMPPJID jidWithUser:userName domain:HOST_DOMAIN resource:resource];
    
    NSError *error = nil;
    
    // 进行链接
    [self.stream connectWithTimeout:30.0 error:&error];
    
    if (error != nil) {
        NSLog(@"连接出现问题");
    }
}
    
#pragma mark XMPPStreamDelegate 协议方法
/// 与服务器连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    
    NSError *error1 = nil;
    
    // 进行注册
//    [self.stream registerWithPassword:self.registerPassWord error:&error1];
//    
//    if (error1 != nil) {
//        NSLog(@"注册出现问题");
//    }
    
    // 进行登录认证
    [self.stream authenticateWithPassword:self.loginPassWord error:&error1];
    
    if (error1 != nil) {
        NSLog(@"登录认证出现问题");
    }
}

/// 与服务器连接超时
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender {
    
    NSLog(@"连接服务器超时，请检查网络链接后再试！");
}

/// 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender {
    
    NSLog(@"注册成功");
}

/// 注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error {
    
    NSLog(@"注册失败:%@",error);
}
    
/// 登录成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    
    NSLog(@"登录成功");
    
    // 设置用户在线状态，如果没有添加，别人给你发的消息服务器默认为离线状态，是不会给你发送的
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [self.stream sendElement:presence];
}

/// 登录失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    
    NSLog(@"登录失败:%@",error);
}
    
//与服务器断开链接，用户注销
#pragma mark 与服务器连接通信
/// 与服务器断开链接，用户注销，自定义方法
- (void)disconnectWithServer {
    
    // 断开链接
    [self.stream disconnect];
}

#pragma mark XMPPStreamDelegate 协议方法

/// 注销成功
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error {
    
    NSLog(@"注销成功");
    
    // 设置用户下线状态
    XMPPPresence *presene = [XMPPPresence presenceWithType:@"unavailable"];
    [self.stream sendElement:presene];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
