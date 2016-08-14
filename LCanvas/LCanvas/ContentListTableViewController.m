//
//  ContentListTableViewController.m
//  LCanvas
//
//  Created by Yiwen Fu on 15/11/22.
//  Copyright © 2015年 Yiwen Fu. All rights reserved.
//

#import "ContentListTableViewController.h"
#import "ConstURL.h"
#import "ContentTableViewCell.h"
#import "ContentNavigationViewController.h"
#import "COntentDetailViewController.h"

@interface ContentListTableViewController ()<NSFetchedResultsControllerDelegate>

@end

@implementation ContentListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]};
    
    
     //[self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]} forState:UIControlStateNormal];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]];
    
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"back1920"]];
    
    //[self.viewType setTitle:@"View active" forState:UIControlStateNormal];
    self.viewFlag =@"1";
    
    [self readNSUserDefaults];
    
    //除去多余行数
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self fetchCanvasDataFromCoreData];
    [self fetchDataFromCoreData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"currentCanvasID"];
    self.canvasID= myString;
    myString = [userDefaultes stringForKey:@"userID"];
    self.user_id = myString;
    myString = [userDefaultes stringForKey:@"displayName"];
    self.displayName = myString;
}

- (void)viewDidAppear {
    [self fetchCanvasDataFromCoreData];
    [self fetchDataFromCoreData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchCanvasDataFromCoreData{
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[Canvas entity] context:mainContext];
    
    if ([self.canvasID isEqualToString:@""])
    {
        NSLog(@"No Canvas ID");
    }
    else
    {
        [fetchRequest fetchObjectWithValue:self.canvasID forAttributes:@"canvas_id" error:nil];
        _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                     managedObjectContext:mainContext
                                                                       sectionNameKeyPath:nil
                                                                                cacheName:nil];
    }
    
    
    [_fetchResultController setDelegate:self];
    [_fetchResultController performFetch:nil];
    
    Canvas *record = [_fetchResultController.fetchedObjects objectAtIndex:0];
    

    
    self.owner_user = record.owner_user;
    
    if ([self.owner_user isEqualToString:self.user_id]) {
        self.isOwner = YES;
    }
    else
    {
        self.isOwner = NO;
    }
    
    
    
    
    
    
}


- (void) fetchDataFromCoreData{
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[Content entity] context:mainContext];
    
    if ([self.canvasID isEqualToString:@""])
    {
        NSLog(@"No Canvas");
    }
    else if(self.canvasID == nil)
    {
        NSLog(@"No Canvas");
    }
    else
    {
        [fetchRequest fetchObjectWithValue:self.contentType forAttributes:@"content_type" error:nil];
        _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                     managedObjectContext:mainContext
                                                                       sectionNameKeyPath:nil
                                                                                cacheName:nil];
        if ([self.viewFlag isEqualToString:@"1"])
        {
            NSString *predicates;
            
            predicates = @"active_flag == 1 and content_type == ";
            
            predicates = [predicates stringByAppendingString:self.contentType];
            
            predicates = [predicates stringByAppendingString:@" and canvas_id == "];
            
            predicates = [predicates stringByAppendingString:self.canvasID];
            
            [fetchRequest fetchObjectWithPredicates:predicates error:nil];
            _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                         managedObjectContext:mainContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
        }
        else
        {
            NSString *predicates;
            
            predicates = @"content_type == ";
            
            predicates = [predicates stringByAppendingString:self.contentType];
            
            predicates = [predicates stringByAppendingString:@" and canvas_id == "];
            
            predicates = [predicates stringByAppendingString:self.canvasID];
            
            
            [fetchRequest fetchObjectWithPredicates:predicates error:nil];
            _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                         managedObjectContext:mainContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
        }
    }
    
    
    [_fetchResultController setDelegate:self];
    [_fetchResultController performFetch:nil];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_fetchResultController.fetchedObjects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"content" forIndexPath:indexPath];
    
    Content *record = [_fetchResultController.fetchedObjects objectAtIndex:indexPath.row];
    
    cell.content.text = record.content;
    
    if ([record.active_flag isEqualToString:@"0"]) {
       [cell.content setTextColor:[UIColor darkGrayColor]];
    }
    else if ([record.active_flag isEqualToString:@"1"]) {
        [cell.content setTextColor:[UIColor whiteColor]];
    }
    else
    {
        [cell.content setTextColor:[UIColor darkGrayColor]];
    }

    
    
    cell.contentID = record.content_id;
    
    cell.activeFlag = record.active_flag;
    
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    if (self.isOwner == YES) {
        return YES;
    }
    else
    {
        return  NO;
    }

}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSString *activeFlag;
    
    //NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    ContentTableViewCell  *cell = (ContentTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    activeFlag = cell.activeFlag;
    
    
    
    self.editContentID = cell.contentID;
    
    // 添加一个删除按钮
    
    UITableViewRowAction *denyRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString ( @"deny" , nil ) handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"deny");
        
        [self UpdateCotentToServer:@"2"];
        
        
        cell.activeFlag = @"2";
        
        [cell.content setTextColor:[UIColor grayColor]];
        
        [self fetchDataFromCoreData];
        //[self.tableView reloadData];
        
        
        // 1. 更新数据
        
       // [_allDataArray removeObjectAtIndex:indexPath.row];
        
        // 2. 更新UI
        
       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    
    
    //    // 删除一个置顶按钮
    
    //    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    
    //        NSLog(@"点击了置顶");
    
    //
    
    //        // 1. 更新数据
    
    //        [_allDataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
    
    //
    
    //        // 2. 更新UI
    
    //        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    
    //        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    
    //    }];
    
    //    topRowAction.backgroundColor = [UIColor blueColor];
    
    
    
    // 添加一个更多按钮
    
    UITableViewRowAction *acceptRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:NSLocalizedString ( @"accept" , nil ) handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"Accept");
        
        [self UpdateCotentToServer:@"1"];
        
        cell.activeFlag = @"1";
        
        [cell.content setTextColor:[UIColor blackColor]];
        
        [self fetchDataFromCoreData];
        //[self.tableView reloadData];
        
    }];
    
    acceptRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    denyRowAction.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:202.0/255.0 blue:203.0/255.0 alpha:1.0];
    acceptRowAction.backgroundColor = [UIColor darkGrayColor];
    
    
    // 将设置好的按钮放到数组中返回
    
    // return @[deleteRowAction, topRowAction, moreRowAction];
    
   // return @[deleteRowAction,moreRowAction];
    
    
    
    if ([activeFlag isEqualToString:@"0"]) {
        //deny, accept
        return @[acceptRowAction,denyRowAction];

    }
    else if ([activeFlag isEqualToString:@"1"])
    {
        //deny
        return @[denyRowAction];

    }
    else {
        //accept
        return @[acceptRowAction];

    }
    
    
    
}


