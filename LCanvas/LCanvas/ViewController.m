//
//  ViewController.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/21.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import "ViewController.h"
#import "ConstURL.h"
#import "ContentListTableViewController.h"
#import "CanvasNavigationViewController.h"
#import <CoreText/CoreText.h>
#import <MessageUI/MessageUI.h>



@interface ViewController ()<NSFetchedResultsControllerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setButton];
    
   
    
    [self setButtonVisible:YES];
    
    self.addNew.hidden = YES;
    
    UIImage *backGroundImage = [UIImage imageNamed:@"back1920"];
    
    //backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];

    self.view.layer.contents = (id)backGroundImage.CGImage;
    //self.view.backgroundColor = [UIColor colorWithPatternImage: backGroundImage ];
    
    
    
    [self readNSUserDefaults];
    
    [self setButtonTitleByType];
    
    //[self saveToUserDefault];
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)setButton{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    self.problem.frame = CGRectMake(5, 80, width/2.5, height/8);
    //[self.problem setBounds:CGRectMake(0, 0, width, height)];
    self.solution.frame = CGRectMake(5, 80 + height/8 +10, width/3, height/8);
    self.keyMetrics.frame = CGRectMake(5, 80 + height/8*2 +20, width/3, height/8);
    self.costStructure.frame = CGRectMake(5, 80 + height/8*3 +30, width/2.5, height/8);
    self.customerSegments.frame = CGRectMake(width - width/2.5 -5, 80 , width/2.5, height/8);
    self.unfairAdvantage.frame = CGRectMake(width - width/3 -5, 80 + height/8 +10, width/3, height/8);
    self.channels.frame = CGRectMake(width - width/3 -5, 80 + height/8*2 +20, width/3, height/8);
    self.revenueStream.frame = CGRectMake(width - width/2.5 -5, 80 + height/8*3 +30, width/2.5, height/8);
    
    self.uniqueValue.frame = CGRectMake(width/2 - width/8, 80 + height/8 +10, width/4, height/8*2 + 10);
    
    self.report.frame = CGRectMake(5, height-110, width/4, 100);
    
    self.generatePDF.frame = CGRectMake(width - width/4 - 5, height-110, width/4, 100);
    
    
    [self.problem.layer setMasksToBounds:YES];
    [self.problem.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.problem.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [self.problem.layer setBorderColor:colorref];//边框颜色

    [self.solution.layer setMasksToBounds:YES];
    [self.solution.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.solution.layer setBorderWidth:1.0];   //边框宽度
    [self.solution.layer setBorderColor:colorref];//边框颜色
    
    [self.keyMetrics.layer setMasksToBounds:YES];
    [self.keyMetrics.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.keyMetrics.layer setBorderWidth:1.0];   //边框宽度
    [self.keyMetrics.layer setBorderColor:colorref];//边框颜色
    
    [self.uniqueValue.layer setMasksToBounds:YES];
    [self.uniqueValue.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.uniqueValue.layer setBorderWidth:1.0];   //边框宽度
    [self.uniqueValue.layer setBorderColor:colorref];//边框颜色
    
    [self.unfairAdvantage.layer setMasksToBounds:YES];
    [self.unfairAdvantage.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.unfairAdvantage.layer setBorderWidth:1.0];   //边框宽度
    [self.unfairAdvantage.layer setBorderColor:colorref];//边框颜色
    
    [self.customerSegments.layer setMasksToBounds:YES];
    [self.customerSegments.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.customerSegments.layer setBorderWidth:1.0];   //边框宽度
    [self.customerSegments.layer setBorderColor:colorref];//边框颜色
    
    [self.costStructure.layer setMasksToBounds:YES];
    [self.costStructure.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.costStructure.layer setBorderWidth:1.0];   //边框宽度
    [self.costStructure.layer setBorderColor:colorref];//边框颜色
    
    [self.channels.layer setMasksToBounds:YES];
    [self.channels.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.channels.layer setBorderWidth:1.0];   //边框宽度
    [self.channels.layer setBorderColor:colorref];//边框颜色
    
    
    
    [self.revenueStream.layer setMasksToBounds:YES];
    [self.revenueStream.layer setCornerRadius:8.0]; //设置矩圆角半径
    [self.revenueStream.layer setBorderWidth:1.0];   //边框宽度
    [self.revenueStream.layer setBorderColor:colorref];//边框颜色
    
    //self.generatePDF.hidden = true;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
     
        
    }
    
    
}


