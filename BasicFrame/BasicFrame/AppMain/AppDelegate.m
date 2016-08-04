//
//  AppDelegate.m
//  BasicFrame
//
//  Created by wenwen wu on 15/5/28.
//  Copyright (c) 2015年 wuwenwen. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseRequest.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
//        // 发送网络状态变更通知
//        [NTNotification postNotificationName:NTNetworkStatusNotificaton object:nil userInfo:@{NTNetworkStatusNotificatonKey:@(currentStatus)}];

        
        //添加 字典，将label的值通过key值设置传递
//        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.textFieldOne.text,@"textOne",self.textFieldTwo.text,@"textTwo", nil];
        //创建通知
//        NSNotification *notification =[NSNotification NetworkStatusNotificaton: object:nil userInfo:dict];
        NSNotification *notification = [NSNotification notificationWithName:NTNetworkStatusNotificaton object:nil userInfo:@{NTNetworkStatusNotificaton:@(status)}];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
