//
//  TableViewCell.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/7/14.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Custom Accessors

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

@end