-(void)getCurrentCanvasAndSetCanvasList{
    self.pickerData= self.canvasListForPicker;
    
    if ([self.pickerData count]>0)
    {
        if ([self.currentCanvasTitle isEqualToString:@""]) {
        
            NSRange range = [[_pickerData objectAtIndex:0] rangeOfString:@"|"];

            self.canvas_id = [[_pickerData objectAtIndex:0] substringFromIndex:range.location+1];
            self.currentCanvasTitle = [[[_pickerData objectAtIndex:0] substringToIndex:range.location] stringByAppendingString:@" ▾"];
            [self.canvasTitle setTitle:self.currentCanvasTitle forState:UIControlStateNormal];
            [self fetchDataFromCoreData];
            [self fetchCurrentCanvasTypeFromCoreData];
            [self saveToUserDefault];
            
        }
        else
        {
            [self.canvasTitle setTitle:self.currentCanvasTitle forState:UIControlStateNormal];

           
        }
        
    }
    else
    {
        self.currentCanvasTitle = @"";
    }
    
}

- (void) fetchDataFromCoreData{
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[Canvas entity] context:mainContext];
    
    
    _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:mainContext
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    [_fetchResultController setDelegate:self];
    [_fetchResultController performFetch:nil];
    
    NSString *tempForPicker;
    
     self.canvasListForPicker = [NSMutableArray arrayWithCapacity:[_fetchResultController.fetchedObjects count]];
    
    for (NSInteger i =0 ; i < [_fetchResultController.fetchedObjects count]; i++) {
        Canvas *record = [_fetchResultController.fetchedObjects objectAtIndex:i];
        
        tempForPicker = record.canvas_title;
        tempForPicker = [tempForPicker stringByAppendingString:@"|"];
        tempForPicker = [tempForPicker stringByAppendingString:[record valueForKeyPath:@"canvas_id"]];
        
        [self.canvasListForPicker addObject:tempForPicker];
    }
    
}

- (void) fetchCurrentCanvasTypeFromCoreData{
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[Canvas entity] context:mainContext];
    
    if ([self.canvas_id isEqualToString:@""])
    {
        NSLog(@"No Canvas ID for fetch canvas type");
    }
    else
    {
        [fetchRequest fetchObjectWithValue:self.canvas_id forAttributes:@"canvas_id" error:nil];
    _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:mainContext
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    }
    
    [_fetchResultController setDelegate:self];
    [_fetchResultController performFetch:nil];
    
    Canvas *record = [_fetchResultController.fetchedObjects objectAtIndex:0];
    
    self.currentCanvasType = record.model_type;
    
    
}

- (void) fetchContentDataFromCoreData{
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[Content entity] context:mainContext];
    
    if ([self.canvas_id isEqualToString:@""])
    {
        NSLog(@"No Canvas");
    }
    else if(self.canvas_id == nil)
    {
        NSLog(@"No Canvas");
    }
    else
    {

            NSString *predicates;
            
            predicates = @"active_flag == 1 ";
            
        
            predicates = [predicates stringByAppendingString:@" and canvas_id == "];
            
            predicates = [predicates stringByAppendingString:self.canvas_id];
            
            [fetchRequest fetchObjectWithPredicates:predicates error:nil];
            _fetchContentResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                         managedObjectContext:mainContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
        
    }
    
    
    [_fetchContentResultController setDelegate:self];
    [_fetchContentResultController performFetch:nil];
    
    
    
}



-(void)viewDidAppear:(BOOL)animated{
    

    
    
    [self readNSUserDefaults];
    
    


    
    [self fetchCanvasList];
    
    if (![self.canvas_id isEqualToString:@""] && self.canvas_id != nil)
    {
        [self fetchCanvasListByCanvasID];
    }
    
    [self fetchDataFromCoreData];
    
    [self getCurrentCanvasAndSetCanvasList];
    
    [self setButtonTitleByType];
    
    if ([self.canvasList count]>0)
    {
        dispatch_async(dispatch_queue_create("fetch-canvasList", 0), ^{
            [self fetchContentList];
        });
    }

    
    //[self readNSUserDefaults];
    if ([self.user_id isEqualToString:@""]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (IBAction)report:(UIButton *)sender {
    UIAlertController *reportController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"report" , nil ) message:NSLocalizedString ( @"msg007" , nil ) preferredStyle:UIAlertControllerStyleAlert];
    
  
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"canncel" , nil ) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self SaveReportToServer];
   
        
    }];
    
    [reportController addAction:cancelAction];
    [reportController addAction:okAction];
    
    [self presentViewController:reportController animated:YES completion:nil];

}



