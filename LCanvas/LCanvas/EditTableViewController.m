//
//  EditTableViewController.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/21.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import "EditTableViewController.h"
#import "ConstURL.h"
#import "CanvasNavigationViewController.h"
#import "ViewController.h"

@interface EditTableViewController ()<NSFetchedResultsControllerDelegate>


@end

@implementation EditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]};
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"back1920"]];
    
    [self readNSUserDefaults];
    
    CanvasNavigationViewController *rvc = (CanvasNavigationViewController * )self.parentViewController;
    
    
    self.editType = rvc.editType;
    
    if ([self.editType isEqualToString:@"1"]) {
        self.canvas_id = rvc.canvasID;
        [self fetchDataFromCoreData];
    }
    else{
        self.title = NSLocalizedString ( @"newCanvas" , nil );
        [self.modeSelect setTitle:NSLocalizedString ( @"leanModel" , nil ) forState:UIControlStateNormal];
        self.modelType = @"0";
    }
    
    
    
    
    //除去多余行数
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) fetchDataFromCoreData{
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[Canvas entity] context:mainContext];
    
    if ([self.canvas_id isEqualToString:@""])
    {
        NSLog(@"No Canvas ID");
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
    
   
    self.canvasTitle.text = record.canvas_title;
    self.canvasDescription.text = record.canvas_description;
    self.uniqueID.text = record.unique_id;
    
    self.owner_user = record.owner_user;
    
    if ([self.owner_user isEqualToString:self.user_id]) {
        self.canvasTitle.enabled = YES;
        self.canvasDescription.enabled = YES;
        self.save.enabled = YES;
        
        if ([record.open_flag isEqualToString:@"1"]) {
            self.openFlag.on = YES;
        }
        else
        {
            self.openFlag.on = NO;
        }
        if ([record.editable_flag isEqualToString:@"1"]) {
            self.editableFlag.on = YES;
        }
        else
        {
            self.editableFlag.on = NO;
        }
    }
    else
    {
        self.canvasTitle.enabled = NO;
        self.canvasDescription.enabled = NO;
        self.save.enabled = NO;
        
    }
    
    self.modelType = record.model_type;
    
    if ([record.model_type isEqualToString:@"0"])
    {
        
        [self.modeSelect setTitle:NSLocalizedString ( @"leanModel" , nil ) forState:UIControlStateNormal];
    }
    else if ([record.model_type isEqualToString:@"2"])
    {
        
        [self.modeSelect setTitle:NSLocalizedString ( @"PersonalModel" , nil ) forState:UIControlStateNormal];
    }
    else
    {
        [self.modeSelect setTitle:NSLocalizedString ( @"businessModel" , nil ) forState:UIControlStateNormal];
    }
    
    
   
    
    
    
    
}



-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"currentCanvasID"];
    
    myString = [userDefaultes stringForKey:@"userID"];
    self.user_id = myString;
    myString = [userDefaultes stringForKey:@"displayName"];
    self.displayName = myString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([self.owner_user isEqualToString:self.user_id])
    {
        return 5;
    }
    else
    {
        return 4;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor lightGrayColor]];
    
    
    
    
    //view.tintColor = [UIColor clearColor];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SaveCanvasToServer{
    
    NSString *tempURL;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/canvas"];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    
    NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    
    NSString *tempTitle;
    NSString *tempDescription;
    NSString *tempUniqueID;
    NSString *open_flag;
    NSString *editable_flag;

    
    
    
    tempTitle = self.canvasTitle.text;
    tempDescription = self.canvasDescription.text;
    tempUniqueID = [self ret32bitString];
    
    if (self.openFlag.isOn)
    {
        open_flag = @"1";
    }
    else
    {
        open_flag = @"0";
    }
    
    if (self.editableFlag.isOn)
    {
        editable_flag = @"1";
    }
    else
    {
        editable_flag = @"0";
    }
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"canvas_title=%@&canvas_description=%@&unique_id=%@&model_type=%@&owner_user=%@&open_flag=%@&editable_flag=%@&create_user=%@",tempTitle,tempDescription,tempUniqueID,_modelType,_user_id,open_flag,editable_flag,_user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
        NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL ];
        //NSLog(@"FetchResult = %@",propertyListResults);
        self.canvasRecord = propertyListResults;
        
        NSLog(@"newCanvas = %@",self.canvasRecord);
        
        NSLog(@"Success");
        
        
        [self saveNewCanvasDataToCoreData];
        
    }
}

