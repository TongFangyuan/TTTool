//
//  TTSizeAdapterViewController.m
//  TTToolDemo
//
//  Created by Tong on 2021/3/4.
//  Copyright © 2021 童方园. All rights reserved.
//

#import "TTSizeAdapterViewController.h"

@interface TTSizeAdapterViewController ()
@property (nonatomic,strong) UILabel *label;
@end

@implementation TTSizeAdapterViewController

#pragma mark - < 控制器生命周期 >
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    [self setupUI];
}

#pragma mark - < 数据初始化 >
- (void)commonInit {
    NSMutableString *text = [NSMutableString new];
    [text appendFormat:@"分辨率：%.fx%.f\n",[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height];
    static dispatch_once_t onceToken;
    static NSDictionary *dict = nil;
    dispatch_once(&onceToken, ^{
        dict = @{
            @(TTiPhone55S):@"iPhone 5/5S/5C/SE 一代",
            @(TTiPhone678):@"iPhone 6/6S/7/8/SE 二代",
            @(TTiPhone678Plus):@"iPhone 6/6S/7/8 Plus",
            @(TTiPhoneXXS):@"iPhone X/XS/11 Pro/12 mini",
            @(TTiPhoneXRXSMAX):@"iPhone XR/11/XS Max/11 Pro Max",
            @(TTiPhone12):@"iPhone 12/12 Pro",
            @(TTiPhone12ProMax):@"iPhone 12 Pro Max",
        };
    });
    [text appendFormat:@"机型    ：%@\n",dict[@(TTSizeAdapter.share.currentIPhone)]];
    [text appendFormat:@"刘海屏：%@\n",TTIsiPhoneXAll?@"是":@"否"];
    self.label.text = text;
}

#pragma mark - < 视图布局 >
- (void)setupUI {
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.top.mas_equalTo(15.f);
    }];
}
#pragma mark - < 懒加载 >
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.numberOfLines = 0;
    }
    return _label;
}
@end
