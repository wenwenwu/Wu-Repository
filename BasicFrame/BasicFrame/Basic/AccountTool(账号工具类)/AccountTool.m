//
//  UserTool.m
//  laboratory
//
//  Created by wuwenwen on 16/7/16.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"
#import <MJExtension.h>

@implementation AccountTool

+(void)saveAccount:(Account *)account
{
        
    NSData *dataAccount=[NSKeyedArchiver archivedDataWithRootObject:account];
    [[NSUserDefaults standardUserDefaults]setObject:dataAccount forKey:@"account"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    

}

+(Account *)account
{
    NSData *dataAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
    Account *account=[NSKeyedUnarchiver unarchiveObjectWithData:dataAccount];
    
    
    
    return account;
}

+(void)deleteAccount
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"account"];
}
@end
