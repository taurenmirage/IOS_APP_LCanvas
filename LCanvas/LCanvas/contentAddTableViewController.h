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

#import "SuggestContentTableViewController.h"

@protocol addContentDelegate <NSObject>
@optional
- (void)DoSomethingAfterAddContent;

@end

@interface contentAddTableViewController : UITableViewController<CellSelectDelegate>{
    NSFetchedResultsController  *_fetchResultController;
    id <addContentDelegate> delegate;
}

@property (strong, nonatomic) IBOutlet UITextField *content;

@property (nonatomic, strong) NSString *content_id;
@property (nonatomic, strong) NSString *canvas_id;
@property (nonatomic, strong) NSString *suggest_id;
@property (nonatomic, strong) NSString *content_type;
@property (nonatomic,strong) NSDictionary *contentRecord;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *canvas_type;
@property (nonatomic) BOOL isOwner;

@property (nonatomic, assign) id <addContentDelegate> delegate;

@end
