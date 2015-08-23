//
//  RecentFamilyViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/16.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "RecentFamilyViewController.h"
#import "FamilyCell.h"
@interface RecentFamilyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *haiquanTable;
@property (nonatomic,strong)NSString *detail;
@end

@implementation RecentFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _detail=@"字海全1874-?,(南舍岗熊氏1873)";
    self.haiquanTable.tableFooterView=[[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"haiquanCell";
     FamilyCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell=[[FamilyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.haiquanName.text=@"宜淳";
    cell.haiquanDetail.text=_detail;

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
