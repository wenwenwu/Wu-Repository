//
//  UserTool.m
//  laboratory
//
//  Created by wuwenwen on 16/7/16.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"

@implementation AccountTool

#define NTAccountPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]

+(void)saveAccount:(Account *)account
{
        
    [NSKeyedArchiver archiveRootObject:account toFile:NTAccountPath];

}

+(Account *)account
{    

    Account *account=[NSKeyedUnarchiver unarchiveObjectWithFile:NTAccountPath];
    
    return account;
}

+(void)deleteAccount
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:NTAccountPath error:nil];

}
@end
