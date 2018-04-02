//
//  LCLScrollView.m
//  LCLScrollView
//
//  Created by lichanglai on 2018/3/31.
//  Copyright © 2018年 sankai. All rights reserved.
//

#import "LCLScrollView.h"

@interface LCLScrollView () <UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSTimer *scrollViewTimer;
@property (nonatomic, assign) BOOL isLocalImage;
@end

@implementation LCLScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)build {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (_images) {
        _isLocalImage = YES;
    }else {
        _isLocalImage = NO;
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(width*3, 0);
    [scrollView setContentOffset:CGPointMake(width, 0)];
    
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        switch (i) {
            case 0:
                _leftImage = imageView;
                break;
            case 1:
                _centerImage = imageView;
                break;
            case 2:
                _rightImage = imageView;
                break;
            default:
                break;
        }
    }
    
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height-10, width, 10)];
    page.numberOfPages = _images.count;
    page.currentPage = _currentIndex;
    page.pageIndicatorTintColor = [UIColor blackColor];
    page.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:page];
    _page = page;

    [self resetContent];
    
    if (_isAutoScroll) {
        [self addTimer];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_isAutoScroll) {
        [self killTimer];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    if (offset > (_currentIndex%3) * scrollView.bounds.size.width) {// right swipe push tag
        if (_currentIndex == _images.count - 1) {
            _currentIndex = 0;
        }else {
            _currentIndex ++;
        }
    }else if (offset < (_currentIndex%3) * scrollView.bounds.size.width) {// left swipe push tag
        if (_currentIndex == 0) {
            _currentIndex = _images.count - 1;
        }else {
            _currentIndex --;
        }
    }
    [self resetContent];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_isAutoScroll) {
        [self addTimer];
    }
}
- (void)killTimer {
    if ([_scrollViewTimer isValid]) {
        [_scrollViewTimer invalidate];
        _scrollViewTimer = nil;
    }
}
- (void)addTimer {
    [self killTimer];
    _scrollViewTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_scrollViewTimer forMode:NSRunLoopCommonModes];
}
- (void)autoScroll {
    if (_currentIndex == _images.count - 1) {
        _currentIndex = 0;
    }else {
        _currentIndex ++;
    }
    [self resetContent];
}
- (void)resetContent {// 防错
    if (_isLocalImage) {
        if (_currentIndex == _images.count - 1) {
            _leftImage.image = _images.count > 1 ? _images[_currentIndex-1] : _images.lastObject;
            _centerImage.image = _images.lastObject;
            _rightImage.image = _images.firstObject;
        }else if (_currentIndex == 0) {
            _leftImage.image = _images.lastObject;
            _centerImage.image = _images.firstObject;
            _rightImage.image = _images.count > 1 ? _images[1] : _images.firstObject;
        }else {
            _leftImage.image = _images.count > 1 ? _images[_currentIndex-1] : _images.lastObject;
            _centerImage.image = _images[_currentIndex];
            _rightImage.image = _images.count > _currentIndex+1 ? _images[_currentIndex+1] : _images.firstObject;
        }
    }
    _page.currentPage = _currentIndex;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
