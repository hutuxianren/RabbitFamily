//
//  genshenghoudaiViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/16.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "genshenghoudaiViewController.h"
#import "FamilyCell.h"
@interface genshenghoudaiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *names;
@property(nonatomic,strong)NSDictionary *shuFamily;
@property (strong, nonatomic) IBOutlet UITableView *genshengTable;
@property(strong,nonatomic)NSDictionary *headImages;
@end

@implementation genshenghoudaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shuFamily=@{@"淑华一家":@[@"淑华",@"谢小兰",@"涂心好"],@"淑富一家":@[@"淑富",@"刘小兰",@"涂欢"],@"淑贵一家":@[@"淑贵",@"易志春",@"涂逸欣(传志)"],@"淑娟一家":@[@"淑娟",@"林洪",@"林凯诗"],@"淑珍":@[@"淑珍"]};
    _names=[[_shuFamily allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _headImages=@{@"淑华":@"default.jpg",@"谢小兰":@"xiexiaolan.jpg",@"涂心好":@"tuxinhao.jpg",@"淑富":@"shufu.jpg",@"刘小兰":@"liuxiaolan.jpg",@"涂欢":@"tuhuan.jpg",@"淑贵":@"shugui.jpg",@"易志春":@"yizhichun.jpg",@"涂逸欣(传志)":@"tuyixin.jpg",@"淑娟":@"shujuan.jpg",@"林洪":@"default.jpg",@"林凯诗":@"linkaishi.jpg",@"淑珍":@"shuzheng.jpg"};
    self.genshengTable.tableFooterView=[[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _names.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *name=_names[section];
    return [_shuFamily[name] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"genshenghoudaiCell";
    FamilyCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell=[[FamilyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSInteger rowNo=indexPath.row;
    NSInteger sectionNo=indexPath.section;
    NSString *name=_names[sectionNo];
    NSString *everyName=[_shuFamily[name] objectAtIndex:rowNo];
    cell.familyName.text=everyName;
    cell.familyImage.image=[UIImage imageNamed:_headImages[everyName]];

    //cell.textLabel.text=[_shuFamily[name] objectAtIndex:rowNo];
    cell.layer.cornerRadius=12;
    cell.layer.masksToBounds=YES;
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _names[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
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
