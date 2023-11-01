//
//  TTProxy.h
//  TTToolKit
//
//  Created by Tong on 2023/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTProxy : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;
@end

NS_ASSUME_NONNULL_END
