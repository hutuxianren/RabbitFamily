//
//  FamilyPhotoViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/24.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "FamilyPhotoViewController.h"
#import "PhotoViewCell.h"
#import "/usr/include/sqlite3.h"
#import"TWPhotoPickerController.h"
#define kDatabaseName @"database.sqlite3"
@interface FamilyPhotoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *images;
@property (strong, nonatomic) IBOutlet UITableView *imageTable;


@end

@implementation FamilyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    _images=[NSMutableArray arrayWithCapacity:50];
    
    //获取数据库文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
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
    NSString *query =[NSString stringWithFormat:@"select photourl from photo"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"登陆成功");
        //依次读取数据库表格FIELDS中每行的内容，并显示在对应的TextField
        while(sqlite3_step(statement) == SQLITE_ROW) {
            
            //char *photoUrl = (char*)sqlite3_column_text(statement, 0);
            //char *pwd = (char *)sqlite3_column_text(statement, 1);
            NSString *photoUrl=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)];
            [_images addObject:photoUrl];
            //NSLog(@"PHOTOURL%@",photoUrl);
 
          }
        sqlite3_finalize(statement);
#pragma 关闭数据库
        sqlite3_close(database);
    }

}

- (IBAction)addPhotos:(id)sender {
    TWPhotoPickerController *photoPicker = [[TWPhotoPickerController alloc] init];
    photoPicker.cropBlock = ^(UIImage *image) {
        NSLog(@"This is the image you choose %@",image);
    
        //do something

    };
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _images.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"photoCell";
    PhotoViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell=[[PhotoViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.familyImage.image=[UIImage imageNamed:_images[indexPath.row]];
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
