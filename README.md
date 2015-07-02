# FDSlideBar
A custom slide bar like the top slide menu of NTES news client used in iOS.

# Introduction

FDSlideBar is a sliding bar which is muck like the top menu bar of NTES news client. it can scroll the bar and content automaticly with smoth animation. It uses block to receive your deal when you select a itme or scroll the content view to previous or next page. It also support you to set some style such as backgroundColor, font size, text color, selected font size and selected text color and so on.

## ScreenShot

![one](http://7xiamc.com1.z0.glb.clouddn.com/one.png)
![two](http://7xiamc.com1.z0.glb.clouddn.com/two.png)

# Get started

1. Download the source file in the folder FDSlideBar.
2. Add the all source files to your project.
3. Import the FDSlideBar.h and FDSlideContentView.h file where you want to use it. if you didn't use the FDSlideConetntView, you must control the content by yourself.

# Usage

## FDSlideBar

```Objective-C
    FDSlideBar *sliderBar = [[FDSlideBar alloc] init];
    sliderBar.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    sliderBar.itemsTitle = @[@"要闻", @"视频", @"上海", @"娱乐", @"体育NBA", @"财经", @"科技", @"社会", @"军事", @"时尚", @"汽车", @"游戏", @"图片", @"股票"];
    sliderBar.itemColor = [UIColor whiteColor];
    sliderBar.itemSelectedColor = [UIColor orangeColor];
    sliderBar.sliderColor = [UIColor orangeColor];
    
    [sliderBar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [_contentView scrollSlideContentViewToIndex:idx];
    }];
    [self.view addSubview:sliderBar];
```
## FDSlideContentView

```Objective-C
    FDSlideContentView *contentView = [[FDSlideContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sliderBar.frame), CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(sliderBar.frame))];
    [contentView slideContentViewScrollFinished:^(NSUInteger index) {
        // Relate to the slide bar
        [_slideBar selectSlideBarItemAtIndex:index];
    }];
    contentView.dataSource = self;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
```

#License
  MIT
