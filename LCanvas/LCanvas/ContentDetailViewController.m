//
//  ContentDetailViewController.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/12/5.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import "ContentDetailViewController.h"

@interface ContentDetailViewController ()

@end

@implementation ContentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backGroundImage = [UIImage imageNamed:@"back1920"];
    
    self.view.layer.contents = (id)backGroundImage.CGImage;
    
    self.contentDetail.text = self.content;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
