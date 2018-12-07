//
//  LSShareManager.m
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/11/30.
//  Copyright © 2018 lisong. All rights reserved.
//

#import "LSShareManager.h"
#import <LSCommonality/LSCommonality.h>


@implementation LSShareManager


+ (void)configUMengWithConfigDic:(NSDictionary *)configDic{
    
    if (configDic[@"um_app_key"]) {
        
        [[UMSocialManager defaultManager] setUmSocialAppkey:configDic[@"um_app_key"]];
        
        if (configDic[@"um_wechat_id"]) {
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:configDic[@"um_wechat_id"] appSecret:configDic[@"um_wechat_secret"] redirectURL:configDic[@"um_share_url"]];
        }
        if (configDic[@"um_qq_id"]) {
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:configDic[@"um_qq_id"]  appSecret:configDic[@"um_qq_key"] redirectURL:configDic[@"um_share_url"]];
        }
        
        if(configDic[@"um_sina_id"]){
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:configDic[@"um_sina_id"]   appSecret:configDic[@"um_sina_id"]  redirectURL:configDic[@"um_share_url"] ];
        }
    }
}






+ (void)shareAppWithShareAppType:(LSShareAppType)shareAppType
                           title:(NSString *)title
                         content:(NSString *)content
                           image:(UIImage *)image
                       imageName:(NSString *)imageName
                             url:(NSString *)url
             presentedController:(UIViewController *)controller{
    
    
    UMSocialPlatformType shareType = UMSocialPlatformType_UnKnown;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    UIImage *imageM = [UIImage imageWithData:imageData];
    
    if (content.length > 50) {
        /** 如果分享的内容大于50个字 **/
        content = [NSString stringWithFormat:@"%@......",[content substringToIndex:45]];
    }
    if (!content || content.length == 0){
        content = title;
    }
    
    if (shareAppType == LSShareAppTypeWeChat) {
        /**
         *  微信
         */
        shareType = UMSocialPlatformType_WechatSession;
        
    } else if (shareAppType == LSShareAppTypeWeChatTimeLine) {
        /**
         *  朋友圈
         */
        shareType = UMSocialPlatformType_WechatTimeLine;
        
    } else if (shareAppType == LSShareAppTypeSina) {
        /**
         *  新浪微博
         */
        shareType = UMSocialPlatformType_Sina;
        
    } else if (shareAppType == LSShareAppTypeQQ) {
        
        /**
         *  QQ
         */
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            
            showHUDWithInfoString(@"您还没有安装QQ哦！");
            return;
            
        }
        
        shareType = UMSocialPlatformType_QQ;
    }
    
    if (shareType == UMSocialPlatformType_UnKnown) {
        return;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title
                                                                             descr:content
                                                                         thumImage:image ? imageM : imageName];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    
    
    
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:shareType
                                        messageObject:messageObject
                                currentViewController:controller completion:^(id data, NSError *error) {
                                    if (error) {
                                       
                                        UMSocialLogInfo(@"************Share fail with error %@*********",error);
                                        showHUDWithErrorString(@"分享失败");
                                        
                                    }else{
                                        
                                        
                                        showHUDWithSuccessString(@"分享成功");
                                        
                                        
                                        if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                                            UMSocialShareResponse *resp = data;
                                            //分享结果消息
                                            UMSocialLogInfo(@"response message is %@",resp.message);
                                            //第三方原始返回的数据
                                            UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                                            
                                        }else{
                                            UMSocialLogInfo(@"response data is %@",data);
                                        }
                                    }
                                }];

}





+ (void)shareImageWithImageObj:(id)imageObj
                     shareType:(NSInteger)shareType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    
    /** 创建图片分享对象 **/
    UMShareImageObject *imageshareObj = [[UMShareImageObject alloc] init];
    
    imageshareObj.shareImage = imageObj;
    
    if([imageObj isKindOfClass:[NSString class]]){
        NSString *imageUrlStr = (NSString *)imageObj;
        if([imageUrlStr rangeOfString:@"https"].location == NSNotFound){
            imageUrlStr = [imageUrlStr stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
            imageshareObj.shareImage = imageUrlStr;
        }
    }
    
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = imageshareObj;
    
    if (shareType == 1) {
        /**
         *  微信
         */
        shareType = UMSocialPlatformType_WechatSession;
        
    } else if (shareType == 2) {
        /**
         *  朋友圈
         */
        shareType = UMSocialPlatformType_WechatTimeLine;
        
    } else if (shareType == 3) {
        
        /**
         *  QQ
         */
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            
            showHUDWithInfoString(@"您还没有安装QQ哦！");
            return;
            
        }
        
        shareType = UMSocialPlatformType_QQ;
    }
    
    if (shareType == UMSocialPlatformType_UnKnown) {
        
        return;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:shareType
                                        messageObject:messageObject
                                currentViewController:nil completion:^(id data, NSError *error) {
                                    if (error) {
                                        showHUDWithErrorString(@"分享失败");
                                    }else{
                                        showHUDWithSuccessString(@"分享成功");
                                    }
                                }];
    
}

@end