- (IBAction)viewChange:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.viewFlag =@"1";
        [self fetchDataFromCoreData];
        [self.tableView reloadData];
    }
    else
    {
        self.viewFlag =@"0";
        [self fetchDataFromCoreData];
        [self.tableView reloadData];

    }
    
}

/*
- (IBAction)viewType:(UIButton *)sender {
    if ([self.viewType.titleLabel.text isEqualToString:@"View all"])
    {
        [self.viewType setTitle:@"View active" forState:UIControlStateNormal];
        self.viewFlag =@"1";
        [self fetchDataFromCoreData];
        [self.tableView reloadData];

        
    }
    else
    {
        [self.viewType setTitle:@"View all" forState:UIControlStateNormal];
        self.viewFlag =@"0";
        [self fetchDataFromCoreData];
        [self.tableView reloadData];
    }
    
}
 */

- (void)UpdateCotentToServer:(NSString *)activeFlag{
    
    NSString *tempURL;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/content/"];
    
    tempURL = [tempURL stringByAppendingString:self.editContentID];
    
    NSURL *url= [NSURL URLWithString:tempURL];
    
    NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    
    [request setHTTPMethod:@"PUT"];
    
    //NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    
    //NSString *tempCotentInfo;
    
    
    
    //tempCotentInfo = self.content.text;
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"active_flag=%@&update_user=%@",activeFlag,_user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Error: %@", error);
    // NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData  options:0 error:NULL ];
    //NSLog(@"FetchResult = %@",propertyListResults);
    
    // NSLog(@"Error: %@", error);
    
    
    NSDictionary *propertyListResults =[NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL ];
    //NSLog(@"FetchResult = %@",propertyListResults);
    self.contentRecord = propertyListResults;
    
    NSLog(@"updateContent = %@",self.contentRecord);
    
    NSLog(@"Success");
    
    [self saveContentDataToCoreData:activeFlag];
    
    
}

- (void) saveContentDataToCoreData:(NSString *)activeFlag {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    Content *content = [Content insertWithContext:context withValue:self.editContentID forAttribute:@"content_id"];
    

    content.active_flag = activeFlag;
    
    
    [context commitUpdate];
    
    
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showNewContent"]) //"goView2"是SEGUE连线的标识
    {
        ContentNavigationViewController *rvc = segue.destinationViewController;
        
        rvc.contentType = self.contentType;
        
    }
    else if([segue.identifier isEqualToString:@"showDetail"])
    {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        ContentTableViewCell  *cell = (ContentTableViewCell *)[self.tableView cellForRowAtIndexPath:path];
        
        ContentDetailViewController *rvc = segue.destinationViewController;
        
        rvc.content = cell.content.text;

    }
}


@end
