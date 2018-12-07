//
// LSHttpRequest.m
//  lisong smart
//
//  Created by lisong on 16/4/8.
//  Copyright © 2016年 lisong smart. All rights reserved.
//

#import "LSNetWorkRequest.h"
#import "AFNetworking.h"

@interface LSNetWorkRequest ()
{
    BOOL _isGetType;
    NSString *_urlStr;
    NSDictionary *_paramDic;
    NSDictionary *_headerDic;
}

@end

@implementation LSNetWorkRequest

#pragma mark - GET

+ (void)GET:(NSString *)url
    Success:(void(^)(LSBaseResultModel *result))success
       Fail:(void(^)(LSBaseResultModel *result,NSError *error))fail {
    [self GET:url
         Head:nil
      Success:^(LSBaseResultModel *result) {
          success(result);
      } Fail:^(LSBaseResultModel *result,NSError *error) {
          fail(result, error);
      }];
}

+ (void)GET:(NSString *)url
       Head:(NSDictionary *)head
    Success:(void(^)(LSBaseResultModel *result))success
       Fail:(void(^)(LSBaseResultModel *result,NSError *error))fail; {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /*
     *  添加请求头head
     */
    if (head) {
        for (NSString *key in head) {
            [manager.requestSerializer setValue:head[key] forHTTPHeaderField:key];
        }
    }
    /**
     *  @author lisong, 16-04-08 13:04:04
     *
     *  返回类型 默认JSON
     */
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.requestSerializer setTimeoutInterval:30];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    /* GET请求 */
    [manager GET:url
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             [self handleResponseObject:responseObject success:success fail:fail];
             
             success(responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             LSBaseResultModel *resultModel = [LSBaseResultModel new];
             resultModel.success = NO;
             resultModel.resultCode = error.code;
             resultModel.resultMessage = [NSString stringWithFormat:@"加载失败 - %@",error.localizedDescription];
             
             fail(resultModel,error);
         }];
}

#pragma mark - POST

+ (void)POST:(NSString *)url
        Body:(id)body
     Success:(void(^)(LSBaseResultModel *result))success
        Fail:(void(^)(LSBaseResultModel *result,NSError *error))fail {
    [self POST:url
          Head:nil
          Body:body
       Success:^(LSBaseResultModel *result) {
           success(result);
       }
          Fail:^(LSBaseResultModel *result,NSError *error) {
              fail(result, error);
          }];
}

+ (void)POST:(NSString *)url
        Head:(NSDictionary *)head
        Body:(id)body
     Success:(void(^)(LSBaseResultModel *result))success
        Fail:(void(^)(LSBaseResultModel *result,NSError *error))fail {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  @author lisong, 16-04-08 13:04:34
     *
     *  添加请求头head
     */
    if (head) {
        for (NSString *key in head) {
            [manager.requestSerializer setValue:head[key] forHTTPHeaderField:key];
        }
    }
    [manager.requestSerializer setTimeoutInterval:30];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *key = @"CFBundleShortVersionString";//( NSString *)kCFBundleVersionKey;
    NSString *currentVersion = infoDictionary[key];
    
    NSMutableDictionary *app = [[NSMutableDictionary alloc] init];
//    [app setObject:APP_ID forKey:@"app_id"];
//    [app setObject:currentVersion forKey:@"version"];
//    [app setObject:[Utilities getUserId] forKey:@"user_id"];
//    [app setObject:API_Version forKey:@"api_version"];
//    
//    NSMutableDictionary *device = [[NSMutableDictionary alloc] init];
//    [device setObject:@"iOS" forKey:@"platform"];
//    [device setObject:[[UIDevice currentDevice] systemVersion] forKey:@"model"];
//    [device setObject:@"apple" forKey:@"factory"];
//    [device setObject:[NSString stringWithFormat:@"%.2f*%.2f", kSCREEN_SIZE.width, kSCREEN_SIZE.height] forKey:@"screen_size"];
//    [device setObject:@2.0 forKey:@"denstiy"];
//    [device setObject:[HSDeviceID deviceID] forKey:@"imei"];//用uuid 替代imei
//    [device setObject:@"00-00-00-00-00-00" forKey:@"mac"];
//    [device setObject:@"4G" forKey:@"gprs"];
//    [device setObject:USER_LATITUDE forKey:@"latitude"];
//    [device setObject:USER_LONGITUDE forKey:@"longitude"];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:app forKey:@"app"];
//    [tmp setObject:device forKey:@"device"];
    
    [data setObject:tmp forKey:@"verify_info"];
    if (body != nil) {
        [data setObject:body forKey:@"data"];
    } else {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [data setObject:tmpDic forKey:@"data"];
    }
//    NSLog(@"url is : ==>%@<==\nbody is : ==>%@<==", url, [Utilities dictionaryToJsonStr:data]);
    /* POST请求 */
    [manager POST:url
       parameters:data
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              
              [self handleResponseObject:responseObject success:success fail:fail];
              
          }
          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              NSLog(@"网络请求失败 ： ==>%@<==", error);
              LSBaseResultModel *resultModel = [LSBaseResultModel new];
              resultModel.success = NO;
              resultModel.resultCode = error.code;
              resultModel.resultMessage = [NSString stringWithFormat:@"加载失败 - %@",error.localizedDescription];
              
              fail(resultModel,error);
          }];
}



