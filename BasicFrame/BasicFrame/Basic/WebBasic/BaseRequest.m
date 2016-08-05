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

-(void)execute:(NSString*)uri params:(NSDictionary*)params callback:(void (^)(Response* response))callback {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
    
    Response* response = [[Response alloc]init];
    response.manager = manager;
    
    [manager POST:uri parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        response.code = responseObject[@"code"];
        response.data = responseObject[@"data"];
        response.messsage = responseObject[@"message"];
        response.success = responseObject[@"success"];
        response.error = nil;
        
        callback(response);

        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        response.error = error;
                
        callback(response);

    }];
}



@end
