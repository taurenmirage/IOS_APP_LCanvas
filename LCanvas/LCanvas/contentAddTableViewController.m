//
//  contentAddTableViewController.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/28.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import "contentAddTableViewController.h"
#import "ConstURL.h"
#import "ContentNavigationViewController.h"

@interface contentAddTableViewController ()<NSFetchedResultsControllerDelegate,CellSelectDelegate>

@end

@implementation contentAddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.suggest_id = @"0";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]};
  
  
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"back1920"]];
    
    //ContentNavigationViewController *rvc = (ContentNavigationViewController * )self.parentViewController;
    
    //self.content_type = rvc.contentType;
    

    
    [self readNSUserDefaults];
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    CGRect frame = self.view.frame;
    frame.origin.y += 64;
    frame.size.height  -= 64;
    self.view.frame = frame;
    
    frame.origin.y = 0;
    frame.size.height = 64;
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:frame];
    [navigationBar setOpaque:YES];
    navigationBar.backgroundColor = [UIColor whiteColor];
    
    navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]};
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:NSLocalizedString ( @"addContentTitle" , nil )];
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel)];
    
    leftbutton.tintColor = [UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0];
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionDone)];
    
    rightbutton.tintColor = [UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0];
    [navigationBar pushNavigationItem:navigationItem animated:YES];
    [navigationItem setLeftBarButtonItem:leftbutton];
    [navigationItem setRightBarButtonItem:rightbutton];
    
    [self.view.superview addSubview:navigationBar];
    
    //[super viewDidAppear:animated];
    
}


-(void) actionCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionDone
{
    if ([self.content.text isEqualToString:@""])
    {
        [self.content becomeFirstResponder];
    }
    else
    {
        [self SaveCotentToServer];
        
        [self.delegate DoSomethingAfterAddContent];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"currentCanvasID"];
    self.canvas_id = myString;
    myString = [userDefaultes stringForKey:@"userID"];
    self.user_id = myString;
    myString = [userDefaultes stringForKey:@"displayName"];
    self.displayName = myString;
    myString = [userDefaultes stringForKey:@"currentCanvasType"];
    self.canvas_type = myString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)SaveCotentToServer{
    
    NSString *tempURL;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/content"];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    
    NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    
    NSString *tempCotentInfo;
    
  
    
    tempCotentInfo = self.content.text;
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"content_type=%@&canvas_id=%@&content=%@&create_user=%@&suggest_id=%@",_content_type,_canvas_id,tempCotentInfo,_user_id,_suggest_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
        self.contentRecord = propertyListResults;
        
        NSLog(@"newContent = %@",self.contentRecord);
        
        NSLog(@"Success");
        
        [self saveContentDataToCoreData];

    }
    
    
    //NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Error: %@", error);
    // NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData  options:0 error:NULL ];
    //NSLog(@"FetchResult = %@",propertyListResults);
    
   // NSLog(@"Error: %@", error);
    
    
    
    
}

- (void) saveContentDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    Content *content = [Content insertWithContext:context withValue:[self.contentRecord valueForKeyPath:@"content_id"] forAttribute:@"content_id"];
        
    content.content = [self.contentRecord valueForKeyPath:@"content"];
    content.content_type= [self.contentRecord valueForKeyPath:@"content_type"];
    content.display_name = self.displayName;
    content.canvas_id = [self.contentRecord valueForKeyPath:@"canvas_id"];
    content.create_user = [self.contentRecord valueForKeyPath:@"create_user"];
    content.active_flag = [self.contentRecord valueForKeyPath:@"active_flag"];
    content.create_date = [dateFormatter dateFromString:[self.contentRecord valueForKeyPath:@"create_date"]];
        
        
    [context commitUpdate];
   

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (IBAction)Cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)Save:(UIBarButtonItem *)sender {
    
    if ([self.content.text isEqualToString:@""])
    {
        [self.content becomeFirstResponder];
    }
    else
    {
        [self SaveCotentToServer];
        
        [self.delegate DoSomethingAfterAddContent];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *tempDesc;
    
    
    
    if ([self.content_type isEqualToString:@"1"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"keyPartnersB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"keyPartnersP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"problem" , nil );
        }
        
    }
    else if ([self.content_type isEqualToString:@"2"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"keyActivitiesB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"keyActivitiesP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"solution" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"3"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"keyResourceB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"keyResourceP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"key" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"4"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"costStructureB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"costStructureP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"cost" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"5"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"valuePropositionB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"valuePropositionP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"unique" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"6"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"customerRelationshipsB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"customerRelationshipsP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"unfair" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"7"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"customerSegmentsB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"customerSegmentsP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"customer" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"8"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"channelsB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"channelsP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"channel" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"9"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"revenueStreamsB" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"revenueStreamsP" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"revenue" , nil );
        }
    }

    return tempDesc;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer.textLabel setTextColor:[UIColor lightGrayColor]];
    //[footer.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    //[footer.textLabel setNumberOfLines:0];
    
    
    
    
    //view.tintColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor lightGrayColor]];
    
    
    
    
    //view.tintColor = [UIColor clearColor];
}


- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    NSString *tempDesc;
    
    if ([self.content_type isEqualToString:@"1"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"keyPartnersBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"keyPartnersPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"problemDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"2"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"keyActivitiesBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"keyActivitiesPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"solutionDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"3"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"keyResourceBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"keyResourcePDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"keyDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"4"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"costStructureBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"costStructurePDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"costDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"5"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"valuePropositionBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"valuePropositionPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"uniqueDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"6"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"customerRelationshipsBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"customerRelationshipsPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"unfairDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"7"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"customerSegmentsBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"customerSegmentsPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"customerDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"8"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"channelsBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"channelsPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"channelDesc" , nil );
        }
    }
    else if ([self.content_type isEqualToString:@"9"])
    {
        if ([self.canvas_type isEqualToString:@"1"]) {
            tempDesc = NSLocalizedString ( @"revenueStreamsBDesc" , nil );
        }
        else if ([self.canvas_type isEqualToString:@"2"]) {
            tempDesc = NSLocalizedString ( @"revenueStreamsPDesc" , nil );
        }
        else{
            tempDesc = NSLocalizedString ( @"revenueDesc" , nil );
        }
    }
  
    return tempDesc;
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)DoSomethingEveryCellSelect:(NSString *)values passSuggestId:(NSString *)suggest_id
{
    NSLog(@"values:::%@",values);
    NSLog(@"suggest:::%@",suggest_id);
    self.content.text = values;
    self.suggest_id = suggest_id;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //ContentNavigationViewController *rvcParent = (ContentNavigationViewController * )self.parentViewController;
    
    //self.content_type = rvcParent.contentType;
    
    
    
    [self readNSUserDefaults];
    
    
    if([segue.identifier isEqualToString:@"showSuggest"]) //"goView2"是SEGUE连线的标识
    {
        
        SuggestContentTableViewController *rvc = segue.destinationViewController;
        
        rvc.content_type = self.content_type;
        rvc.canvas_type = self.canvas_type;
        rvc.delegate = self;
    }
}


@end
