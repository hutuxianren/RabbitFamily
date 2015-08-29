//
//  FirstViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/16.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "FirstViewController.h"
#import "/usr/include/sqlite3.h"
//廙公
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *guanggong;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[NSThread sleepForTimeInterval:2.0];
    // Do any additional setup after loading the view.
    _guanggong=@"廙公后代";

   // NSString *name=NSHomeDirectory();
    //NSLog(@"%@",name);
    //NSString *lib=(NSString*)[libs objectAtIndex:0];
//    NSString *fileName=[[libs objectAtIndex:0] stringByAppendingPathComponent:@"myFile"];
    //NSString *content=@"a2222222";
    //NSData *contentData=[content dataUsingEncoding:NSASCIIStringEncoding];
    //NSString *fileName2=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myFile.txt"];
    //NSString *fileName3=[[NSBundle mainBundle]pathForResource:@"test" ofType:@"rtf"];
//    NSString *myFileContent=[NSString stringWithContentsOfFile:fileName3 encoding:NSUTF8StringEncoding error:nil];    //NSLog(@"%@",lib);
//    //NSLog(@"bundel file path: %@ \nfile content:%@",fileName3,myFileContent);
//    
//    NSArray *libs=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, true);
//    NSString *fileName=[libs objectAtIndex:0];
//    //数据库操作
//    sqlite3 *database;
//    int result=sqlite3_open("/path/databaseFile", &database);
//    char *errorMsg;
//    const char *createSQL = "CREATE TABLE IF NOT EXISTS PEOPLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, FIELD_DATA TEXT)";
//    int result2 = sqlite3_exec(database, createSQL, NULL, NULL, &errorMsg);
//    NSString *query = @"SELECT ID, FIELD_DATA FROM FIELDS ORDER BY ROW";
//    sqlite3_stmt *statement;
//    int result3 = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
//    while (sqlite3_step(statement) == SQLITE_ROW) {
//        int rowNum = sqlite3_column_int(statement, 0);
//        char *rowData = (char *)sqlite3_column_text(statement, 1);
//        NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
    
        // Do something with the data here
//    }
//    sqlite3_finalize(statement);
//    NSLog(@"%d",result3);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"firstId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //NSInteger rowNo=indexPath.row;
    cell.textLabel.text=_guanggong;
    return cell;
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
