//
//  contentAddTableViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/28.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"
#import "Content.h"

@interface contentAddTableViewController : UITableViewController{
    NSFetchedResultsController  *_fetchResultController;
}

@property (strong, nonatomic) IBOutlet UITextField *content;

@property (nonatomic, strong) NSString *content_id;
@property (nonatomic, strong) NSString *canvas_id;
@property (nonatomic, strong) NSString *content_type;
@property (nonatomic,strong) NSDictionary *contentRecord;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *canvas_type;

@end
