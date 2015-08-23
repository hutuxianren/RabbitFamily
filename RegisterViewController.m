//
//  RegisterViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/20.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#define kDatabaseName @"database.sqlite3"
@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)btnRegister:(id)sender {
    //获取数据库文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    self.databaseFilePath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
        //打开数据库
        sqlite3 *database;
        if (sqlite3_open([self.databaseFilePath UTF8String], &database)
            != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"打开数据库失败！");
}
           char *update = "INSERT INTO username (username,password) VALUES (?, ?);";
#pragma 检测是否存在同一用户名
        NSString *query =[NSString stringWithFormat:@"select *from username where username='%@' and password='%@'",self.nameTF.text,self.pwdTF.text];
     sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_ROW)//如果没有数据
            {
            if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
                sqlite3_bind_text(stmt, 1, [self.nameTF.text UTF8String],-1,NULL);
                sqlite3_bind_text(stmt, 2, [self.pwdTF.text UTF8String], -1, NULL);
                NSArray *zhuceInfo=[NSArray arrayWithObjects:self.nameTF.text, self.pwdTF.text , nil];
                [self performSegueWithIdentifier:@"backtologin_segue" sender:zhuceInfo];
            }
         char *errorMsg = NULL;
            if (sqlite3_step(stmt) != SQLITE_DONE)
                NSAssert(0, @"更新数据库表FIELDS出错: %s", errorMsg);
            }
            else
            {
                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该用户名已注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
            }
        }
            sqlite3_finalize(stmt);
    
        //关闭数据库
        sqlite3_close(database);
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"backtologin_segue"])
    {
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    loginVC=segue.destinationViewController;
        loginVC.zhuceInfo=(NSArray*)sender;
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
