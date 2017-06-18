//
//  ContentNavigationViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/29.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentNavigationViewController : UINavigationController

@property (nonatomic, strong) NSString *contentType;
@property (nonatomic) BOOL isOwner;

@end
