//
//  BannerView.m
//  BasicFrame
//
//  Created by wuwenwen on 16/8/22.
//  Copyright © 2016年 wuwenwen. All rights reserved.
//

#import "BannerView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface BannerView () <UIScrollViewDelegate> {
    
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    
    NSUInteger _bannerCount;
}

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation BannerView
#pragma mark-Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
        [self addTimer];
        
    }
    return self;
}


#pragma mark-Setter
- (void)setBannerImages:(NSArray *)bannerImages {
    
    _bannerImages = bannerImages;
    
    [self settingData];
    
    [self settingFrame];
    
}


#pragma mark-Methods
- (void)commonInit {
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.scrollsToTop = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    _leftImageView = [UIImageView new];
    [scrollView addSubview:_leftImageView];
    _centerImageView = [UIImageView new];
    [scrollView addSubview:_centerImageView];
    _rightImageView = [UIImageView new];
    [scrollView addSubview:_rightImageView];
    
    //pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

-(void)settingData{
    
    _bannerCount = _bannerImages.count;
    
    //初始状态
    if (_bannerCount == 0) return;
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_bannerImages[0]] placeholderImage:[UIImage imageNamed:@"failure"]];
    
    if (_bannerCount > 1) [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_bannerImages[_bannerCount-1]] placeholderImage:[UIImage imageNamed:@"failure"]];
    
    if (_bannerCount > 1) [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_bannerImages[1]] placeholderImage:[UIImage imageNamed:@"failure"]];
    
    self.currentImageIndex=0;
    
    _pageControl.currentPage=_currentImageIndex;
    _pageControl.numberOfPages = _bannerCount;
    
}

-(void)settingFrame{
    
    //scrollView
    self.scrollView.frame = self.bounds;
    
    [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    
    NSUInteger sizeCount = _bannerCount > 1 ? 3 : 0;
    self.scrollView.contentSize = CGSizeMake(self.width * sizeCount, 0);//scrollView的滚动范围
    
    _leftImageView.frame = CGRectMake(0, 0, self.width, self.height);
    _centerImageView.frame = CGRectMake(NTScreenWidth, 0, self.width, self.height);
    _rightImageView.frame = CGRectMake(NTScreenWidth * 2, 0, self.width, self.height);
    
    //pageControl
    _pageControl.hidden = _bannerCount < 2;
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_greaterThanOrEqualTo(0);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        
    }];

    
}


- (void)addTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    //当用户在处理其他事情的时候，定时器会停止工作。因此应该把定时器添加到runloop中
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
    
}

-(void)removeTimer
{
    [self.timer invalidate];
    
    //timer被加入了Runloop后，invalidate 的调用会使得timer被release（由Runloop控制），所以保持一个指向timer的强引用是不安全的。
    self.timer = nil;
    
}

-(void)nextPage{
    
    if (_bannerCount == 0) return;
    
    if (_bannerCount > 1) {
        
        [self.scrollView setContentOffset:CGPointMake(NTScreenWidth * 2, 0) animated:YES];
        
    }
    
}


- (void)resetImages {
    /**
     *  永远保持中图居中、右图居右、左图居左；中图当前图，右图下一张，左图最后一张
     */
    CGPoint offset = [_scrollView contentOffset];
    if (offset.x > NTScreenWidth) { //向右滑动
        self.currentImageIndex = (_currentImageIndex + 1) % _bannerCount;
    }else if(offset.x < NTScreenWidth) { //向左滑动
        self.currentImageIndex = (_currentImageIndex + _bannerCount - 1) % _bannerCount;
    }
    NSUInteger leftBannerIndex  = (_currentImageIndex + _bannerCount - 1) % _bannerCount;
    NSUInteger rightBannerIndex = (_currentImageIndex + 1) % _bannerCount;
    
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_bannerImages[_currentImageIndex]] placeholderImage:[UIImage imageNamed:@"failure"]];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_bannerImages[leftBannerIndex]] placeholderImage:[UIImage imageNamed:@"failure"]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_bannerImages[rightBannerIndex]] placeholderImage:[UIImage imageNamed:@"failure"]];
    
    [_scrollView setContentOffset:CGPointMake(NTScreenWidth, 0) animated:NO];//因为和滑动一致，故看不出变化
    
    //设置分页
    _pageControl.currentPage = _currentImageIndex;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
//非人为拖拽scrollView导致滚动完毕
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self resetImages];
}
//人为拖拽scrollView导致滚动完毕
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self resetImages];
}

@end
