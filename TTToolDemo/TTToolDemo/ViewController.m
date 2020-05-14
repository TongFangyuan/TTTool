//
//  ViewController.m
//  TTToolDemo
//
//  Created by 童方园 on 2020/3/28.
//  Copyright © 2020 童方园. All rights reserved.
//

#import "ViewController.h"
#import "TTToolKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TTKeychainManagerWrite(@"wechat", @"nihao😊");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TTLog(@"%@",TTKeychainManagerRead(@"wechat"));
    });

}


@end
