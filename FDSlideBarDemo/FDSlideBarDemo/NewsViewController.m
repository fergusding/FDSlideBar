//
//  ImportantNewsViewController.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/1.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentLabel.text = self.labelText;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
