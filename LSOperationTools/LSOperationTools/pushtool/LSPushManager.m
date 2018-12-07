//
//  LSPushManager.m
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/12/7.
//  Copyright © 2018 lisong. All rights reserved.
//


#import "LSPushManager.h"

#import <JPush/JPUSHService.h>

@interface LSPushManager ()<JPUSHRegisterDelegate>

@end


@implementation LSPushManager


+ (instancetype)shareInstance{
    
    static LSPushManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LSPushManager alloc] init];
    });
    return manager;
}


- (void)configPushWithConfigDic:(NSDictionary *)configDic launchOptions:(NSDictionary *)launchOptions{
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions
                           appKey:configDic[@"jpush_key"]
                          channel:configDic[@"jpush_channel"]
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
    /** 判断是否有远程通知 **/
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"%@",userInfo);
    
    [JPUSHService resetBadge];
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
}

#endif

@end
