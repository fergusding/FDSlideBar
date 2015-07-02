//
//  FDSlideContentView.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/1.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDSlideContentView.h"

@interface FDSlideContentView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FDSlideContentViewScrollCallback callback;

@property (strong, nonatomic) NSMutableArray *contentsVC;
@property (assign, nonatomic) NSUInteger currentIndex;

@end

@implementation FDSlideContentView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    _currentIndex = 0;
    [self initScrollView];
    [self initContentView];
}

#pragma mark - Custom Accessors

- (NSMutableArray *)contentsVC {
    if (!_contentsVC) {
        _contentsVC = [NSMutableArray array];
        NSInteger num;
        if (self.dataSource) {
            num = [self.dataSource numOfContentView];
        }
        
        // Get the dataSource
        for (int i = 0; i < num; i++) {
            UIViewController *vc = [self.dataSource slideContentView:self viewControllerForIndex:i];
            [_contentsVC addObject:vc];
        }
    }
    return _contentsVC;
}

#pragma mark - Public

- (void)slideContentViewScrollFinished:(FDSlideContentViewScrollCallback)callback {
    _callback = callback;
}

- (void)scrollSlideContentViewToIndex:(NSUInteger)index {
    self.currentIndex = index;
    [self.scrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)) animated:YES];
}

#pragma mark - Private

- (void)initScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    _scrollView = scrollView;
    [self addSubview:_scrollView];
}

- (void)initContentView {
    for (UIViewController *vc in self.contentsVC) {
        NSUInteger index = [self.contentsVC indexOfObject:vc];
        vc.view.frame = CGRectMake(index * CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
        [_scrollView addSubview:vc.view];
    }
    _scrollView.contentSize = CGSizeMake([_contentsVC count] * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSUInteger index = offsetX / CGRectGetWidth(_scrollView.frame);
    self.currentIndex = index;
    _callback(index);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