-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"currentCanvasID"];
    self.canvas_id = myString;
    
    myString = [userDefaultes stringForKey:@"userID"];
    self.user_id = myString;
    
    myString = [userDefaultes stringForKey:@"currentCanvasTitle"];
    self.currentCanvasTitle = myString;
    
    myString = [userDefaultes stringForKey:@"currentCanvasType"];
    self.currentCanvasType = myString;
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerData count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *tempCanvasTitle;
    
    NSRange range = [[_pickerData objectAtIndex:row] rangeOfString:@"|"];
    
    //int location = range.location;
    
    //int leight = range.length;
    
    NSString *tempCanvasID;
    
    
    tempCanvasID = [[_pickerData objectAtIndex:row] substringFromIndex:range.location+1];
    // 使用一个UIAlertView来显示用户选中的列表项
    self.canvas_id = tempCanvasID;
    self.currentCanvasTitle = [[[_pickerData objectAtIndex:row] substringToIndex:range.location] stringByAppendingString:@" ▾"];
    
    tempCanvasTitle = [[_pickerData objectAtIndex:row] substringToIndex:range.location];
    
    return tempCanvasTitle;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    NSString *tempCanvasID;
    
    NSRange range = [[_pickerData objectAtIndex:row] rangeOfString:@"|"];
    
    tempCanvasID = [[_pickerData objectAtIndex:row] substringFromIndex:range.location+1];
    // 使用一个UIAlertView来显示用户选中的列表项
    self.canvas_id = tempCanvasID;
    self.currentCanvasTitle = [[[_pickerData objectAtIndex:row] substringToIndex:range.location] stringByAppendingString:@" ▾"];
    

}

- (IBAction)canvasTitle:(UIButton *)sender {
    
    UIPickerView *pickerView;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    pickerView.delegate=self;
    pickerView.showsSelectionIndicator=YES;
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:NSLocalizedString ( @"msg003" , nil ) preferredStyle:UIAlertControllerStyleActionSheet];
    
 
    [alertController.view addSubview:pickerView];

    
    
    
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
      
  
     
        [self.canvasTitle setTitle:self.currentCanvasTitle forState:UIControlStateNormal];
        
        [self fetchCurrentCanvasTypeFromCoreData];
        
        [self saveToUserDefault];

        [self setButtonTitleByType];

        
       // NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        
        
        // NSLog(@"%@",dateString);
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString ( @"canncel" , nil ) style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:ok];
    
    [alertController addAction:cancel];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
        //iPad 版本代码;
        [alertController setModalPresentationStyle:UIModalPresentationPopover];
        
        UIPopoverPresentationController *popPresenter = [alertController
                                                         popoverPresentationController];
        
        popPresenter.sourceView = self.canvasTitle;
        popPresenter.sourceRect = self.canvasTitle.bounds;
    }
    
    if ([self.canvasList count] != 0) {
          [self presentViewController:alertController animated:YES completion:nil];
    }
    
   
    
}

- (IBAction)doCanvas:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"msg004" , nil )message:@"" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"canncel" , nil ) style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *newAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"new" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
        self.editType = @"0";
        [self performSegueWithIdentifier:@"showCanvas" sender:nil];
        
    }];
    
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"edit" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
        self.editType = @"1";
        [self performSegueWithIdentifier:@"showCanvas" sender:nil];
        
    }];
    
    UIAlertAction *searchAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"search" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
  
        
        UIAlertController *searchController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"search" , nil ) message:NSLocalizedString ( @"msg005" , nil ) preferredStyle:UIAlertControllerStyleAlert];
        
        [searchController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = NSLocalizedString ( @"uniqueid" , nil );
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"canncel" , nil ) style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ([searchController.textFields.firstObject.text isEqualToString:@""]) {
                //[searchController.textFields.firstObject becomeFirstResponder];
            }
            else
            {
                self.uniqueID = [searchController.textFields.firstObject.text uppercaseString];
                [self fetchCanvasByUniqueIDList];
            }
            
        }];
        
        [searchController addAction:cancelAction];
        [searchController addAction:okAction];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
            //iPad 版本代码;
            [alertController setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [alertController
                                                             popoverPresentationController];
            
             popPresenter.barButtonItem = self.editCanvas;
        }
        
        [self presentViewController:searchController animated:YES completion:nil];
        
     
        
    }];
    
    [alertController addAction:cancelAction];
    if ([self.canvasList count] != 0) {
        [alertController addAction:editAction];
    }
    [alertController addAction:newAction];
    [alertController addAction:searchAction];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
        //iPad 版本代码;
        [alertController setModalPresentationStyle:UIModalPresentationPopover];
        
        UIPopoverPresentationController *popPresenter = [alertController
                                                         popoverPresentationController];
        
        popPresenter.barButtonItem = self.editCanvas;
    }
    
    
    [self presentViewController:alertController animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchCanvasList{
    
    self.canvasList = nil;
    
 
    NSString *tempURL;
    NSString *userID;
    
    userID = self.user_id;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/canvas/"];
    tempURL = [tempURL stringByAppendingString:userID];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:&error];
    
    NSLog(@"Error: %@", error);
    
    if (error != nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"error" , nil ) message:NSLocalizedString ( @"connecterror" , nil ) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    
    }
    else{
        NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:response options:0 error:NULL ];
        
        self.canvasList = (NSArray *)propertyListResults;
        
        NSLog(@"CanvasList = %@",self.canvasList);
        
        if ([self.canvasList count] != 0) {
            [self setButtonVisible:NO];
            [self setButtonTitleByType];
            [self saveCanvasDataToCoreData];
        }
        else
        {
            
            [self setButtonVisible:YES];

        }
       
        
    }

}

