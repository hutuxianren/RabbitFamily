//
//  LoginViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/20.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#define mainSize    [UIScreen mainScreen].bounds.size

#define offsetLeftHand      60

#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)
#define kDatabaseName @"database.sqlite3"
@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField* txtUser;
    UITextField* txtPwd;
    
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    
    JxbLoginShowType showType;
}
@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textPwd;

@end

@implementation LoginViewController
@synthesize databaseFilePath;
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.textName.text=@"";
//    self.textPwd.text=@"";
    
    
    UIImageView* imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width / 2 - 211 / 2, 100, 211, 109)];
    imgLogin.image = [UIImage imageNamed:@"owl-login"];
    imgLogin.layer.masksToBounds = YES;
    [self.view addSubview:imgLogin];
    
    imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
    imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
    [imgLogin addSubview:imgLeftHand];
    
    imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
    imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
    [imgLogin addSubview:imgRightHand];
    
    UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 200, mainSize.width - 30, 160)];
    vLogin.layer.borderWidth = 0.5;
    vLogin.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    vLogin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLogin];
    
    imgLeftHandGone = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
    imgLeftHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [self.view addSubview:imgLeftHandGone];
    
    imgRightHandGone = [[UIImageView alloc] initWithFrame:rectRightHandGone];
    imgRightHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [self.view addSubview:imgRightHandGone];
    
    txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44)];
    txtUser.delegate = self;
    txtUser.layer.cornerRadius = 5;
    txtUser.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    txtUser.layer.borderWidth = 0.5;
    txtUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtUser.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [txtUser.leftView addSubview:imgUser];
    [vLogin addSubview:txtUser];
    
    txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44)];
    txtPwd.delegate = self;
    txtPwd.layer.cornerRadius = 5;
    txtPwd.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    txtPwd.layer.borderWidth = 0.5;
    txtPwd.secureTextEntry = YES;
    txtPwd.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtPwd.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [txtPwd.leftView addSubview:imgPwd];
    [vLogin addSubview:txtPwd];
    // Do any additional setup after loading the view.

//    
//    //创建数据库表
//    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS (TAG INTEGER PRIMARY KEY, FIELD_DATA TEXT);";
//    char *errorMsg;
//    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
//        sqlite3_close(database);
//        NSAssert(0, @"创建数据库表错误: %s", errorMsg);
//    }
    

    
    //关闭数据库

    //当程序进入后台时执行写入数据库操作
