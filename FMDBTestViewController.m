//
//  FMDBTestViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/9/2.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "FMDBTestViewController.h"
#import "FMDatabase.h"
@interface FMDBTestViewController ()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation FMDBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"student.sqlite"];
    NSLog(@"数据库文件地址是%@",fileName);
    _db=[FMDatabase databaseWithPath:fileName];//获得数据库
    if([_db open])
    {
        NSLog(@"打开数据库成功");
    }
    BOOL result=[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL);"];
    if(result)
    {
        NSLog(@"创表成功");
    }
    //插入数据
    //[self insertStu];
    //[self deleteStu:2];
    [self queryStu];
    [_db close];
}

-(void)insertStu
{
    for(int i=0;i<=10;i++)
    {
        NSString *name=[NSString stringWithFormat:@"stu%d",i];
        int age=i;
        [_db executeUpdate:@"insert into t_student(name,age) values(?,?)",name,@(age)];
    }
    NSLog(@"插入数据");
}
-(void)deleteStu:(int)num
{
    [_db executeUpdate:@"delete from t_student where id=?;",@(num)];
    NSLog(@"删除数据");
}
-(void)queryStu
{
    FMResultSet *result=[_db executeQuery:@"select *from t_student where id>?;",@(4)];
    NSLog(@"查询数据");
    while ([result next]) {
        int id=[result intForColumn:@"id"];
        NSString *name=[result objectForColumnName:@"name"];
        int age=[result intForColumnIndex:2];
        NSLog(@"student id=%d,name=%@,age=%d",id,name,age);
    }
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