- (void)fetchCanvasListByCanvasID{
    

    
    
    NSString *tempURL;
   
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/canvasbyid/"];
    tempURL = [tempURL stringByAppendingString:self.canvas_id];
    
    self.searchForUniqueCanvas = nil;
    
    
    
    NSURL *url= [NSURL URLWithString:tempURL];
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:&error];
    
    NSLog(@"Error: %@", error);
    
    if (error != nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"error" , nil ) message:NSLocalizedString ( @"connecterror" , nil ) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:response options:0 error:NULL ];
        
        self.searchForUniqueCanvas = (NSArray *)propertyListResults;
        
        NSLog(@"CanvasByUnqueidList = %@",self.searchForUniqueCanvas);
        
        if (self.searchForUniqueCanvas != nil) {
            [self setButtonVisible:NO];
            [self setButtonTitleByType];
            [self saveSearchByCanvasIDCanvasDataToCoreData];
            
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"failed" , nil ) message:NSLocalizedString ( @"msg006" , nil ) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
        
    }
    
}

- (void)setButtonVisible:(BOOL) visible{
    self.solution.hidden = visible;
    self.problem.hidden = visible;
    self.keyMetrics.hidden = visible;
    self.uniqueValue.hidden = visible;
    self.channels.hidden = visible;
    self.costStructure.hidden =visible;
    self.unfairAdvantage.hidden = visible;
    self.revenueStream.hidden = visible;
    self.report.hidden = visible;
    self.generatePDF.hidden = visible;
    self.customerSegments.hidden = visible;
    
    if (visible != NO) {
        self.addNew.hidden = NO;
    }
    else
    {
        self.addNew.hidden = YES;
    }
    
}

- (void)fetchCanvasByUniqueIDList{
    
    self.searchForUniqueCanvas = nil;
    
    
    NSString *tempURL;
    //NSString *userID;
    
    //userID = @"1";
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/canvascheck/?uniqueid="];
    tempURL = [tempURL stringByAppendingString:self.uniqueID];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:&error];
    
    NSLog(@"Error: %@", error);
    
    if (error != nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"error" , nil ) message:NSLocalizedString ( @"connecterror" , nil ) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:response options:0 error:NULL ];
        
        self.searchForUniqueCanvas = (NSArray *)propertyListResults;
        
        NSLog(@"CanvasByUnqueidList = %@",self.searchForUniqueCanvas);
        
        if (self.searchForUniqueCanvas != nil) {
            [self saveSearchByUniqueIDCanvasDataToCoreData];
            
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"failed" , nil ) message:NSLocalizedString ( @"msg006" , nil ) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
        
    }
    
}

- (void)fetchContentList{
    
    self.contentList = nil;
    
    
    NSString *tempURL;
    NSString *canvasID;
    
    canvasID = self.canvas_id;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/content/"];
    tempURL = [tempURL stringByAppendingString:canvasID];
    
    
    
    NSURL *url= [NSURL URLWithString:tempURL];
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest: request returningResponse:nil error:&error];
    
    
    NSLog(@"Error: %@", error);
    
    if (error != nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"error" , nil ) message:NSLocalizedString ( @"connecterror" , nil ) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:response options:0 error:NULL ];

        self.contentList = (NSArray *)propertyListResults;
        
        NSLog(@"ContentList = %@",self.contentList);
        
        [self saveContentDataToCoreData];
        
    }
    
}

- (void) saveContentDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    NSArray *record;
    
    for (NSUInteger i = 0; i < [self.contentList count]; i++)
    {
        
        record = [self.contentList valueForKey:[ NSString  stringWithFormat:  @"%lu" , (unsigned long)i]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        Content *content = [Content insertWithContext:context withValue:[record valueForKeyPath:@"content_id"] forAttribute:@"content_id"];
        
        
        content.content = [record valueForKeyPath:@"content"];
        content.content_type= [record valueForKeyPath:@"content_type"];
        content.display_name = [record valueForKeyPath:@"display_name"];
        content.canvas_id = [record valueForKeyPath:@"canvas_id"];
        content.create_user = [record valueForKeyPath:@"create_user"];
        content.active_flag = [record valueForKeyPath:@"active_flag"];
        content.create_date = [dateFormatter dateFromString:[record valueForKeyPath:@"create_date"]];
        
        [context commitUpdate];
    }
}

