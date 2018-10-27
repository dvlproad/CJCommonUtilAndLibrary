//
//  CJDemoServiceUserManager.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  UserService最公共的部分(UserService会有Login、Detail、Edit等操作)

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DemoUser.h"

@interface CJDemoServiceUserManager : NSObject {
    
}
+ (CJDemoServiceUserManager *)sharedInstance;

#pragma mark - Session
@property (nonatomic, strong) DemoUser *serviceUser;    /**< 服务的用户 */
@property (nonatomic, assign, readonly) BOOL hasLogin;

/**
 *  更新登录状态（登录成功，退出的时候都需要调用）
 *
 *  @param isLogin 是否登录(YES:登录，NO:登出)
 */
+ (void)updateLoginState:(BOOL)isLogin;

@end
