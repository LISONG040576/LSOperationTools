//
//  LSShareModel.h
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/12/5.
//  Copyright © 2018 lisong. All rights reserved.
//

#import <LSCommonality/LSBaseModel.h>
#import <UIKit/UIKit.h>


/**
 分享类型方法
 */
typedef NS_ENUM(NSInteger ,LSShareAppType){
    LSShareAppTypeWeChat = 0,       //微信分享
    LSShareAppTypeWeChatTimeLine,   //朋友圈分享
    LSShareAppTypeSina,             //新浪微博分享
    LSShareAppTypeQQ,               //QQ分享
    LSShareAppTypeSms               //短信分享
};

NS_ASSUME_NONNULL_BEGIN

@interface LSShareModel : LSBaseModel

/** 分享标题 **/
@property(nonatomic,copy)NSString *title;
/** 分享内容（副标题） **/
@property(nonatomic,copy)NSString *content;
/** 图片Url **/
@property(nonatomic,copy)NSString *imageUrlStr;
/** 图片（优先加载这个，如果为空，则加载上面的url） **/
@property(nonatomic,strong)UIImage  *image;
/** 分享类型 **/
@property(nonatomic,assign)LSShareAppType *shareType;


@end

NS_ASSUME_NONNULL_END
