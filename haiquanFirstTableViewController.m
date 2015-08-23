//
//  haiquanFirstTableViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/16.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "haiquanFirstTableViewController.h"
#import "FamilyCell.h"
#import "xuzibeiTableViewController.h"
@interface haiquanFirstTableViewController ()
@property(nonatomic,strong) NSDictionary *shizibeiandxuzibei;//世字辈到序字辈
@property (strong, nonatomic) IBOutlet UITableView *shizibeiTable;
@property(strong,nonatomic)NSArray *names;
@property(nonatomic,strong)NSArray *details;
@end

@implementation haiquanFirstTableViewController
//大姑婆小姑婆数据暂未加进去
- (void)viewDidLoad {
    [super viewDidLoad];
    _shizibeiandxuzibei=@{@"世峥":@[],@"世嵘":@[@"序宗字庆生1921-1984,(高爱焦1924)",@"序义字义生1929-",@"序礼字礼生1934-",@"序智字智生1940-1981",@"序信字信生1941-"],@"世岷":@[@"序平（保生1929-1998,(李香连1928-1994)",@"序根（根生1937-1992,(张观凤1941.6.23-)",@"序金（金生1940-2009,(袁娟1950.12)",@"序安（安生1946.7.22,(谢雪梅1950.12.16)",@"序广（广生1949.2.2),(谢会萍1962.5.19)"]};
    _names=@[@"世峥",@"世嵘",@"世岷",@"大姑婆",@"小姑婆"];
    _details=@[@"1898（幼死）",@"字相全名鹤梅1899-1970,(陈春梅?-1982)",@"（字香梅1905-1958,(胡凤姑1910-1990)",@"",@""];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId=@"haiquanhoudaiCell";
    FamilyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell=[[FamilyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    // Configure the cell...
    NSInteger rowNo=indexPath.row;
    cell.haiquanFirstHoudaiName.text=_names[rowNo];
    cell.haiquanFirstHoudaiDetail.text=_details[rowNo];
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toxuzibei_segue"])
    {
    xuzibeiTableViewController *xuzibeiVC=[[xuzibeiTableViewController alloc]init];
    xuzibeiVC=segue.destinationViewController;
        NSInteger rowNo=[[self.shizibeiTable indexPathForSelectedRow]row];
        NSString *name=_names[rowNo];
        xuzibeiVC.xuzibeiNameAndDetail=_shizibeiandxuzibei[name];
        
    }
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
