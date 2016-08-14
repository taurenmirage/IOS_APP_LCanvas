//
//  SignInViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/12/4.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface SignInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *signOrCreate;
@property (strong, nonatomic) IBOutlet UIButton *createOrSign;
@property (strong, nonatomic) IBOutlet UIImageView *logo;

@property  BOOL usercheck;

@property (strong, nonatomic) NSString *user_id;

@property (strong, nonatomic) NSString *mode;

@property (strong, nonatomic) NSArray *userList;

@property (strong, nonatomic) NSArray *userRecord;

@property (strong, nonatomic) NSString *tempPassword;

@property (strong, nonatomic) NSString *displayName;


@end
