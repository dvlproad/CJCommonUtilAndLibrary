//
//  STDemoOrderListViewController.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoOrderListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OrderListViewModel.h"
#import "OrderListTableViewDataSource.h"
#import "OrderListTableViewDelegate.h"

@interface STDemoOrderListViewController () {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderListTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) OrderListTableViewDelegate *tableViewDelegate;

@property (nonatomic, strong) NSMutableArray<STDemoOrderModel *> *orders;
@property (nonatomic, strong) OrderListViewModel *orderListViewModel;


@end

@implementation STDemoOrderListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"订单列表", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.orderListViewModel = [[OrderListViewModel alloc] init];
    self.orders = 0;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)setupViews {
    
}

#pragma mark - Event
- (void)headerRefreshAction {
    __weak typeof(self)weakSelf = self;
    [self.orderListViewModel headerRefreshRequestWithCompleteBlock:^(NSMutableArray<STDemoOrderModel *> *orders) {
        weakSelf.orders = orders;
        
        weakSelf.tableViewDataSource.orders = weakSelf.orders;
        weakSelf.tableViewDelegate.orders = weakSelf.orders;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];

}

- (void)footerRefreshAction {
    __weak typeof(self)weakSelf = self;
    [self.orderListViewModel footerRefreshRequestWithCompleteBlock:^(NSMutableArray<STDemoOrderModel *> *orders) {
        [weakSelf.orders addObjectsFromArray:orders] ;
        
        weakSelf.tableViewDataSource.orders = weakSelf.orders;
        weakSelf.tableViewDelegate.orders = weakSelf.orders;
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
  
}


#pragma mark - Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableViewDataSource = [[OrderListTableViewDataSource alloc] init];
        self.tableViewDelegate = [[OrderListTableViewDelegate alloc] init];
        _tableView.dataSource = self.tableViewDataSource;
        _tableView.delegate = self.tableViewDelegate;
        
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf headerRefreshAction];
        }];
        [_tableView.mj_header beginRefreshing]; //是否在进入该界面的时候就开始进入刷新状态
        
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf footerRefreshAction];
        }];
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
