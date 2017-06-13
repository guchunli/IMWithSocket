//
//  MQTTManager.h
//  IMWIthSocketDemo
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 guchunli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTTManager : NSObject

+ (instancetype)share;

- (void)connect;
- (void)disConnect;

- (void)sendMsg:(NSString *)msg;

@end
