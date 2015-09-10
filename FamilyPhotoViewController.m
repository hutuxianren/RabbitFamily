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
#import "FMDataBase.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface FamilyPhotoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)NSMutableArray *images;
@property (strong, nonatomic) IBOutlet UITableView *imageTable;
@property(strong,nonatomic)UIImage *familyImage;
@property(strong,nonatomic)FMDatabase *db;

@property(strong,nonatomic)UIActionSheet *photosheet;


@end

@implementation FamilyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _images=[NSMutableArray arrayWithCapacity:50];
[self.navigationItem setHidesBackButton:YES];
    [self getHeadImage];
}
#pragma 从数据库取得图片文件
-(void)getHeadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName=[[paths lastObject]stringByAppendingPathComponent:@"family.sqilte"];
    _db=[FMDatabase databaseWithPath:fileName];
    if([_db open])
    {
        NSLog(@"数据库打开成功!");
    }
    BOOL result=[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_photo (id integer PRIMARY KEY AUTOINCREMENT,headImage text NOT NULL);"];
    if(result)
    {
        NSLog(@"创表成功!");
    }
    FMResultSet *set=[_db executeQuery:@"select *from t_photo"];
    while ([set next]) {
        NSString *headImage=[set objectForColumnName:@"headImage"];
        NSString *fullPath=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:headImage];
        [_images addObject:fullPath];
    }
}

- (IBAction)addPhotos:(id)sender {
    _photosheet=[[UIActionSheet alloc]initWithTitle:@"请选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择",nil];
    [_photosheet showInView:self.view];
//    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
//    photoPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//    photoPicker.delegate=self;
//    [self presentViewController:photoPicker animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //相机可用且支持拍照
        if([self isCameraAvailable]&&[self doesCameraSupportTakingPhotos])
        {
        UIImagePickerController *photoPicker=[[UIImagePickerController alloc]init];
        photoPicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        photoPicker.delegate=self;
        [self presentViewController:photoPicker animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"警告" message:@"该设备不支持照相" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
        }
        
    }
    if(buttonIndex==1)
    {
        if([self isPhotoLibraryAvailable])
        {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        photoPicker.delegate=self;
        [self presentViewController:photoPicker animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"警告" message:@"该设备不支持相册选择照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
        }
        
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{ [picker dismissViewControllerAnimated:YES completion:^(){
    _familyImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    int i=arc4random();
    //NSString *num = [[NSString alloc] initWithFormat:@"%d",i];
    NSString *imageName=[NSString stringWithFormat:@"image%d",i];
    [self saveImage:_familyImage withName:imageName];
    NSLog(@"imageName=%@",imageName);
    //NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    //将数据插入数据库
    //获取数据库文件路径
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths lastObject];
//    NSLog(@"%@",documentsDirectory);
    NSString *fileName=[[paths lastObject]stringByAppendingPathComponent:@"family.sqilte"];
    _db=[FMDatabase databaseWithPath:fileName];
    
    if([_db open])
    {
        NSLog(@"打开数据库成功!");
    }
    [_db executeUpdate:@"insert into t_photo(headImage) values(?);",imageName];
    //[_imageTable clearsContextBeforeDrawing];
    //插入数据后重新获取数据库中的图片数据.
    [_images removeAllObjects];
    [self getHeadImage];
    //[_images addObject:fullPath];
    [_imageTable reloadData];
        [_db close];
    
}];
    //[_images addObject:portraitImg];
}
#pragma imagePickerController delegate
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
//相机是否可用
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera];
}
//相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){ NSLog(@"Media type is empty."); return NO;
    }
    NSArray *availableMediaTypes =
    [UIImagePickerController
     availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         NSString *mediaType = (NSString *)obj;
         if ([mediaType isEqualToString:paramMediaType]){
             result = YES;
             *stop= YES; }
     }];
    return result;
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

#pragma tableview delegate
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *fileName=[[paths lastObject]stringByAppendingPathComponent:@"family.sqilte"];
        _db=[FMDatabase databaseWithPath:fileName];
        if([_db open])
        {
            NSLog(@"数据库打开成功!");
        }
        NSString *imageName=[@"image" stringByAppendingString:[[_images[indexPath.row] componentsSeparatedByString:@"image"]lastObject]];
        NSLog(@"imageName=%@",imageName);
        FMResultSet *set=[_db executeQuery:@"select *from t_photo where headImage=?;",imageName];
        while ([set next]) {
            NSString *headImage=[set objectForColumnName:@"headImage"];
            [_db executeUpdate:@"delete from t_photo where headImage=?;",headImage];
        }
        
        //[_imageTable reloadData];
        [_db close];
        
        [_images removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [_imageTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];


    }
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"确认删除?";
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
