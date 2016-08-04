//
//  BaseController.h
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRequest.h"
#import <MBProgressHUD.h>

@interface BaseVC : UIViewController

//AFNetworking封装
-(void)post:(NSString*) tag url:(NSString*) url params:(NSDictionary *)params;
-(void)load:(NSString*) tag url:(NSString*) url params:(NSDictionary *)params;
-(void)onRequestFinished:(NSString*)tag response:(Response *)response;

//MBProgressHUD封装
-(void)showHud:(NSString *)text;

@end
