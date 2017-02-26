//
//  ViewController.h
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

@interface ViewController : UIViewController{
    NSFetchedResultsController  *_fetchResultController;
    NSFetchedResultsController  *_fetchContentResultController;
}
@property (nonatomic,strong) NSArray *canvasList;
@property (nonatomic,strong) NSArray *contentList;

@property (nonatomic,strong) NSArray *searchForUniqueCanvas;

@property (nonatomic,strong) NSMutableArray *canvasListForPicker;

@property (nonatomic,strong) NSString *content_type;
@property (nonatomic,strong) NSString *editType;

@property (nonatomic,strong) NSString *user_id;

@property (nonatomic,strong) NSString *canvas_id;

@property (nonatomic,strong) NSString *currentCanvasTitle;
@property (nonatomic,strong) NSString *currentCanvasType;

@property (nonatomic,strong) NSString *uniqueID;

@property (strong, nonatomic) IBOutlet UILabel *addNew;

@property (nonatomic,strong) NSString *canvasDescription;
@property (nonatomic,strong) NSString *cTitle;
@property (nonatomic,strong) NSString *openFlag;
@property (nonatomic,strong) NSString *editFlag;


@property (strong, nonatomic) IBOutlet UIButton *report;


@property (strong, nonatomic) IBOutlet UIButton *problem;
@property (strong, nonatomic) IBOutlet UIButton *solution;
@property (strong, nonatomic) IBOutlet UIButton *keyMetrics;
@property (strong, nonatomic) IBOutlet UIButton *uniqueValue;
@property (strong, nonatomic) IBOutlet UIButton *unfairAdvantage;
@property (strong, nonatomic) IBOutlet UIButton *customerSegments;
@property (strong, nonatomic) IBOutlet UIButton *channels;
@property (strong, nonatomic) IBOutlet UIButton *costStructure;
@property (strong, nonatomic) IBOutlet UIButton *revenueStream;

@property (strong, nonatomic) IBOutlet UIButton *generatePDF;

@property (strong, nonatomic) IBOutlet UIButton *canvasTitle;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editCanvas;

@property (strong, nonatomic) NSArray *pickerData;

@end

