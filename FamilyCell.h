//
//  FamilyCell.h
//  RabbitFamily
//
//  Created by luluteam on 15/8/16.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *shidaiLB;
@property (strong, nonatomic) IBOutlet UITextView *detailTV;

//海泉
@property (strong, nonatomic) IBOutlet UILabel *haiquanName;
@property (strong, nonatomic) IBOutlet UITextView *haiquanDetail;
//海泉第一代
@property (strong, nonatomic) IBOutlet UILabel *haiquanFirstHoudaiName;
@property (strong, nonatomic) IBOutlet UITextView *haiquanFirstHoudaiDetail;
//淑字辈头像姓名信息
@property (strong, nonatomic) IBOutlet UIImageView *familyImage;

@property (strong, nonatomic) IBOutlet UILabel *familyName;





@end
