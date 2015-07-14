# FDSlideBar
A custom slide bar like the top slide menu of NTES news client used in iOS.

# Introduction

FDSlideBar is a sliding bar which is muck like the top menu bar of NTES news client. it can scroll the bar and content automaticly with smoth animation. It uses block to receive your deal when you select a itme or scroll the content view to previous or next page. It also support you to set some style such as backgroundColor, font size, text color, selected font size and selected text color and so on. Now I achieve the content by using table view. so it will benefit much from table view, there will be no memory problem and the original animation will surpport better.

## Preview

![preview](http://7xiamc.com1.z0.glb.clouddn.com/效果.gif)

## ScreenShot

![one](http://7xiamc.com1.z0.glb.clouddn.com/one.png)
![two](http://7xiamc.com1.z0.glb.clouddn.com/two.png)

# Get started

1. Download the source file in the folder FDSlideBar.
2. Add the FDSlideBar.h and FDSlideBar.m files to your project.
3. Import the FDSlideBar.h file where you want to use it. The new achievement will advise you to use it with table view.

# Usage

- There are the key code, others you must read them in the demo for the detail.

## FDSlideBar

```Objective-C
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
```
## Setup TableView

```Objective-C
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
```

## Setup TableView Cell

```Objective-C
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
    
    // Rotate the cell's content 90 angle clockwise to show them rightly
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.text = self.slideBar.itemsTitle[indexPath.row];
    return cell;
}
```

#License
  MIT
