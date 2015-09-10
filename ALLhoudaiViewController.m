//
//  ALLhoudaiViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/18.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "ALLhoudaiViewController.h"
#import "FamilyCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "AppDelegate.h"
#define kappurl @"http://www.sharesdk.cn/"
@interface ALLhoudaiViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSArray *shidai;
@property(nonatomic,strong)NSArray *names;
@property(nonatomic,strong)NSArray *results;
@property (strong, nonatomic) IBOutlet UITableView *jiazuTable;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ALLhoudaiViewController
{
    BOOL isSearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shidai=@[@"2世",@"3世",@"4世",@"5世",@"6世",@"7世",@"8世",@"9世",@"10世",@"11世",@"12世",@"13世",@"14世",@"15世",@"16世",@"17世",@"18世",@"19世",@"20世",@"21世",@"22世",@"23世",@"24世",@"25世",@"26世",@"27世",@"28世",@"29世",@"30世",@"31世",@"32世"];
    //缺第30世数据......................................................已经补充了
    _names=@[@"大节",@"虞虁生于915娶万氏",@"芳腾字伯升937生娶甘氏",@"幼宣981-1051字世迪原名公宣，娶龚氏（986-1053)",@"际易1042-1116字九韶,娶左氏（1051-1116）",@"亮洙1076-1147字胜帮,娶陶氏（1086-1150）",@"存仍1108-1194字就正,娶张氏（1115-1177）",@"于昱1144-1213字光名,娶万氏(1153-1214)",@"初期1175-1238字徒先,熊氏1183-1247",@"化械1210-1282,（胡氏1213-1284）",@"效洪1244-1303字立生,鄧氏1251-1309",@"佳奇1280-1350字敏捷,李氏1291-1351",@"恒才1317-1378字魁儒,萬氏1319-1377",@"业文1344-1411字彥士,萬氏1353-1423",@"萃璋1380-1465原明璋字元珍號牛拙,張氏1384-1461",@"奇爵1404-1476名孟爵,胡氏",@"延康1426-1492名永康號先陽,鄧氏",@"振潭1456-1555字天章號樂湖,汪氏",@"孕貴1494-1558號梅麓字顯吾,萬氏",@"長瑞1522-1583字錢塘,鄭氏1525-1580",@"丕迅1548-1640字近之號岡隆,胡氏1551-1624",@"錫長1572-1647字覺先號少江,姜氏1583-1664",@"履昌1601-1646字云衢,万氏1613-1689",@"鐘磕1641-1703字仲彰,万氏1656-1718",@"居俊字軼千1689-1733",@"獻魚文1732-1805字騰雨",@"逢疆1765-1832字紹遷號雪鴻,1814授予國學生",@"昭靖原定元字朝宝號靜軒1809-1874",@"我兴1830-1858從九品,李氏1836",@"令鎰1852-1896字仁山,羅氏一男一女繼陳氏二男五女",@"宜淳字海全1874-?,南舍岗熊氏1873)"];
    isSearch=NO;
    _searchBar.placeholder=@"请输入人物";
   //_jiazuTable.autoresizingMask &= ~UIViewAutoresizingFlexibleBottomMargin;
    //_jiazuTable.frame=self.view.frame;
//self.jiazuTable.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!isSearch)
    {
    return _shidai.count;
    }
    else
    {
        return _results.count;
    }
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
    if(!isSearch)
    {
    cell.shidaiLB.text=_shidai[rowNo];
    
    cell.detailTV.text=_names[rowNo];
    
    }
    else
    {
        cell.shidaiLB.text=@"";
        cell.detailTV.text=_results[rowNo];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.0;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isSearch=NO;
    [self.jiazuTable reloadData];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterBySubstring:searchText];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterBySubstring:searchBar.text];
    [searchBar resignFirstResponder];
}
-(void)filterBySubstring:(NSString*)subStr
{
    isSearch=YES;
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",subStr];
    _results=[_names filteredArrayUsingPredicate:pred];
    [self.jiazuTable reloadData];
}

- (IBAction)shareBtn:(id)sender {
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray *images=[NSArray arrayWithObjects:[UIImage imageNamed:@"default.jpg"],[UIImage imageNamed:@"shufu.jpg" ], nil];
    
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:images
                                        url:[NSURL URLWithString:kappurl]
                                      title:@"分享标题"
                                       type:SSDKContentTypeImage];
    [shareParams SSDKSetupSinaWeiboShareParamsByText:@"分享内容 @value(url)" title:@"share" image:images url:[NSURL URLWithString:kappurl] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeImage];
    //进行分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
         
     }];
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
