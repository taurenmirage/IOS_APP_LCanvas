//
//  ContentTableViewCell.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/22.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewCell : UITableViewCell

@property (nonatomic , strong) NSString *contentID;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) NSString *activeFlag;

@end
