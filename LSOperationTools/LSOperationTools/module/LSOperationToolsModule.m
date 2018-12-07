//
//  LSOperationToolsModule.m
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/12/7.
//  Copyright © 2018 lisong. All rights reserved.
//

#import "LSOperationToolsModule.h"
#import "LSShareManager.h"
#import "LSPushManager.h"

@interface LSOperationToolsModule()

@property(nonatomic,copy)NSDictionary *launchOptions;


@end



@implementation LSOperationToolsModule

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.launchOptions = launchOptions;
    
    return YES;
}



/**
 根据主工程发送过来的配置文件，初始化各功能模块

 @param configDic 数据字典
 */
- (void)sendVendorsConfigInfoToModulesWithConfigDic:(NSDictionary *)configDic{
    
//    /** 配置友盟分享工具 **/
    [LSShareManager configUMengWithConfigDic:configDic];

    /** 配置消息推送工具 **/
    [[LSPushManager shareInstance] configPushWithConfigDic:configDic launchOptions:self.launchOptions];
    
    
    
}

@end