- (void) saveCanvasDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    NSArray *record;
    NSString *tempForPicker;
    
    self.canvasListForPicker = [NSMutableArray arrayWithCapacity:[self.canvasList count]];
    
    for (NSUInteger i = 0; i < [self.canvasList count]; i++)
    {
        
        record = [self.canvasList valueForKey:[ NSString  stringWithFormat:  @"%lu" , (unsigned long)i]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        Canvas *canvas = [Canvas insertWithContext:context withValue:[record valueForKeyPath:@"canvas_id"] forAttribute:@"canvas_id"];
        
        tempForPicker = [record valueForKeyPath:@"canvas_title"];
        tempForPicker = [tempForPicker stringByAppendingString:@"|"];
        tempForPicker = [tempForPicker stringByAppendingString:[record valueForKeyPath:@"canvas_id"]];
        
        //[self.canvasListForPicker addObject:tempForPicker];
        canvas.canvas_title = [record valueForKeyPath:@"canvas_title"];
        canvas.canvas_description = [record valueForKeyPath:@"canvas_description"];
        canvas.unique_id = [record valueForKeyPath:@"unique_id"];
        canvas.owner_user = [record valueForKeyPath:@"owner_user"];
        canvas.display_name = [record valueForKeyPath:@"display_name"];;
        canvas.open_flag = [record valueForKeyPath:@"open_flag"];
        canvas.editable_flag = [record valueForKeyPath:@"editable_flag"];
        canvas.model_type = [record valueForKeyPath:@"model_type"];
        canvas.create_user = [record valueForKeyPath:@"create_user"];
        canvas.active_flag = [record valueForKeyPath:@"active_flag"];
        canvas.create_date = [dateFormatter dateFromString:[record valueForKeyPath:@"create_date"]];
        
        [context commitUpdate];
    }
}

- (void) saveSearchByCanvasIDCanvasDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    NSArray *record;
    NSString *tempForPicker;
    
    //self.canvasListForPicker = [NSMutableArray arrayWithCapacity:[self.canvasList count]];
    
    record = [self.searchForUniqueCanvas valueForKey:[ NSString  stringWithFormat:  @"%lu" , (unsigned long)0]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    Canvas *canvas = [Canvas insertWithContext:context withValue:[record valueForKeyPath:@"canvas_id"] forAttribute:@"canvas_id"];
    
    tempForPicker = [record valueForKeyPath:@"canvas_title"];
    tempForPicker = [tempForPicker stringByAppendingString:@"|"];
    tempForPicker = [tempForPicker stringByAppendingString:[record valueForKeyPath:@"canvas_id"]];
    
    self.canvas_id = [record valueForKeyPath:@"canvas_id"];
    
    self.currentCanvasTitle = [[record valueForKeyPath:@"canvas_title"] stringByAppendingString:@"▾"];
    
    self.currentCanvasType = [record valueForKeyPath:@"model_type"];
    
    [self saveToUserDefault];
    
    [self setButtonTitleByType];
    
    [self.canvasTitle setTitle:self.currentCanvasTitle forState:UIControlStateNormal];
    
    [self.canvasListForPicker addObject:tempForPicker];
    canvas.canvas_title = [record valueForKeyPath:@"canvas_title"];
    canvas.canvas_description = [record valueForKeyPath:@"canvas_description"];
    canvas.display_name = [record valueForKeyPath:@"display_name"];
    canvas.open_flag = [record valueForKeyPath:@"open_flag"];
    canvas.unique_id = [record valueForKeyPath:@"unique_id"];
    canvas.editable_flag = [record valueForKeyPath:@"editable_flag"];
    canvas.create_user = [record valueForKeyPath:@"create_user"];
    canvas.model_type = [record valueForKeyPath:@"model_type"];
    canvas.active_flag = [record valueForKeyPath:@"active_flag"];
    canvas.create_date = [dateFormatter dateFromString:[record valueForKeyPath:@"create_date"]];
    
    [context commitUpdate];
    
    
    [self fetchContentList];
    
}

- (void) saveSearchByUniqueIDCanvasDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    NSArray *record;
    NSString *tempForPicker;
    
    //self.canvasListForPicker = [NSMutableArray arrayWithCapacity:[self.canvasList count]];
    
    
    record = [self.searchForUniqueCanvas objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    Canvas *canvas = [Canvas insertWithContext:context withValue:[record valueForKeyPath:@"canvas_id"] forAttribute:@"canvas_id"];
        
        tempForPicker = [record valueForKeyPath:@"canvas_title"];
        tempForPicker = [tempForPicker stringByAppendingString:@"|"];
        tempForPicker = [tempForPicker stringByAppendingString:[record valueForKeyPath:@"canvas_id"]];
    
    self.canvas_id = [record valueForKeyPath:@"canvas_id"];
    
    self.currentCanvasTitle = [[record valueForKeyPath:@"canvas_title"] stringByAppendingString:@"▾"];
    
    self.currentCanvasType = [record valueForKeyPath:@"model_type"];
    
    [self saveToUserDefault];

    [self setButtonTitleByType];
    
    [self.canvasTitle setTitle:self.currentCanvasTitle forState:UIControlStateNormal];
    
    [self.canvasListForPicker addObject:tempForPicker];
    canvas.canvas_title = [record valueForKeyPath:@"canvas_title"];
    canvas.canvas_description = [record valueForKeyPath:@"canvas_description"];
    canvas.display_name = [record valueForKeyPath:@"display_name"];
    canvas.open_flag = [record valueForKeyPath:@"open_flag"];
    canvas.unique_id = [record valueForKeyPath:@"unique_id"];
    canvas.editable_flag = [record valueForKeyPath:@"editable_flag"];
    canvas.create_user = [record valueForKeyPath:@"create_user"];
    canvas.model_type = [record valueForKeyPath:@"model_type"];
    canvas.active_flag = [record valueForKeyPath:@"active_flag"];
    canvas.create_date = [dateFormatter dateFromString:[record valueForKeyPath:@"create_date"]];
        
    [context commitUpdate];
    
    
    [self fetchContentList];
   
}

- (void) saveToUserDefault{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:self.canvas_id forKey:@"currentCanvasID"];
    [userDefaults setObject:self.currentCanvasTitle  forKey:@"currentCanvasTitle"];

    [userDefaults setObject:self.currentCanvasType forKey:@"currentCanvasType"];
    //[userDefaults setObject:@"1" forKey:@"userID"];
    //[userDefaults setObject:@"user1" forKey:@"displayName"];
    [userDefaults synchronize];
}

- (IBAction)solution:(UIButton *)sender {
    //solution
    self.content_type = @"2";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)keyMetics:(UIButton *)sender {
    //key metrics
    self.content_type = @"3";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)uniqueValue:(UIButton *)sender {
    //unique value
    self.content_type = @"5";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)unfairAdvantage:(UIButton *)sender {
    //unfair advantage
    self.content_type = @"6";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)customerSegments:(UIButton *)sender {
    //customer segments
    self.content_type = @"7";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)channels:(UIButton *)sender {
    //channels
    self.content_type = @"8";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)costStructure:(UIButton *)sender {
    //cost structure
    self.content_type = @"4";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)revenueStream:(UIButton *)sender {
    //revenue stream
    self.content_type = @"9";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (IBAction)problem:(UIButton *)sender {
    //problem
    self.content_type = @"1";
    [self performSegueWithIdentifier:@"showContentList" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showContentList"]) //"goView2"是SEGUE连线的标识
    {
        ContentListTableViewController *rvc = segue.destinationViewController;
        
        rvc.contentType = self.content_type;
        
    }
    else if([segue.identifier isEqualToString:@"showCanvas"])
    {
        CanvasNavigationViewController *rvc = segue.destinationViewController;
        rvc.editType = self.editType;
        if ([self.editType isEqualToString:@"1"])
        {
            //edit canvas
            rvc.canvasID = self.canvas_id;
            
        }
    }
}

- (void)SaveReportToServer{
    
    NSString *tempURL;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/report"];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    
    NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
  
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"canvas_id=%@&create_user=%@",_canvas_id,_user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error.code == -1009) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"error" , nil ) message:NSLocalizedString ( @"connecterror" , nil ) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
       // NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL ];
        //NSLog(@"FetchResult = %@",propertyListResults);
       

        
        NSLog(@"Report Success");
        
    }
    
    
    //NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Error: %@", error);
    // NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData  options:0 error:NULL ];
    //NSLog(@"FetchResult = %@",propertyListResults);
    
    // NSLog(@"Error: %@", error);
    
    
    
    
}



