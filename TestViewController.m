//
//  TestViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/29.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "TestViewController.h"
#import "AFNetworking.h"
#import "MyFriendList.h"
#import "MyContactsListCell.h"
#define HH_REQUEST_BASERUL @"http://testmecom.hhit.com.cn/mecom/"
#define HH_REQUEST_FRIENDSLIST_SELLERORGUEST       @"friendlyObject!getMyFriendlyObject.action"            //获取我的友商、友客和友伴
#define ITEMORGID @"34040"//机构ID
@interface TestViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *friendsTable;
@property(nonatomic,strong)NSMutableArray *myPartnerList;//友伴数据列表
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *baseURL = [NSURL URLWithString:HH_REQUEST_BASERUL];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html", nil];
    
    NSDictionary *parameters=@{@"itemOrgId":@"34040",@"targetType":@"3",@"commUserId":@"2"};
    [manager GET:HH_REQUEST_FRIENDSLIST_SELLERORGUEST parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict=(NSDictionary *)responseObject;
        NSLog(@"获取数据成功");
        _myPartnerList=[MyFriendList parseModelDictToModelArrayObject:responseDict[@"rows"]];
        [self.friendsTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myPartnerList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"friendsCell";
    MyContactsListCell *friendsCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!friendsCell)
    {
        friendsCell=[[MyContactsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    MyFriendList *friendInfo=[[MyFriendList alloc]init];

    friendInfo=_myPartnerList[indexPath.row];
    friendsCell.nameLabel.text=friendInfo.userName;
    friendsCell.headImage.image=[UIImage imageNamed:@"default.jpg"];

    return friendsCell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
