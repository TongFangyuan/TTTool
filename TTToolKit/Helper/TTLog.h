//
//  TTLog.h
//  TTToolDemo
//
//  Created by Tong on 2020/5/13.
//  Copyright © 2020 童方园. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TTLog(fmt,...) [TTLog log: fmt, ##__VA_ARGS__]

@interface TTLog : NSObject

@property (nonatomic, class, assign) BOOL enable; //!< default YES.

+ (void)log:(NSString *)format , ... NS_FORMAT_FUNCTION(1, 2);

@property (nonatomic, assign) BOOL enable;

@end

NS_ASSUME_NONNULL_END
