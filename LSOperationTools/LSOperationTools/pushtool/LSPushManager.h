//
//  LSPushManager.h
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/12/7.
//  Copyright © 2018 lisong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JPush/JPUSHService.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSPushManager : NSObject<JPUSHRegisterDelegate>


+ (instancetype)shareInstance;

- (void)configPushWithConfigDic:(NSDictionary *)configDic launchOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
