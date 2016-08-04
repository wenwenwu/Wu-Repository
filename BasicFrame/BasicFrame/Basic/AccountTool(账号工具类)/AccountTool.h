//
//  UserTool.h
//  laboratory
//
//  Created by wuwenwen on 16/7/16.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;

@interface AccountTool : NSObject

+(void)saveAccount:(Account *)account;
+(Account *)account;
+(void)deleteAccount;

@end
