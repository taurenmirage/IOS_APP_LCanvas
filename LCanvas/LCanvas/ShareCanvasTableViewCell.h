//
//  ShareCanvasTableViewCell.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/5.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCanvasTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *CanvasType;
@property (strong, nonatomic) IBOutlet UILabel *CanvasTitle;
@property (strong, nonatomic) IBOutlet UILabel *CanvasDesc;

@property (nonatomic , strong) NSString *canvasID;
@property (nonatomic , strong) NSString *modelType;

@end
