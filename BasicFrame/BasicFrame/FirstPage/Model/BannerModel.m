//
//  banner.m
//  BasicFrame
//
//  Created by wuwenwen on 16/8/22.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bannerId" : @"id",
              };
}
@end
