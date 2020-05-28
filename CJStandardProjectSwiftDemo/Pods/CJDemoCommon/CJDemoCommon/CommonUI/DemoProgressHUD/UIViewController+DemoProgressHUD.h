//
//  UIViewController+DemoProgressHUD.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DemoProgressHUD)

/// 显示HUD
- (void)showDemoProgressHUD;

/// 隐藏HUD
- (void)dismissDemoProgressHUD;

/// 上传过程中显示开始上传的进度提示
- (void)cjdemo_showStartProgressMessage:(NSString * _Nullable)startProgressMessage;

/// 上传过程中显示正在上传的进度提示
- (void)cjdemo_showProgressingMessage:(NSString *)progressingMessage;

/// 上传过程中显示结束上传的进度提示
- (void)cjdemo_showEndProgressMessage:(NSString *)endProgressMessage isSuccess:(BOOL)isSuccess;

@end

NS_ASSUME_NONNULL_END
