//
//  SecondViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/16.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "SecondViewController.h"
#import "FamilyCell.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *shidai;
@property(nonatomic,strong)NSArray *names;
//@property(nonatomic,strong)NSArray *details;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shidai=@[@"2世",@"3世",@"4世",@"5世",@"6世",@"7世",@"8世",@"9世",@"10世",@"11世",@"12世",@"13世",@"14世",@"15世",@"16世",@"17世",@"18世",@"19世",@"20世",@"21世",@"22世",@"23世",@"24世",@"25世",@"26世",@"27世",@"28世",@"29世",@"30世",@"31世",@"32世"];
    //缺第30世数据......................................................已经补充了
    _names=@[@"大节",@"虞虁生于915娶万氏",@"芳腾字伯升937生娶甘氏",@"幼宣981-1051字世迪原名公宣，娶龚氏（986-1053)",@"际易1042-1116字九韶,娶左氏（1051-1116）",@"亮洙1076-1147字胜帮,娶陶氏（1086-1150）",@"存仍1108-1194字就正,娶张氏（1115-1177）",@"于昱1144-1213字光名,娶万氏(1153-1214)",@"初期1175-1238字徒先,熊氏1183-1247",@"化械1210-1282,（胡氏1213-1284）",@"效洪1244-1303字立生,鄧氏1251-1309",@"佳奇1280-1350字敏捷,李氏1291-1351",@"恒才1317-1378字魁儒,萬氏1319-1377",@"业文1344-1411字彥士,萬氏1353-1423",@"萃璋1380-1465原明璋字元珍號牛拙,張氏1384-1461",@"奇爵1404-1476名孟爵,胡氏",@"延康1426-1492名永康號先陽,鄧氏",@"振潭1456-1555字天章號樂湖,汪氏",@"孕貴1494-1558號梅麓字顯吾,萬氏",@"長瑞1522-1583字錢塘,鄭氏1525-1580",@"丕迅1548-1640字近之號岡隆,胡氏1551-1624",@"錫長1572-1647字覺先號少江,姜氏1583-1664",@"履昌1601-1646字云衢,万氏1613-1689",@"鐘磕1641-1703字仲彰,万氏1656-1718",@"居俊字軼千1689-1733",@"獻魚文1732-1805字騰雨",@"逢疆1765-1832字紹遷號雪鴻,1814授予國學生",@"昭靖原定元字朝宝號靜軒1809-1874",@"我兴1830-1858從九品,李氏1836",@"令鎰1852-1896字仁山,羅氏一男一女繼陳氏二男五女",@"宜淳字海全1874-?,南舍岗熊氏1873)"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shidai.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"secondId";
    FamilyCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell=[[FamilyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSInteger rowNo=indexPath.row;
    cell.shidaiLB.text=_shidai[rowNo];

    cell.detailTV.text=_names[rowNo];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
