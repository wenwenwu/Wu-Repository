//
//  NiulanVC.m
//  BasicFrame
//
//  Created by wuwenwen on 16/8/2.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "NiulanVC.h"
#import "Account.h"
#import "AccountTool.h"
#import "CacheTool.h"

@interface NiulanVC ()

@end

@implementation NiulanVC

#pragma mark-Load
- (void)viewDidLoad {

    
    [super viewDidLoad];
    
    
    
    //归档实践
    Account *account = [Account new];
    account.name = @"邬大猴";
    account.uid = @"11261";
    account.age = 13;
    //存
    [AccountTool saveAccount:account];
    //取
    Account *account2 = [AccountTool account];
    NSLog(@"归档实践 name:%@,uid:%@,age:%d",account2.name,account2.uid,account2.age);
    
    
    //sql实践
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png"
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png"
                               }
                           ];
    //存
    [CacheTool saveDictArray:dictArray];
    //取
    NSArray *dicArray2 = [CacheTool dictArrayFromCache];
    NSLog(@"sql实践 %@",dicArray2);

    
//    NSDictionary *paramsNiulan=@{
//                                 @"uid":@"12158",
//                                 @"phone":@"iPhone Simulator",
//                                 @"screenScale":@"2",
//                                 @"loginClient":@"1AE33169-17AA-4631-81D2-3F4857CA39DE",
//                                 @"appver":@"3.0.0",
//                                 @"loginToken":@"842647d4771240e9ba5f95cf56e7946c",
//                                 @"time":@"1469779148",
//                                 @"key":@"5bffa9bdba6734e9",
//                                 @"platform":@"iOS",
//                                 @"imei":@"1AE33169-17AA-4631-81D2-3F4857CA39DE",
//                                 @"osver":@"9.3",
//                                 @"screenWidth":@"375",
//                                 };
//    
//    
//    [self load:@"niulanList" url:@"explore/getBanner" params:paramsNiulan];
    
    
    
    //通知中心对特定通知添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:NTNetworkStatusNotificaton object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Actions
- (IBAction)saveButtonAction:(id)sender {
    
    [self showHud:@"保存失败，请重试保存失败，请重试保存失败请重试保存失败，请重试保存失败"];
}
#pragma mark-Methods
-(void)networkStatusChanged:(NSNotification *)notification{
    
    NSInteger statusInteger = [notification.userInfo[NTNetworkStatusNotificatonKey] integerValue];
    NSLog(@"乌溜溜%@",AFStringFromNetworkReachabilityStatus(statusInteger));
    
}

#pragma mark-Response
-(void)onRequestFinished:(NSString *)tag response:(Response *)response {
    
    
    if([tag isEqualToString:@"niulanList"]) {
        
        NSLog(@"%f",self.view.bottom);
        
        
        if (response.error) {
            
            
            NSError *error = response.error;
            NSLog(@"错了个错 :%@",error);
            
        }else{
            
            
            NSNumber *code = response.code;
            NSDictionary *data = response.data;
            NSString *message = response.messsage;
            NSNumber *sucess = response.success;
            
            NSLog(@"code :%@ ,data : %@,message : %@,sucess : %@",code,data,message,sucess);
            
            
            
        }
        
        
    }
    
    
    
}

@end