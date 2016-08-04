//
//  UIView+Frame.h
//
//
//  Created by Alexcai on 15/6/6.
//  Copyright (c) 2015年 zhidier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat tail;
@property (nonatomic, assign) CGFloat middleX;
@property (nonatomic, assign) CGFloat middleY;

/** 找到view所在的控制器*/
- (UIViewController *)findViewControllerClass:(Class)viewControllerClass;

@end