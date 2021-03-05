//
//  ViewController.m
//  TTToolDemo
//
//  Created by 童方园 on 2020/3/28.
//  Copyright © 2020 童方园. All rights reserved.
//

#import "ViewController.h"
#import "TTToolKit.h"
#import "TTSizeAdapterViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@end

@implementation ViewController

#pragma mark - < 控制器生命周期 >
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    [self setupUI];
}

#pragma mark - < 数据初始化 >
- (void)commonInit {
    TTKeychainManagerWrite(@"wechat", @"nihao😊");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TTLog(@"%@",TTKeychainManagerRead(@"wechat"));
    });
}

#pragma mark - < 视图布局 >
- (void)setupUI {
    
}

#pragma mark - < 懒加载 >
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
