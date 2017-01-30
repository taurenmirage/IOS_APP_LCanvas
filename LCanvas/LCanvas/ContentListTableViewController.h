//
//  ContentListTableViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/22.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"
#import "contentAddTableViewController.h"

#import "Canvas.h"
#import "Content.h"

@interface ContentListTableViewController : UITableViewController<addContentDelegate>{
    NSFetchedResultsController  *_fetchResultController;
}
@property (nonatomic,strong) NSArray *canvasList;
@property (nonatomic,strong) NSArray *contentList;

@property (nonatomic,strong) NSString *contentType;
@property (nonatomic,strong) NSString *canvasID;
@property (strong, nonatomic) IBOutlet UIButton *viewType;

@property (strong, nonatomic) NSString *viewFlag;

@property (nonatomic,strong) NSDictionary *contentRecord;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *editContentID;

@property (strong, nonatomic) IBOutlet UISegmentedControl *viewControl;

@property (strong, nonatomic) NSString *owner_user;

@property (nonatomic) BOOL isOwner;



@end
