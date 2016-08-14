//
//  CanvasNavigationViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/29.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasNavigationViewController : UINavigationController

@property (nonatomic, strong) NSString *canvasID;
@property (nonatomic, strong) NSString *editType;
@property (nonatomic, strong) NSString *canvasTitle;
@property (nonatomic, strong) NSString *canvasDescripiton;
@property (nonatomic, strong) NSString *openFlag;
@property (nonatomic, strong) NSString *editFlag;


@end
