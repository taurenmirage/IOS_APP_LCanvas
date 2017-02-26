//
//  SuggestContentTableViewController.m
//  ShareMyCanvas
//
//  Created by Yiwen Fu on 2017/1/15.
//  Copyright © 2017年 Yiwen Fu. All rights reserved.
//

#import "SuggestContentTableViewController.h"
#import "ConstURL.h"
#import "SuggestTableViewCell.h"

@interface SuggestContentTableViewController ()<NSFetchedResultsControllerDelegate>

@end

@implementation SuggestContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backGroundImage = [UIImage imageNamed:@"back1920"];
    
    self.view.layer.contents = (id)backGroundImage.CGImage;

    [self fetchSuggestList];
    
    //除去多余行数
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear {
 
    [self.tableView reloadData];
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
    return [self.suggestList count];
}

- (void)fetchSuggestList{
    
    self.suggestList = nil;
    
    
    NSString *tempURL;
    NSString *contentType;
    NSString *modelType;
    
    contentType = self.content_type;
    modelType = self.canvas_type;
    
    tempURL = [serverURL stringByAppendingString:@"/lcanvas/index.php/api/suggestlist/?"];
    tempURL = [tempURL stringByAppendingString:@"contenttype="];
    tempURL = [tempURL stringByAppendingString:contentType];
    tempURL = [tempURL stringByAppendingString:@"&modeltype="];
    tempURL = [tempURL stringByAppendingString:modelType];
    
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
        
        self.suggestList = (NSArray *)propertyListResults;
        
        NSLog(@"suggestList = %@",self.suggestList);
        
   
        
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SuggestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"suggestCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSArray *record;
        
    record = [self.suggestList objectAtIndex:indexPath.row];
    
    cell.content.text =  [record valueForKeyPath:@"content"];

    cell.suggestID = [record valueForKeyPath:@"suggest_id"];

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"cell select values:::%@",cell.content.text);
    
    
    
    [self.delegate DoSomethingEveryCellSelect:cell.content.text passSuggestId:cell.suggestID];
   
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
