//
//  OrderListViewModel.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^callback) (NSArray *array);

@interface OrderListViewModel : NSObject

//tableView头部刷新的网络请求
- (void)headerRefreshRequestWithCallback:(callback)callback;
//tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCallback:(callback)callback;

@end
