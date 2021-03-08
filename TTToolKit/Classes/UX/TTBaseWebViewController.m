//
//  TTWebViewController.m
//  CVoice2
//
//  Created by ZhouJinhua on 2020/4/28.
//  Copyright © 2020 ZhouJinhua. All rights reserved.
//

#import "TTBaseWebViewController.h"
#import <WebKit/WebKit.h>

@interface TTBaseWebViewController ()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *m_webView;
@property (nonatomic,strong) NSString *m_path;

@end

@implementation TTBaseWebViewController

-(instancetype)initWithUrl:(NSString *)urlPath{
    if (self = [super init]) {
        self.m_path = urlPath;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.m_webView];
    self.m_webView.frame = self.view.bounds;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.m_path]];
    [self.m_webView loadRequest:req];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.m_webView.frame = self.view.bounds;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (!self.staticTitle) {
        self.title = webView.title;        
    }
}
#pragma mark - ---- override ----
- (void)backButtonEvent:(id)sender {
    if ([self.m_webView canGoBack]) {
        [self.m_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ---- Properties ----
-(WKWebView *)m_webView {
    if (!_m_webView) {
        _m_webView = [[WKWebView alloc] init];
        _m_webView.navigationDelegate = self;
    }
    return _m_webView;
}

- (void)setStaticTitle:(NSString *)staticTitle {
    _staticTitle = staticTitle;
    self.navBarTitle = staticTitle;
    self.title = staticTitle;
}

@end