-(void)setButtonTitleByType
{
    if ([self.currentCanvasType isEqualToString:@"1"])
    {
        //business model
        [self.problem setTitle:NSLocalizedString ( @"keyPartnersB" , nil ) forState:UIControlStateNormal];
        [self.solution setTitle:NSLocalizedString ( @"keyActivitiesB" , nil ) forState:UIControlStateNormal];
        [self.keyMetrics setTitle:NSLocalizedString ( @"keyResourceB" , nil ) forState:UIControlStateNormal];
        [self.costStructure setTitle:NSLocalizedString ( @"costStructureB" , nil ) forState:UIControlStateNormal];
        [self.uniqueValue setTitle:NSLocalizedString ( @"valuePropositionB" , nil ) forState:UIControlStateNormal];
        [self.customerSegments setTitle:NSLocalizedString ( @"customerSegmentsB" , nil ) forState:UIControlStateNormal];
        [self.unfairAdvantage setTitle:NSLocalizedString ( @"customerRelationshipsB" , nil ) forState:UIControlStateNormal];
        [self.channels setTitle:NSLocalizedString ( @"channelsB" , nil ) forState:UIControlStateNormal];
        [self.revenueStream setTitle:NSLocalizedString ( @"revenueStreamsB" , nil ) forState:UIControlStateNormal];
    }
    else if ([self.currentCanvasType isEqualToString:@"2"])
    {
        //business model
        [self.problem setTitle:NSLocalizedString ( @"keyPartnersP" , nil ) forState:UIControlStateNormal];
        [self.solution setTitle:NSLocalizedString ( @"keyActivitiesP" , nil ) forState:UIControlStateNormal];
        [self.keyMetrics setTitle:NSLocalizedString ( @"keyResourceP" , nil ) forState:UIControlStateNormal];
        [self.costStructure setTitle:NSLocalizedString ( @"costStructureP" , nil ) forState:UIControlStateNormal];
        [self.uniqueValue setTitle:NSLocalizedString ( @"valuePropositionP" , nil ) forState:UIControlStateNormal];
        [self.customerSegments setTitle:NSLocalizedString ( @"customerSegmentsP" , nil ) forState:UIControlStateNormal];
        [self.unfairAdvantage setTitle:NSLocalizedString ( @"customerRelationshipsP" , nil ) forState:UIControlStateNormal];
        [self.channels setTitle:NSLocalizedString ( @"channelsP" , nil ) forState:UIControlStateNormal];
        [self.revenueStream setTitle:NSLocalizedString ( @"revenueStreamsP" , nil ) forState:UIControlStateNormal];
    }
    else
    {
        //lean model
        [self.problem setTitle:NSLocalizedString ( @"problem" , nil ) forState:UIControlStateNormal];
        [self.solution setTitle:NSLocalizedString ( @"solution" , nil ) forState:UIControlStateNormal];
        [self.keyMetrics setTitle:NSLocalizedString ( @"key" , nil ) forState:UIControlStateNormal];
        [self.costStructure setTitle:NSLocalizedString ( @"cost" , nil ) forState:UIControlStateNormal];
        [self.uniqueValue setTitle:NSLocalizedString ( @"unique" , nil ) forState:UIControlStateNormal];
        [self.customerSegments setTitle:NSLocalizedString ( @"customer" , nil ) forState:UIControlStateNormal];
        [self.unfairAdvantage setTitle:NSLocalizedString ( @"unfair" , nil ) forState:UIControlStateNormal];
        [self.channels setTitle:NSLocalizedString ( @"channel" , nil ) forState:UIControlStateNormal];
        [self.revenueStream setTitle:NSLocalizedString ( @"revenue" , nil ) forState:UIControlStateNormal];
    }
}

- (IBAction)generatePDF:(UIButton *)sender {
 
    
    UIAlertController *reportController = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString ( @"msg010" , nil ) preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"canncel" , nil ) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
            [self savePDF];
            
            [self sendEmailAction];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"failed" , nil ) message:NSLocalizedString ( @"msg011" , nil ) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"ok" , nil ) style:UIAlertActionStyleDefault handler:nil];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
        
        
        
    }];
    
    [reportController addAction:cancelAction];
    [reportController addAction:okAction];
    
    [self presentViewController:reportController animated:YES completion:nil];

    
   
     
    
}


//*
// Use Core Text to draw the text in a frame on the page.
- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
       andFramesetter:(CTFramesetterRef)framesetter
{
    // Get the graphics context.
    CGContextRef  currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    CGRect    frameRect = CGRectMake(72, 72, 468, 648);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    // Update the current range based on what was drawn.
    currentRange = CTFrameGetVisibleStringRange(frameRef);
    currentRange.location += currentRange.length;
    currentRange.length = 0;
    CFRelease(frameRef);
    
    return currentRange;
}

- (void)drawPageNumber:(NSInteger)pageNum
{
    NSString* pageString = [NSString stringWithFormat:@"Page %d", pageNum];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    CGSize maxSize = CGSizeMake(612, 72);
    
    CGSize pageStringSize = [pageString sizeWithFont:theFont
                                   constrainedToSize:maxSize
                                       lineBreakMode:UILineBreakModeClip];
    CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
                                   720.0 + ((72.0 - pageStringSize.height) / 2.0),
                                   pageStringSize.width,
                                   pageStringSize.height);
    
    [pageString drawInRect:stringRect withFont:theFont];
}



