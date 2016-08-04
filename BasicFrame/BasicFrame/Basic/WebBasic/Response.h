//
//  Response.h
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface Response : NSObject

@property(strong, nonatomic) AFHTTPSessionManager* manager;
@property(strong, nonatomic) NSString* tag;
@property(strong, nonatomic) NSError *error;
@property(strong, nonatomic) NSNumber *code;
@property(strong, nonatomic) NSDictionary *data;
@property(strong, nonatomic) NSString *messsage;
@property(strong, nonatomic) NSNumber *success;

 
 
 

@end
