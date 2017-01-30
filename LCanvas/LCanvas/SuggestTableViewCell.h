//
//  SuggestTableViewCell.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/1/15.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestTableViewCell : UITableViewCell

@property (nonatomic , strong) NSString *suggestID;
@property (strong, nonatomic) NSString *activeFlag;

@property (strong, nonatomic) IBOutlet UILabel *content;


@end
