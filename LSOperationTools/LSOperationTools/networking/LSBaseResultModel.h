//
//  LSBaseResultModel.h
//  LSOperationTools
//
//  Created by 海尔智能-李松 on 2018/12/4.
//  Copyright © 2018 lisong. All rights reserved.
//

#import "LSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSBaseResultModel : LSBaseModel


/** 返回的提示信息 */
@property(nonatomic, copy)NSString     *resultMessage;
/** 返回码 **/
@property(nonatomic, assign)NSInteger     resultCode;
/** 返回的业务数据 **/
@property(nonatomic, copy)NSDictionary *resultDict;
/** 请求是否成功 **/
@property(nonatomic, assign)BOOL       success;




@end

NS_ASSUME_NONNULL_END
