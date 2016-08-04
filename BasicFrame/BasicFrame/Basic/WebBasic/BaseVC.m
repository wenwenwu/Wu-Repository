//
//  BaseController.m
//  IOSNetworkingDemo
//
//  Created by 骆超 on 14-9-21.
//  Copyright (c) 2014年 langwan luo. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@property(weak, nonatomic) MBProgressHUD * postHud;
@property(weak, nonatomic) MBProgressHUD * loadHud;

@end

@implementation BaseVC


-(void)post:(NSString *)tag url:(NSString *)url params:(NSDictionary *)params
{
    
    if (_postHud == nil) {
        
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color=[UIColor clearColor];
        hud.minShowTime = 1;
        
        self.postHud = hud;
        
    }
    
    
    [[BaseRequest shared]execute:url params:params callback:^(Response *response) {
        
        if (_postHud != nil) {
            
            [self.postHud hideAnimated:YES];
            self.postHud = nil;
        }
        
        [self onRequestFinished:tag response:response];
        
    }];
    
}

-(void)load:(NSString *)tag url:(NSString *)url params:(NSDictionary *)params
{
    
    
    if (_loadHud == nil) {
        
        
        MBProgressHUD *loadHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        NSMutableArray *animationImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            [animationImages addObject:image];
        }
        
        UIImageView *customView = [UIImageView new];
        customView.animationImages = animationImages;
        customView.animationDuration = 0.5;
        [customView startAnimating];
        
        loadHud.mode = MBProgressHUDModeCustomView;
        loadHud.customView = customView;
        loadHud.minShowTime = 2;
        loadHud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        loadHud.bezelView.color = [UIColor clearColor];
        
        self.loadHud = loadHud;
        
        
    }
    
    
    [[BaseRequest shared]execute:url params:params callback:^(Response *response) {
        
        if (_loadHud != nil) {
            
            [self.loadHud hideAnimated:YES];
            self.loadHud = nil;
        }
        
        [self onRequestFinished:tag response:response];
        
    }];
    
}

-(void)onRequestFinished:(NSString *)tag response:(Response *)response
{
    
}


-(void)showHud:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.textAlignment = NSTextAlignmentLeft;
    hud.detailsLabel.font = NTFont_13_Light;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color =NTPink_FF00FF;
    hud.bezelView.layer.cornerRadius = 1;    
    hud.margin = 5;
    
    [hud hideAnimated:YES afterDelay:2.f];

}

@end
