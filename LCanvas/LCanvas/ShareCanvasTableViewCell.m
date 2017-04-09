//
//  ShareCanvasTableViewCell.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/5.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "ShareCanvasTableViewCell.h"

@implementation ShareCanvasTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.CanvasType.layer setCornerRadius:21.0]; //设置矩圆角半径
    [self.CanvasType.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [self.CanvasType.layer setBorderColor:colorref];//边框颜色
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
