//
//  STDemoAppDelegateLogicControl.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoAppDelegateLogicControl.h"
#import <CJBaseUtil/CJAppLastUtil.h>

@interface STDemoAppDelegateLogicControl ()

@end


@implementation STDemoAppDelegateLogicControl

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startListen];
    }
    return self;
}

///开启监听
- (void)startListen {
    //监听User
    __weak typeof(self)weakSelf = self;
    [[STDemoServiceUserManager sharedInstance] addNotificationForUserLoginStateWithUsingBlock:^(BOOL isLogin) {
        [weakSelf dealRootViewControllerWithLoginState:isLogin];
        if ([weakSelf.listenDelegate respondsToSelector:@selector(appUserManagerDidUpdateLoginState:)]) {
            [weakSelf.listenDelegate appUserManagerDidUpdateLoginState:isLogin];
        }
    }];
    
    //监听Location
    // ...
}

///获取启动时候的根视图控制器类型
- (STDemoRootViewControllerType)getDidFinishLaunchingRootViewControllerType {
    if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO]) {
        return STDemoRootViewControllerTypeGuide;
        
    } else {
        if ([STDemoServiceUserManager sharedInstance].hasLogin) {
            return STDemoRootViewControllerTypeMain;
            
        } else {
            return STDemoRootViewControllerTypeLogin;
        }
    }
}

///根据登录状态，处理根视图控制器
- (void)dealRootViewControllerWithLoginState:(BOOL)loginState {
    if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(changeRootViewControllerWithType:)])
    {
        STDemoRootViewControllerType rootViewControllerType = 0;
        if (loginState) {
            rootViewControllerType = STDemoRootViewControllerTypeMain;
        } else {
            rootViewControllerType = STDemoRootViewControllerTypeLogin;
        }
        [self.didFinishLaunchingDelegate changeRootViewControllerWithType:rootViewControllerType];
    }
}

///根据定位认证状态，处理定位权限弹窗问题
- (void)dealLocationAlertWithLocationAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(dismissLocationAllAlert)]) {
                [self.didFinishLaunchingDelegate dismissLocationAllAlert];
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(dismissLocationAllAlert)]) {
                [self.didFinishLaunchingDelegate dismissLocationAllAlert];
            }
            break;
        }
        case kCLAuthorizationStatusDenied: {
            if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO] || ![STDemoServiceUserManager sharedInstance].hasLogin) {
                return; //首次打开拒绝了定位不处理,没登录不处理
            }
            ///弹窗提示没有打开GPS，无法接单。
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(showLocationNoOpenAlert)]) {
                [self.didFinishLaunchingDelegate showLocationNoOpenAlert];
            }
            break;
        }
        case kCLAuthorizationStatusRestricted: {
            if (![CJAppLastUtil isReadOverGuideWithDistinctAppVersion:NO] || ![STDemoServiceUserManager sharedInstance].hasLogin) {
                return;//首次打开拒绝了定位不处理，,没登录不处理
            }
            if ([self.didFinishLaunchingDelegate respondsToSelector:@selector(showLocationAbnormalAlert)]) {
                [self.didFinishLaunchingDelegate showLocationAbnormalAlert];
            }
            break;
        }
        case kCLAuthorizationStatusNotDetermined: {
            break;
        }
        default:
            break;
    }
}

///定位权限改变了
- (void)changeLocationAuthorizationStatus:(CLAuthorizationStatus)currentStatus
                                     from:(CLAuthorizationStatus)fromStatus
{
    if (fromStatus != kCLAuthorizationStatusAuthorizedAlways ||
        fromStatus != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
//        [[STDemoServiceLocationManager sharedInstance] startUpdatingLocationForKey:@"Main" always:NO completed:^(STDemoLocationErrorCode code) {
//            
//        }];
    }
}


#pragma mark - STDemoServiceUserManagerListener

//- (void)driverUserManager:(STDemoServiceUserManager *)driverUserManager didUpdateLoginState:(BOOL)loginState {
//    [self dealRootViewControllerWithLoginState:loginState];
//
//    if ([self.listenDelegate respondsToSelector:@selector(appUserManagerDidUpdateLoginState:)]) {
//        [self.listenDelegate appUserManagerDidUpdateLoginState:loginState];
//    }
//}


#pragma mark - STDemoServiceLocationManagerListener

- (void)locationManager:(STDemoServiceLocationManager *)manager didUpdateAuthorizationFromStatus:(CLAuthorizationStatus)fromStatus
{
    CLAuthorizationStatus status = manager.authorizationStatus;
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            [self changeLocationAuthorizationStatus:status from:fromStatus];
            break;
        }
        default:
            break;
    }
    
    [self dealLocationAlertWithLocationAuthorizationStatus:status];
    
    
    if ([self.listenDelegate respondsToSelector:@selector(amapLocationManagerDidChangeAuthorizationStatus:)]) {
        [self.listenDelegate amapLocationManagerDidChangeAuthorizationStatus:status];
    }
}


@end
