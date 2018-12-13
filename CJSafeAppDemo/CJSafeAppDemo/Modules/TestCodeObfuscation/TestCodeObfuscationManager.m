//
//  TestCodeObfuscationManager.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TestCodeObfuscationManager.h"

@implementation TestCodeObfuscationManager

+ (TestCodeObfuscationManager *)cjcof_sharedInstance {
    static TestCodeObfuscationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


@end
