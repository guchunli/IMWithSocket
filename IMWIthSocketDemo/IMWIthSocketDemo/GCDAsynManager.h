//
//  GCDAsynManager.h
//  IMWIthSocketDemo
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 guchunli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDAsynManager : NSObject

+ (instancetype)share;

- (BOOL)connect;
- (void)disConnect;

- (void)sendMsg:(NSString *)msg;
- (void)pullTheMsg;

@end