//    UIApplication *app = [UIApplication sharedApplication];
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(applicationWillResignActive:)
//     name:UIApplicationWillResignActiveNotification
//     object:app];
}
-(void)viewWillAppear:(BOOL)animated
{
//    txtUser.text=[_zhuceInfo objectAtIndex:0];
//    txtPwd.text=[_zhuceInfo objectAtIndex:1];
    txtUser.text=@"tuyixin";
    txtPwd.text=@"123456";
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:txtUser]) {
        if (showType != JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_USER;
            return;
        }
        showType = JxbLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = CGRectMake(imgLeftHand.frame.origin.x - offsetLeftHand, imgLeftHand.frame.origin.y + 30, imgLeftHand.frame.size.width, imgLeftHand.frame.size.height);
            
            imgRightHand.frame = CGRectMake(imgRightHand.frame.origin.x + 48, imgRightHand.frame.origin.y + 30, imgRightHand.frame.size.width, imgRightHand.frame.size.height);
            
            
            imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.frame.origin.x - 70, imgLeftHandGone.frame.origin.y, 40, 40);
            
            imgRightHandGone.frame = CGRectMake(imgRightHandGone.frame.origin.x + 30, imgRightHandGone.frame.origin.y, 40, 40);
            
            
        } completion:^(BOOL b) {
        }];
        
    }
    else if ([textField isEqual:txtPwd]) {
        if (showType == JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_PASS;
            return;
        }
        showType = JxbLoginShowType_PASS;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = CGRectMake(imgLeftHand.frame.origin.x + offsetLeftHand, imgLeftHand.frame.origin.y - 30, imgLeftHand.frame.size.width, imgLeftHand.frame.size.height);
            imgRightHand.frame = CGRectMake(imgRightHand.frame.origin.x - 48, imgRightHand.frame.origin.y - 30, imgRightHand.frame.size.width, imgRightHand.frame.size.height);
            
            
            imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.frame.origin.x + 70, imgLeftHandGone.frame.origin.y, 0, 0);
            
            imgRightHandGone.frame = CGRectMake(imgRightHandGone.frame.origin.x - 30, imgRightHandGone.frame.origin.y, 0, 0);
            
        } completion:^(BOOL b) {
        }];
    }
}
- (IBAction)btnLogin:(id)sender {
    //NSLog(@"登录按钮");
    //获取数据库文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.databaseFilePath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
    
    //打开或创建数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String] , &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    else
    {
        NSLog(@"打开数据库成功");
    }
    //执行查询
    NSString *query =[NSString stringWithFormat:@"select *from username where username='%@' and password='%@'",txtUser.text,txtPwd.text];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //NSLog(@"登陆成功");
        //依次读取数据库表格FIELDS中每行的内容，并显示在对应的TextField
        if(sqlite3_step(statement) == SQLITE_ROW) {
        
            char *username = (char*)sqlite3_column_text(statement, 0);
            char *pwd = (char *)sqlite3_column_text(statement, 1);
            NSString *name=[NSString stringWithUTF8String:username];
            NSString *password=[NSString stringWithUTF8String:pwd];
            NSLog(@"name%@",name);
            NSLog(@"pwd%@",password);
            if ([txtUser.text isEqualToString:name]&&[txtPwd.text isEqualToString:password]) {
                [self performSegueWithIdentifier:@"loginseccess_segue" sender:nil];
                NSLog(@"登陆成功");
            }

        }
        else if([txtUser.text isEqual:@""]||[txtPwd.text isEqual:@""])
        {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertview show];
        }
        else
        {
            NSString *queryByName=[NSString stringWithFormat:@"select * from username where username='%@' or password='%@'",txtUser.text,txtPwd.text];
                if (sqlite3_prepare_v2(database, [queryByName UTF8String], -1, &statement, nil) == SQLITE_OK) {
                            if(sqlite3_step(statement) == SQLITE_ROW)
                            {
                                UIAlertView *alerview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请核对用户名或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alerview show];
                            }
                    
                            else
                            {
                                UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该用户名不存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alertview show];
                            }
        }


        sqlite3_finalize(statement);
    }


    
#pragma 关闭数据库
        sqlite3_close(database);
    

}
}
- (IBAction)btnRegister:(id)sender {
    [self performSegueWithIdentifier:@"toregister_segue" sender:nil];
}


    //程序进入后台时的操作，实现将当前显示的数据写入数据库
//-(void)applicationWillResignActive:(NSNotification *)notification {
//    //打开数据库
//    sqlite3 *database;
//    if (sqlite3_open([self.databaseFilePath UTF8String], &database)
//        != SQLITE_OK) {
//        sqlite3_close(database);
//        NSAssert(0, @"打开数据库失败！");
//    }
//    //向表格插入四行数据
//    for (int i = 1; i <= 4; i++) {
//        //根据tag获得TextField
//        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
//        //使用约束变量插入数据
//        char *update = "INSERT OR REPLACE INTO FIELDS (TAG, FIELD_DATA) VALUES (?, ?);";
//        sqlite3_stmt *stmt;
//        if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
//            sqlite3_bind_int(stmt, 1, i);
//            sqlite3_bind_text(stmt, 2, [textField.text UTF8String], -1, NULL);
//        }
//        char *errorMsg = NULL;
//        if (sqlite3_step(stmt) != SQLITE_DONE)
//            NSAssert(0, @"更新数据库表FIELDS出错: %s", errorMsg);
//        sqlite3_finalize(stmt);
//    }
//    //关闭数据库
//    sqlite3_close(database);
//}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"loginseccess_segue"])
    {
        UITabBarController* tabBarController=[[UITabBarController alloc]init];
        tabBarController=segue.destinationViewController;
    }
    if([segue.identifier isEqualToString:@"toregister_segue"])
    {
        RegisterViewController *rgVC=[[RegisterViewController alloc]init];
        rgVC=segue.destinationViewController;
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
