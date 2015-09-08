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
@interface FamilyPhotoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSMutableArray *images;
@property (strong, nonatomic) IBOutlet UITableView *imageTable;
@property(strong,nonatomic)UIImage *familyImage;


@end

@implementation FamilyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _images=[NSMutableArray arrayWithCapacity:50];
    [self getHeadImage];
}
#pragma 从数据库取得图片文件
-(void)getHeadImage
{
    
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
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:photoUrl];
            [_images addObject:fullPath];
            //NSLog(@"PHOTOURL%@",photoUrl);
            
        }
        sqlite3_finalize(statement);
#pragma 关闭数据库
        sqlite3_close(database);
    }
}

- (IBAction)addPhotos:(id)sender {
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        //do something
    photoPicker.delegate=self;
    [self presentViewController:photoPicker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{ [picker dismissViewControllerAnimated:YES completion:^(){
    _familyImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    int i=arc4random();
    //NSString *num = [[NSString alloc] initWithFormat:@"%d",i];
    NSString *imageName=[NSString stringWithFormat:@"image%d",i];
    [self saveImage:_familyImage withName:imageName];
    
    //NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将数据插入数据库
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
    char *update = "INSERT INTO photo (photourl) VALUES (?);";

    sqlite3_stmt *stmt;

            if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
                //sqlite3_bind_text(stmt, 1, [num UTF8String],-1,NULL);
                sqlite3_bind_text(stmt, 1, [imageName UTF8String], -1, NULL);
            }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"插入数据失败！");
        sqlite3_finalize(stmt);
    }
    //插入数据后重新获取数据库中的图片数据.
    [self getHeadImage];
    //[_images addObject:fullPath];
    [_imageTable reloadData];
    
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(database);
    
    
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];

}];
    //[_images addObject:portraitImg];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
