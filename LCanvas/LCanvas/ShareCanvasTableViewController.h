//
//  ShareCanvasTableViewController.h
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/5.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"

#import "Share+CoreDataClass.h"
#import "Canvas.h"

@interface ShareCanvasTableViewController : UITableViewController{
NSFetchedResultsController  *_fetchResultController;
}
@property (nonatomic,strong) NSArray *canvasList;

@property (nonatomic,strong) NSString *user_id;

@property (nonatomic,strong) NSString *canvas_id;

@property (nonatomic, strong) UIRefreshControl* refreshControl;


@end
