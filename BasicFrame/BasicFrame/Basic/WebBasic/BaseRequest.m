//
//  LBaseRequest.m
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

static BaseRequest* _instance;
static dispatch_once_t onceToken;

+(BaseRequest*)shared {
    dispatch_once(&onceToken, ^{
        if(_instance == nil) {
            _instance = [[BaseRequest alloc]init];
        }
    });
    return _instance;
}

-(BOOL)beforeExecute:(Response*)response {
    
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return true;
}

-(void)execute:(NSString*)uri params:(NSDictionary*)params callback:(void (^)(Response* response))callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    Response* response = [[Response alloc]init];
    response.manager = manager;
    
//    if (![self beforeExecute:response]) {
//        return;
//    };
    
    [manager POST:uri parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        response.code = responseObject[@"code"];
        response.data = responseObject[@"data"];
        response.messsage = responseObject[@"message"];
        response.success = responseObject[@"success"];
        response.error = nil;
        
        if (response.code.intValue== - 200) {
            
            [self afterExecute:response];
            
        }else{
            
            callback(response);
            
        }
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        response.error = error;
        
        [self afterExecute:response];
        
        callback(response);

    }];
}

-(BOOL)afterExecute:(Response*)response {
    
    if (response.error == nil) {
        [self alertErrorMessage:response.messsage];
    }
    if ([response.error code] == NSURLErrorNotConnectedToInternet) {
        [self alertErrorMessage:@"网络不给力"];
        return FALSE;
    }
    [self alertErrorMessage:@"服务器故障，请稍后再试。"];
    return true;
}

-(void)alertErrorMessage:(NSString *)message
{
    
    [[[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil]show];
}


@end
