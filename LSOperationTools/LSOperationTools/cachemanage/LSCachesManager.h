//
//  LSCachesManager.h
//  MyTest
//
//  Created by lisong smart-李松 on 16/3/17.
//  Copyright © 2016年 lisong smart-李松. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LSCachesManager : NSObject

/*获取缓存数据的大小*/
+ (NSString *)fetchCacheSizeString;

/*清理缓存数据*/
+ (BOOL)deleteCachesData;

/*清理其他数据*/

@end
