//
//  MyFriendList.h
//  RabbitFamily
//
//  Created by luluteam on 15/8/29.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFriendList : NSObject
@property(nonatomic,strong)NSString *commUsrId;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *officePhone;
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *openfireId;
+(NSMutableArray*)parseModelDictToModelArrayObject:(NSMutableArray*)friendsArray;
@end
