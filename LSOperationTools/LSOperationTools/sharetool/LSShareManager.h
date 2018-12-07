//
//  LSShareManager.h
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/11/30.
//  Copyright © 2018 lisong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSShareModel.h"

#import <UMengUShare/UMSocialQQHandler.h>
#import <UMengUShare/UMSocialSinaHandler.h>
#import <UMengUShare/UMSocialWechatHandler.h>



NS_ASSUME_NONNULL_BEGIN

@interface LSShareManager : NSObject


/**
 配置友盟信息

 @param configDic 配置文件
 */
+ (void)configUMengWithConfigDic:(NSDictionary *)configDic;


/**
 分享网址方法

 @param shareAppType 分享类型
 @param title 分享标题
 @param content 分享内容
 @param image 分享t标题图片
 @param imageName 分享的图片url
 @param url 分享的网址
 @param controller f视图控制器
 */
+ (void)shareAppWithShareAppType:(LSShareAppType)shareAppType
                              title:(NSString *)title
                            content:(NSString *)content
                              image:(UIImage *)image
                          imageName:(NSString *)imageName
                                url:(NSString *)url
                presentedController:(UIViewController *)controller;



/**
 分享图片
 
 @param imageObj 图片对象，可以是任何类型
 @param shareType 1:微信 2:朋友圈 3:新浪 4:qq
 */
+ (void)shareImageWithImageObj:(id)imageObj
                     shareType:(NSInteger)shareType;

@end

NS_ASSUME_NONNULL_END
