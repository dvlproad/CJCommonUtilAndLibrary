//
//  CJDemoLoginVCFactory.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDemoLoginVCFactory.h"
#import "LoginViewController.h"
#import "FindPasswordViewController.h"
#import "ChangePasswordViewController.h"

@implementation CJDemoLoginVCFactory

+ (UIViewController *)loginViewController {
    LoginViewController *viewController = [[LoginViewController alloc] init];
    CJDemoNavigationController *navigationController = [[CJDemoNavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

+ (UIViewController *)forgetPasswordViewController {
    FindPasswordViewController *viewController = [[FindPasswordViewController alloc] init];
    return viewController;
}

+ (UIViewController *)changePasswordViewController {
    ChangePasswordViewController *viewController = [[ChangePasswordViewController alloc] init];
    return viewController;
}

+ (UIViewController *)registerViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"注册", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    return viewController;
}

@end
