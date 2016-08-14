//
//  EditTableViewController.h
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/21.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"

#import "Canvas.h"
#import "Content.h"

@interface EditTableViewController : UITableViewController{
    NSFetchedResultsController  *_fetchResultController;
}
@property (nonatomic,strong) NSDictionary *canvasRecord;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *canvas_id;

@property (nonatomic, strong) NSString *editType;

@property (strong, nonatomic) IBOutlet UITextField *canvasTitle;
@property (strong, nonatomic) IBOutlet UITextField *canvasDescription;

@property (strong, nonatomic) IBOutlet UISwitch *openFlag;
@property (strong, nonatomic) IBOutlet UISwitch *editableFlag;

@property (strong, nonatomic) IBOutlet UILabel *uniqueID;

@property (strong, nonatomic) NSString *owner_user;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *save;

@property (strong, nonatomic) NSString *currentCanvasTitle;

@property (strong, nonatomic) IBOutlet UIButton *modeSelect;

@property (strong, nonatomic) NSString *modelType;

@end
