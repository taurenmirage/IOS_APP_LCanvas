//
//  UserTableViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/29.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"

#import "Canvas.h"

@interface UserTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *DisplayName;

@property (strong, nonatomic) NSString *user_id;

@property (strong, nonatomic) NSArray *userRecord;

@end
