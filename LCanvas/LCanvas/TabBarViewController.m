//
//  TabBarViewController.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/18.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarItem *item = self.tabBar.items[0];
    
    self.tabBar.tintColor = [UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:240.0/255.0 alpha:1.0];
    
 
  
    
    //[item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]} forState:UIControlStateSelected];
    

    
    
   
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
