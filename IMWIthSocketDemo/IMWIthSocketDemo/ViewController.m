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
}

- (IBAction)connectToServer:(id)sender {
    
    [[SocketManager share] connect];
//    [[GCDAsynManager share]connect];
//    [[WebSocketManager share] connect];
//    [[MQTTManager share] connect];
}
- (IBAction)disconnectToServer:(id)sender {
    
    [[SocketManager share] disConnect];
//    [[GCDAsynManager share] disConnect];
//    [[WebSocketManager share] disConnect];
//    [[MQTTManager share] disConnect];
}
- (IBAction)sendMessage:(id)sender {
    
    [[SocketManager share] sendMsg:self.contentField.text];
//    [[GCDAsynManager share] sendMsg:self.contentField.text];
//    [[WebSocketManager share] sendMsg:self.contentField.text];
//    [[MQTTManager share] sendMsg:self.contentField.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
