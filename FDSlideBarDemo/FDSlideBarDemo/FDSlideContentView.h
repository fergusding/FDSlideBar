//
//  FDSlideContentView.h
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/1.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FDSlideContentViewScrollCallback)(NSUInteger index);

@protocol FDSlideContentViewDataSource;
//@protocol FDSlideContentViewDelegate;

@interface FDSlideContentView : UIView

@property (weak, nonatomic) id<FDSlideContentViewDataSource> dataSource;
//@property (weak, nonatomic) id<FDSlideContentViewDelegate> delegate;

// Add the calback when the slide content view be scrolled completely
- (void)slideContentViewScrollFinished:(FDSlideContentViewScrollCallback)callback;

// Set the slide content view to show content at index
- (void)scrollSlideContentViewToIndex:(NSUInteger)index;

@end

@protocol FDSlideContentViewDataSource <NSObject>

// Get the view controller for the index of the content view
- (UIViewController *)slideContentView:(FDSlideContentView *)contentView viewControllerForIndex:(NSUInteger)index;

// Get the num of content view
- (NSInteger)numOfContentView;

@end
