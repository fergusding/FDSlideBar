//
//  ViewController.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/6/4.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "ViewController.h"
#import "FDSlideBar.h"
#import "FDSlideContentView.h"
#import "NewsViewController.h"

@interface ViewController () <FDSlideContentViewDataSource>

@property (strong, nonatomic) FDSlideBar *slideBar;
@property (strong, nonatomic) FDSlideContentView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // Add a slide bar
    FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
    sliderBar.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    sliderBar.itemsTitle = @[@"要闻", @"视频", @"上海", @"娱乐", @"体育NBA", @"财经", @"科技", @"社会", @"军事", @"时尚", @"汽车", @"游戏", @"图片", @"股票"];
    sliderBar.itemColor = [UIColor whiteColor];
    sliderBar.itemSelectedColor = [UIColor orangeColor];
    sliderBar.sliderColor = [UIColor orangeColor];
    
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        // Relate to the content view
        [_contentView scrollSlideContentViewToIndex:idx];
    }];
    [self.view addSubview:sliderBar];
    _slideBar = sliderBar;
    
    // Add a slide content view
    FDSlideContentView *contentView = [[FDSlideContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sliderBar.frame), CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(sliderBar.frame))];
    [contentView slideContentViewScrollFinished:^(NSUInteger index) {
        // Relate to the slide bar
        [_slideBar selectSlideBarItemAtIndex:index];
    }];
    contentView.dataSource = self;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    _contentView = contentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FDSlideContentViewDataSource

- (NSInteger)numOfContentView {
    return [self.slideBar.itemsTitle count];
}

- (UIViewController *)slideContentView:(FDSlideContentView *)contentView viewControllerForIndex:(NSUInteger)index {
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.labelText = self.slideBar.itemsTitle[index];
    return newsVC;
}

@end
