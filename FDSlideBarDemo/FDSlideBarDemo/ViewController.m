//
//  AnotherViewController.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/14.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "ViewController.h"
#import "FDSlideBar.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) FDSlideBar *slideBar;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self setupSlideBar];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

// Set up a slideBar and add it into view
- (void)setupSlideBar {
    FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
    sliderBar.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    
    // Init the titles of all the item
    sliderBar.itemsTitle = @[@"要闻", @"视频", @"上海", @"娱乐", @"体育NBA", @"财经", @"科技", @"社会", @"军事", @"时尚", @"汽车", @"游戏", @"图片", @"股票"];
    
    // Set some style to the slideBar
    sliderBar.itemColor = [UIColor whiteColor];
    sliderBar.itemSelectedColor = [UIColor orangeColor];
    sliderBar.sliderColor = [UIColor orangeColor];
    
    // Add the callback with the action that any item be selected
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
    [self.view addSubview:sliderBar];
    _slideBar = sliderBar;
}

// Set up a tableView to show the content
- (void)setupTableView {
    // The frame of tableView, be care the width and height property
    CGRect frame = CGRectMake(0, 0, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.slideBar.frame), CGRectGetWidth(self.view.frame));
    self.tableView = [[UITableView alloc] initWithFrame:frame];
    [self.view addSubview:self.tableView];
    
    // Register the custom cell
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ContentCell"];
    
    // Set the tableView center in the bottom of view. so after rotating, it shows rightly
    self.tableView.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5 + CGRectGetMaxY(self.slideBar.frame) * 0.5);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Rotate the tableView 90 angle anticlockwise
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.slideBar.itemsTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
    
    // Rotate the cell's content 90 angle clockwise to show them rightly
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.text = self.slideBar.itemsTitle[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Height retrun the width of screen
    return CGRectGetWidth(self.view.frame);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:scrollView.contentOffset];
    
    // Select the relating item when scroll the tableView by paging.
    [self.slideBar selectSlideBarItemAtIndex:indexPath.row];
}

@end
