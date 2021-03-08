//
//  TTWebViewController.h
//  CVoice2
//
//  Created by ZhouJinhua on 2020/4/28.
//  Copyright © 2020 ZhouJinhua. All rights reserved.
//

#import "TTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseWebViewController : TTBaseViewController

- (instancetype)initWithUrl:(NSString *)urlPath;

/// 固定导航栏标题，如果不设置，默认取网页标题为导航栏标题
@property (nonatomic,strong) NSString *staticTitle;


@end

NS_ASSUME_NONNULL_END
