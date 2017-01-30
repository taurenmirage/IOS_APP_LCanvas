//
//  SuggestContentTableViewController.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/1/15.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"

#import "Suggest+CoreDataClass.h"

@protocol CellSelectDelegate <NSObject>
@optional
- (void)DoSomethingEveryCellSelect:(NSString *)values passSuggestId:(NSString *)suggest_id;

@end

@interface SuggestContentTableViewController : UITableViewController{
    NSFetchedResultsController  *_fetchResultController;
    id <CellSelectDelegate> delegate;
}
@property (nonatomic,strong) NSArray *suggestList;
@property (nonatomic,strong) NSString *content_type;
@property (nonatomic, strong) NSString *canvas_type;
@property (nonatomic,strong) NSString *selectSuggestID;

@property (nonatomic, assign) id <CellSelectDelegate> delegate;

@end
