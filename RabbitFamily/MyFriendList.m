//
//  MyFriendList.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/29.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "MyFriendList.h"

@implementation MyFriendList
+(NSMutableArray*)parseModelDictToModelArrayObject:(NSMutableArray *)friendsArray
{
    NSMutableArray *friends=[NSMutableArray array];

    for(NSDictionary *dict in friendsArray)
    {
            MyFriendList *friendInfo=[[MyFriendList alloc]init];
        friendInfo.commUsrId=dict[@"COMM_USER_ID"];
        friendInfo.email=dict[@"EMAIL"];
        friendInfo.mobile=dict[@"MOBILE"];
        friendInfo.officePhone=dict[@"OFFICE_PHONE"];
        friendInfo.headImg=dict[@"PHOTOIMG"];
        friendInfo.userName=dict[@"USERNAME"];
        friendInfo.userId=dict[@"USER_ID"];
        friendInfo.openfireId=dict[@"OPENFIRE_ID"];
        [friends addObject:friendInfo];
    }
    return friends;
}
@end