- (void)UpdateCanvasToServer{
    
    NSString *tempURL;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/canvas/"];
    
    tempURL = [tempURL stringByAppendingString:self.canvas_id];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    
    
    NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    
    [request setHTTPMethod:@"PUT"];
    
    //NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    
    NSString *tempTitle;
    NSString *tempDescription;

    NSString *open_flag;
    NSString *editable_flag;
    
    
    
    
    tempTitle = self.canvasTitle.text;
    tempDescription = self.canvasDescription.text;
  
    
    if (self.openFlag.isOn)
    {
        open_flag = @"1";
    }
    else
    {
        open_flag = @"0";
    }
    
    if (self.editableFlag.isOn)
    {
        editable_flag = @"1";
    }
    else
    {
        editable_flag = @"0";
    }
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"canvas_title=%@&canvas_description=%@&owner_user=%@&open_flag=%@&editable_flag=%@&create_user=%@",tempTitle,tempDescription,_user_id,open_flag,editable_flag,_user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
        NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL ];
        //NSLog(@"FetchResult = %@",propertyListResults);
        self.canvasRecord = propertyListResults;
        
        NSLog(@"newCanvas = %@",self.canvasRecord);
        
        NSLog(@"Success");
        
        [self saveUpdatedCanvasDataToCoreData];
    }
    
    
    
    
}


- (void) saveNewCanvasDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    Canvas *canvas = [Canvas insertWithContext:context withValue:[self.canvasRecord valueForKeyPath:@"canvas_id"] forAttribute:@"canvas_id"];
    
    canvas.canvas_title = [self.canvasRecord valueForKeyPath:@"canvas_title"];
    canvas.canvas_description = [self.canvasRecord valueForKeyPath:@"canvas_description"];
    canvas.unique_id = [self.canvasRecord valueForKeyPath:@"canvas_description"];
    canvas.open_flag = [self.canvasRecord valueForKeyPath:@"open_flag"];
    canvas.owner_user = [self.canvasRecord valueForKeyPath:@"owner_user"];
    canvas.editable_flag = [self.canvasRecord valueForKeyPath:@"editable_flag"];
    canvas.active_flag = [self.canvasRecord valueForKeyPath:@"active_flag"];
    canvas.unique_id = [self.canvasRecord valueForKeyPath:@"unique_id"];
    canvas.model_type = [self.canvasRecord valueForKeyPath:@"model_type"];
    canvas.display_name = self.displayName;
    canvas.create_user = [self.canvasRecord valueForKeyPath:@"create_user"];
    canvas.create_date = [dateFormatter dateFromString:[self.canvasRecord valueForKeyPath:@"create_date"]];
    
    
    [context commitUpdate];
    
    self.canvas_id = [self.canvasRecord valueForKeyPath:@"canvas_id"];
    
    self.currentCanvasTitle = [[self.canvasRecord valueForKeyPath:@"canvas_title"] stringByAppendingString:@" ▾"];

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setObject:[self.canvasRecord valueForKeyPath:@"canvas_id"] forKey:@"currentCanvasID"];
    [userDefaults setObject:self.currentCanvasTitle  forKey:@"currentCanvasTitle"];
    [userDefaults setObject:[self.canvasRecord valueForKeyPath:@"model_type"] forKey:@"currentCanvasType"];
   
    [userDefaults synchronize];
    
    
}

- (void) saveUpdatedCanvasDataToCoreData {
    NSString *open_flag;
    NSString *editable_flag;
    
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    Canvas *canvas = [Canvas insertWithContext:context withValue:self.canvas_id forAttribute:@"canvas_id"];
    
    if (self.openFlag.isOn)
    {
        open_flag = @"1";
    }
    else
    {
        open_flag = @"0";
    }
    
    if (self.editableFlag.isOn)
    {
        editable_flag = @"1";
    }
    else
    {
        editable_flag = @"0";
    }
    

    canvas.canvas_description = self.canvasDescription.text;
    canvas.open_flag = open_flag;
    canvas.editable_flag = editable_flag;

    
    [context commitUpdate];
    
    
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
    if ([self.canvasTitle.text isEqualToString:@""]) {
        [self.canvasTitle becomeFirstResponder];
    }
    else{
        if ([self.editType isEqualToString:@"0"]) {
            [self SaveCanvasToServer];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self UpdateCanvasToServer];
        }
        
    }
    
    
    
    
}

- (NSString *)ret32bitString

{
    
    char data[8];
    
    for (int x=0;x<8;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:8 encoding:NSUTF8StringEncoding];
    
}


- (IBAction)modelSelect:(UIButton *)sender {
    
    if ([self.editType isEqualToString:@"0"])
    {
        //new
    
        
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString ( @"msg009" , nil )message:@"" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"canncel" , nil ) style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *leanAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"leanModel" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.modelType = @"0";
        [self.modeSelect setTitle:NSLocalizedString ( @"leanModel" , nil ) forState:UIControlStateNormal];
        
    }];
    
    UIAlertAction *businessAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"businessModel" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.modelType = @"1";
        [self.modeSelect setTitle:NSLocalizedString ( @"businessModel" , nil ) forState:UIControlStateNormal];
        
    }];
        
        
    UIAlertAction *PersonbusinessAction = [UIAlertAction actionWithTitle:NSLocalizedString ( @"PersonalModel" , nil ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.modelType = @"2";
            [self.modeSelect setTitle:NSLocalizedString ( @"PersonalModel" , nil ) forState:UIControlStateNormal];
            
        }];
        
    
    [alertController addAction:cancelAction];
    [alertController addAction:leanAction];
    [alertController addAction:businessAction];
    [alertController addAction:PersonbusinessAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    }

}


@end