/**
 处理请求回来的业务数据

 @param responseObject 返回的json数据
 @param success 成功t回掉
 @param fail 失败回掉
 */
+ (void)handleResponseObject:(id)responseObject
                 success:(void(^)(LSBaseResultModel *result))success
                    fail:(void(^)(LSBaseResultModel *result,NSError *error))fail{
    
    
    NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n"   withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\t"   withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"  "   withString:@""];
    NSError *jsonError;
    NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:objectData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&jsonError];
    
    LSBaseResultModel *resultModel = [LSBaseResultModel new];
    
    if (jsonError) {
        NSLog(@" JSON 解析失败 ： ==>%@<==", jsonError);
        resultModel.success = NO;
        resultModel.resultCode = jsonError.code;
        resultModel.resultMessage = [NSString stringWithFormat:@"JSON 解析失败 - %@",jsonError.localizedDescription];
        
        fail(resultModel,jsonError);
        return;
    }else if (jsonDic && jsonDic[@"code"] && [jsonDic[@"code"] integerValue] != 200){
        resultModel.success = NO;
        resultModel.resultCode = [jsonDic[@"code"] integerValue];
        resultModel.resultMessage = jsonDic[@"message"];
        resultModel.resultDict = jsonDic;
        fail(resultModel,jsonError);
        return;
    }
    
    resultModel.success = YES;
    resultModel.resultCode = [jsonDic[@"code"] integerValue];
    resultModel.resultMessage = jsonDic[@"message"];
    resultModel.resultDict = jsonDic;
    
    success(resultModel);
    
}


+ (void)observeNetWorkingStatus{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}








+ (LSNetWorkRequest *)shareInstance
{
    static LSNetWorkRequest *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[LSNetWorkRequest alloc]init];
    });
    return request;
}

- (LSNetWorkRequest *(^)(NSString *))url
{
    return ^LSNetWorkRequest *(NSString *url){
        _urlStr = url;
        return self;
    };
}

- (LSNetWorkRequest *(^)(BOOL))isGet
{
    return ^LSNetWorkRequest *(BOOL isGet){
        _isGetType = isGet;
        return self;
    };
}

- (LSNetWorkRequest *(^)(NSDictionary *))param
{
    return ^LSNetWorkRequest *(NSDictionary *param){
        _paramDic = param;
        return self;
    };
}

- (LSNetWorkRequest *(^)(NSDictionary *))header
{
    return ^LSNetWorkRequest *(NSDictionary *header){
        _headerDic = header;
        return self;
    };
}

- (void)requestTaskWithSuccess:(void (^)(id))success fail:(void (^)(NSError *))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  @author lisong, 16-04-08 13:04:34
     *
     *  添加请求头head
     */
    if (_headerDic) {
        for (NSString *key in _headerDic) {
            [manager.requestSerializer setValue:_headerDic[key] forHTTPHeaderField:key];
        }
    }
    [manager.requestSerializer setTimeoutInterval:30];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSMutableDictionary *app = [[NSMutableDictionary alloc] init];
//    [app setObject:APP_ID forKey:@"app_id"];
//    [app setObject:[infoDictionary objectForKey:@"CFBundleVersion"] forKey:@"version"];
//    [app setObject:[Utilities getUserId] forKey:@"user_id"];
//    
//    NSMutableDictionary *device = [[NSMutableDictionary alloc] init];
//    [device setObject:@"iOS" forKey:@"platform"];
//    [device setObject:[[UIDevice currentDevice] systemVersion] forKey:@"model"];
//    [device setObject:@"apple" forKey:@"factory"];
//    [device setObject:[NSString stringWithFormat:@"%.2f*%.2f", kSCREEN_SIZE.width, kSCREEN_SIZE.height] forKey:@"screen_size"];
//    [device setObject:@2.0 forKey:@"denstiy"];
//    [device setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"imei"];//用uuid 替代imei
//    [device setObject:@"00-00-00-00-00-00" forKey:@"mac"];
//    [device setObject:@"4G" forKey:@"gprs"];
//    [device setObject:USER_LATITUDE forKey:@"latitude"];
//    [device setObject:USER_LONGITUDE forKey:@"longitude"];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:app forKey:@"app"];
//    [tmp setObject:device forKey:@"device"];
    
    [data setObject:tmp forKey:@"verify_info"];
    if (_paramDic != nil) {
        [data setObject:_paramDic forKey:@"data"];
    } else {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [data setObject:tmpDic forKey:@"data"];
    }
//    NSLog(@"url is : ==>%@<==\nbody is : ==>%@<==", url, [Utilities dictionaryToJsonStr:data]);
    /* POST请求 */
    [manager POST:_urlStr
       parameters:data
         progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              
              NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n"   withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\t"   withString:@""];
              jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"  "   withString:@""];
              NSError *jsonError;
              NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:objectData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&jsonError];
              if (jsonError) {
                  NSLog(@" JSON 解析失败 ： ==>%@<==", jsonError);
                  fail(jsonError);
                  return;
              }
              success(jsonDic);
          }
          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              NSLog(@"网络请求失败 ： ==>%@<==", error);
              fail(error);
          }];

}

@end