- (void)savePDF{
    NSString *content;

    content = [self makePDFContent];

    
   // NSString *tmpDir = NSTemporaryDirectory();
    
   // NSString *applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
   //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   // NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //fileName = path;
    
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //PDF存储路径
    NSString *path=[array[0] stringByAppendingPathComponent:@"mycanvas.pdf"];
    
    
    
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, (CFStringRef)content, NULL);

    if (currentText) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
        if (framesetter) {
            
           // NSString* pdfFileName = [self getPDFFileName];
            
            
            NSLog(@"path[%@]", path);
            // Create the PDF context using the default page size of 612 x 792.
            UIGraphicsBeginPDFContextToFile(path, CGRectZero, nil);
            
            CFRange currentRange = CFRangeMake(0, 0);
            NSInteger currentPage = 0;
            BOOL done = NO;
            
            do {
                // Mark the beginning of a new page.
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                //*
                // Draw a page number at the bottom of each page
                currentPage++;
                [self drawPageNumber:currentPage];
                
                // Render the current page and update the current range to
                // point to the beginning of the next page.
                //currentRange = [self renderPageWithTextRange:currentRange andFramesetter:framesetter];
                currentRange = [self renderPage:currentPage withTextRange:currentRange andFramesetter:framesetter];
                //*/
                // If we're at the end of the text, exit the loop.
                if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
                    done = YES;
            } while (!done);
            
            // Close the PDF context and write the contents out.
            UIGraphicsEndPDFContext();
            
            // Release the framewetter.
            CFRelease(framesetter);
            
        } else {
            NSLog(@"Could not create the framesetter needed to lay out the atrributed string.");
        }
        // Release the attributed string.
        CFRelease(currentText);
    } else {
        NSLog(@"Could not create the attributed string for the framesetter");
    }

    
}


- (void)sendEmailAction
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"Canvas PDF"];
    // 设置收件人
    [mailCompose setToRecipients:@[@""]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"Canvas PDF";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    //	[mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
    /**
     *  添加附件
     */
    
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //PDF存储路径
    NSString *path=[array[0] stringByAppendingPathComponent:@"mycanvas.pdf"];
    
   
    NSData *pdf = [NSData dataWithContentsOfFile:path];
    [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"mycanvas.pdf"];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)makePDFContent{
    NSString * tempContent;
    
    tempContent = [self.currentCanvasTitle substringToIndex:self.currentCanvasTitle.length -2];
    
    
    tempContent = [tempContent stringByAppendingString:@"\n"];
    
    tempContent = [tempContent stringByAppendingString:@"\n"];
    
    [self fetchContentDataFromCoreData];
    
    if ([self.currentCanvasType isEqualToString:@"1"])
    {
        //business model
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"keyPartnersB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"1"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"keyActivitiesB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"2"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"keyResourceB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"3"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"costStructureB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"4"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"valuePropositionB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"5"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"customerSegmentsB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"6"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"customerRelationshipsB" , nil )];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"7"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"channelsB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"8"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"revenueStreamsB" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"9"]];
    }
    else if ([self.currentCanvasType isEqualToString:@"2"])
    {
        //business model
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"keyPartnersP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"1"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"keyActivitiesP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"2"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"keyResourceP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"3"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"costStructureP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"4"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"valuePropositionP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"5"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"customerSegmentsP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"6"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"customerRelationshipsP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"7"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"channelsP" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"8"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"revenueStreamsP" , nil )];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"9"]];
    }
    else
    {
        //lean model
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"problem" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"1"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"solution" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"2"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"key" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"3"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"cost" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"4"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"unique" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"5"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"customer" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"6"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"unfair" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"7"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"channel" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"8"]];
        tempContent = [tempContent stringByAppendingString:NSLocalizedString ( @"revenue" , nil ) ];
        tempContent = [tempContent stringByAppendingString:[self makeContentDetail:@"9"]];
    }
    
    
    return tempContent;
}

- (NSString *)makeContentDetail:(NSString *) contentType{
    NSString *tempDetail;
    NSInteger detailCount;
    tempDetail = @"\n";
    detailCount = 0;
    
    for (NSInteger i = 0; i < [_fetchContentResultController.fetchedObjects count]; i++)
    {
        Content *record = [_fetchContentResultController.fetchedObjects objectAtIndex:i];
        if ([record.content_type isEqualToString:contentType])
        {
            detailCount = detailCount + 1 ;
            tempDetail = [tempDetail stringByAppendingString:@"   "];
            tempDetail = [tempDetail stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)detailCount]];
            tempDetail = [tempDetail stringByAppendingString:@"."];
            tempDetail = [tempDetail stringByAppendingString:record.content];
            tempDetail = [tempDetail stringByAppendingString:@"\n"];
        }
    }
    
    
    return tempDetail;
}

@end
