//
//  NotificationMacros.m
//  BasicFrame
//
//  Created by wuwenwen on 16/8/2.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "Macros.h"

@implementation Macros

#pragma mark-URLConstants
//真实网址
NSString *const NTBaseUrl = @"http://app.naitang.com/v1/";
//测试网址
NSString *const NTBaseUrlTest = @"http://app.naitang.com/v1/test/";



#pragma mark-UIConstants
//导航栏+状态栏高度
CGFloat const NTNavigationBarConstant = 64;
//状态栏高度
CGFloat const NTStatusBarConstant = 20;
//工具栏高度
CGFloat const NTToolBarHeight = 44;

//默认头像图片名称
NSString *const NTDefaultImageName = @"avatar-failure";
//图片加载失败的占位图
NSString *const NTDefaultLoadImageName = @"pic-failure";

//动画时间
CGFloat const NTAnimationDuration = 0.3;



#pragma mark-NotificationConstants
//网络状态通知
NSString * const NTNetworkStatusNotificaton = @"NTNetworkStatusNotificaton";
NSString * const NTNetworkStatusNotificatonKey = @"NTNetworkStatusNotificatonKey";



#pragma mark-3rdConstants
//友盟
NSString *const UMAppKey = @"563abae2e0f55a09a80048f7";


@end
