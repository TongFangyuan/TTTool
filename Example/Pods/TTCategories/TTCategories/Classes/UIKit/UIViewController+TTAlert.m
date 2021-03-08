//
//  UIViewController+TTAlert.m
//  FYCategoryExample
//
//  Created by 童方园 on 16/4/22.
//  Copyright © 2016年 IOS. All rights reserved.
//

#import "UIViewController+TTAlert.h"
#import <objc/runtime.h>

@implementation UIViewController (TTAlert)


#pragma mark - Properties
- (void)setFyAlert:(UIAlertController *)fyAlert {
    objc_setAssociatedObject(self, @selector(fyAlert), fyAlert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIAlertController *)fyAlert {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - HUD
- (void)tt_showHUD:(NSString *)msg{
    if (self.fyAlert) {
        [self tt_hiddenHUD];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    self.fyAlert = alert;
    [self presentViewController:self.fyAlert animated:YES completion:nil];
}

- (void)tt_hiddenHUD {
    if (self.fyAlert) {
        [self.fyAlert dismissViewControllerAnimated:NO completion:nil];
        self.fyAlert = nil;
    }
}


#pragma mark - Alert
- (void)tt_showTitle:(NSString *)title
             message:(NSString *)message {
    [self fy_alertActionWithTitle:title message:message style:UIAlertActionStyleDefault handler:nil];
}

- (void)tt_showTitle:(NSString *)title
             message:(NSString *)message
      confirmHandler:(void(^)(void))confirmHandler {
    
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmHandler) confirmHandler();
    }];
    
    [self fy_showTitle:title
               message:message
     cancelAlertAction:nil
    confirmAlertAction:confirmAlertAction];
}

- (void)tt_showTitle:(NSString *)title
             message:(NSString *)message
      confirmHandler:(void(^)(void))confirmHandler
       cancelHandler:(void(^)(void))cancelHandler {
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmHandler) confirmHandler();
    }];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandler) cancelHandler();
    }];
    
    [self fy_showTitle:title
               message:message
     cancelAlertAction:cancelAlertAction
    confirmAlertAction:confirmAlertAction];
}


#pragma mark - Input alert
- (void)tt_showInput:(NSString *)title
                desc:(NSString *)desc
              handle:(FYTextFieldResultBlock)handle
{
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:desc
                                preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handle) {
            handle(alert.textFields.lastObject);
        }
    }];
    [alert addAction:confirmAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - private

- (void)fy_alertActionWithTitle:(NSString *)title
                        message:(NSString *)message
                          style:(UIAlertActionStyle)style
                        handler:(void (^)(UIAlertAction *action))handler
{
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:style handler:handler];
    [self fy_showTitle:title
               message:message
     cancelAlertAction:nil
    confirmAlertAction:confirmAction];
    
}


- (void)fy_showTitle:(NSString *)title
             message:(NSString *)message
  confirmAlertAction:(UIAlertAction *)confirmAlertAction{
    [self fy_showTitle:title
               message:message
     cancelAlertAction:nil
    confirmAlertAction:confirmAlertAction];
}

- (void)fy_showTitle:(NSString *)title
             message:(NSString *)message
   cancelAlertAction:(UIAlertAction *)cancelAlertAction
  confirmAlertAction:(UIAlertAction *)confirmAlertAction{
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelAlertAction) {
        [alert addAction:cancelAlertAction];
    }
    
    if (confirmAlertAction) {
        [alert addAction:confirmAlertAction];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
