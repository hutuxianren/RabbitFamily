//
//  LoginViewController.h
//  RabbitFamily
//
//  Created by luluteam on 15/8/20.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"
@interface LoginViewController : UIViewController
@property (copy, nonatomic) NSString *databaseFilePath;
@property(nonatomic,strong)NSArray *zhuceInfo;
//- (void)applicationWillResignActive:(NSNotification *)notification;

@end
