//
//  ShareCanvasTableViewController.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/3/5.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "ShareCanvasTableViewController.h"
#import "ConstURL.h"

#import "ShareCanvasTableViewCell.h"

@interface ShareCanvasTableViewController ()<NSFetchedResultsControllerDelegate>


@end

@implementation ShareCanvasTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    //rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    [self.tableView addSubview:self.refreshControl];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:156.0/255.0 green:170.0/255.0 blue:209.0/255.0 alpha:1.0]};
    

    
    UIImage *backGroundImage = [UIImage imageNamed:@"back1920"];
    
    self.view.layer.contents = (id)backGroundImage.CGImage;
    
    [self fetchCanvasList];
    
    //除去多余行数
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear {
    
    [self readNSUserDefaults];
    
    if ([self.user_id isEqualToString:@""]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self.tableView reloadData];
}

-(void) refreshTableView
{
    if (self.refreshControl.refreshing) {
       // self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        //添加新的模拟数据
       NSDate *date = [[NSDate alloc] init];
        [self fetchCanvasList];
        //模拟请求完成之后，回调方法callBackMethod
        [self performSelector:@selector(callBackMethod:) withObject:date afterDelay:3];
    }
}

//这是一个模拟方法，请求完成之后，回调方法
-(void)callBackMethod:(id) obj
{
    [self.refreshControl endRefreshing];
    //self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    [self.tableView reloadData];
}

-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"userID"];

    
    myString = [userDefaultes stringForKey:@"userID"];
    self.user_id = myString;
    

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.canvasList count];
}

- (void)fetchCanvasList{
    
    self.canvasList = nil;
    
    
    NSString *tempURL;

    
  
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/sharecanvaslist"];

    
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
        
        NSLog(@"canvasList = %@",self.canvasList);
        
        //[self saveCanvasDataToCoreData];
        
    }
    
}

- (void) saveCanvasDataToCoreData {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
    
    NSArray *record;

    
 
    
    for (NSUInteger i = 0; i < [self.canvasList count]; i++)
    {
        
        record = [self.canvasList objectAtIndex:i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        Canvas *canvas = [Canvas insertWithContext:context withValue:[record valueForKeyPath:@"canvas_id"] forAttribute:@"canvas_id"];
        
      
        
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




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareCanvasTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareCanvasCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSArray *record;
    
    record = [self.canvasList objectAtIndex:indexPath.row];
    
    cell.CanvasTitle.text =  [record valueForKeyPath:@"canvas_title"];

    cell.CanvasDesc.text = [record valueForKeyPath:@"canvas_description"];
    
    cell.canvasID = [record valueForKeyPath:@"canvas_id"];
    
    cell.modelType = [record valueForKeyPath:@"model_type"];
    
    if ([[record valueForKeyPath:@"model_type"] isEqualToString:@"0"])
    {
        [cell.CanvasType setTitle:@"L" forState:UIControlStateNormal];
    }
    else if ([[record valueForKeyPath:@"model_type"] isEqualToString:@"1"])
    {
        [cell.CanvasType setTitle:@"B" forState:UIControlStateNormal];
    }
    else if ([[record valueForKeyPath:@"model_type"] isEqualToString:@"2"])
    {
        [cell.CanvasType setTitle:@"P" forState:UIControlStateNormal];

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCanvasTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * currentCanvasTitle;
    
    NSLog(@"cell select values:::%@",cell.canvasID);
    
    currentCanvasTitle = [cell.CanvasTitle.text stringByAppendingString:@" ▾"];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:cell.canvasID  forKey:@"currentCanvasID"];
    [userDefaults setObject:currentCanvasTitle  forKey:@"currentCanvasTitle"];
    [userDefaults setObject:cell.modelType forKey:@"currentCanvasType"];
    
    [userDefaults synchronize];
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    [self.tabBarController setSelectedIndex:selectedIndex - 1];

    
   // [self.delegate DoSomethingEveryCellSelect:cell.content.text passSuggestId:cell.suggestID];
    
}




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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
