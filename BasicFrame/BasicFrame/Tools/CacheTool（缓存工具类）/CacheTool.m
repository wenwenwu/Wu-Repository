//
//  CacaeTool.m
//  laboratory
//
//  Created by wuwenwen on 16/7/17.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "CacheTool.h"
#import <FMDB.h>
#import "AccountTool.h"
#import "Account.h"

/** 数据库文件名 */
static NSString * const kCacheDateFile =  @"ZDCacheData.sqlite";
static  FMDatabase *_database;



@implementation CacheTool

// 重写类初始化
+(void)initialize{
    
    //1.获得数据库文件的路径
    NSString *document = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *file = [document stringByAppendingPathComponent:kCacheDateFile];
    //2.获得数据库
    _database = [FMDatabase databaseWithPath:file];
    
}


+ (void)saveDictArray:(NSArray *)dictArray{
    
    // 打开数据库
    if ([_database open]) {
        
        
        // 删除表内容
        [_database executeUpdate:@"DROP TABLE IF EXISTS t_DictArrayTable;"];
        
        
        // 创建表
        [_database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_DictArrayTable (id integer PRIMARY KEY AUTOINCREMENT, dict blob NOT NULL, uid text NOT NULL);"];
        
        // 存入数据库
        Account *account = [AccountTool account];//uid
        
        for (NSDictionary *dict in dictArray) {
            
            NSData *dictData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];//dicData
            
            [_database executeUpdate:@"INSERT INTO t_DictArrayTable (dict, uid) VALUES (?,?);", dictData,account.uid];
        }
    }
    
}

+ (NSArray *)dictArrayFromCache{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    // 打开数据库
    if ([_database open]) {
        
        // 获取当前用户
        Account *account = [AccountTool account];
        // 获取查询结果
        FMResultSet *resualt = [_database executeQuery:@"SELECT * FROM t_DictArrayTable ORDER BY id;",account.uid];
        // 遍历查询结果
        while (resualt.next) {
            // 获取查询到的数据
            NSData *data = [resualt objectForColumnName:@"dict"];
            // 二进制数据转换为字典
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            [dataArray addObject:dataDict];
        }
    }
    return [dataArray copy] ;
    
}




@end
