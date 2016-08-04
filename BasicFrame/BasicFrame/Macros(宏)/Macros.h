//
//  NotificationMacros.h
//  BasicFrame
//
//  Created by wuwenwen on 16/8/2.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Macros : NSObject

#pragma mark-UtilsMacros
//发布的时候移除NSLog
/*__OPTIMIZE__这个编译选项是发布版本才有*/
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//含透明度的十六进制颜色
#define NTColorRGB(rgbValue,opacity) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:opacity]

//屏幕宽度
#define NTScreenWidth ([UIScreen mainScreen].bounds.size.width)

//屏幕高度
#define NTScreenHeight ([UIScreen mainScreen].bounds.size.height)



#pragma mark-AppConstants



#pragma mark-URLConstants
//真实网址
extern NSString *const NTBaseUrl;
//测试网址
extern NSString *const NTBaseUrlTest;



#pragma mark-UIConstants
//导航栏+状态栏高度
extern CGFloat const NTNavigationBarConstant;
//状态栏高度
extern CGFloat const NTStatusBarConstant;
//工具栏高度
extern CGFloat const NTToolBarHeight;

//颜色
#define NTPink_FF00FF NTColorRGB(0xff00ff,0.1);

//字体
#define NTFont_13_Light [UIFont systemFontOfSize:13 weight:UIFontWeightLight];

//默认头像图片名称
extern NSString *const NTDefaultImageName;
//图片加载失败的占位图
extern NSString *const NTDefaultLoadImageName;

//动画时间
UIKIT_EXTERN CGFloat const NTAnimationDuration;



#pragma mark-NotificationConstants
//网络状态通知
extern NSString *const NTNetworkStatusNotificaton;
extern NSString *const NTNetworkStatusNotificatonKey;



#pragma mark-3rdConstants
//友盟
UIKIT_EXTERN  NSString *const UMAppKey ;





@end
