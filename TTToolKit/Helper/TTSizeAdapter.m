//
//  TTViewSizeAdapter.m
//  TTToolSamples
//
//  Created by Tong on 2019/8/6.
//  Copyright © 2019 tongfy. All rights reserved.
//

#define TTIPhone55S CGSizeMake(320.f, 568.f)
#define TTIPhone678Size CGSizeMake(375.f, 667.f)
#define TTIPhone678PlusSize CGSizeMake(414.f, 736.f)
#define TTIPhoneXXSSize CGSizeMake(375.f, 812.f)
#define TTIPhoneXRXSMAXSize CGSizeMake(414.f, 896.f)

#import "TTSizeAdapter.h"

@interface TTSizeAdapter ()

@property (nonatomic, assign) TTiPhone currentIPhone;
@property (nonatomic, strong) NSDictionary *sizeMap;
@property (nonatomic, strong) NSDictionary *iPhoneMap;

/**
 高度比例尺
 */
@property (nonatomic, assign) CGFloat widthScale;

/**
 高度比例尺
 */
@property (nonatomic, assign) CGFloat heightScale;

@end

@implementation TTSizeAdapter

+ (nonnull instancetype)share {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - public
- (CGFloat)scaleWidth:(CGFloat)width {
    return width*self.widthScale;
}

- (CGFloat)scaleHegiht:(CGFloat)height {
    return height*self.heightScale;
}

- (CGSize)scaleSize:(CGSize)size {
    return CGSizeMake(size.width*self.widthScale, size.height*self.widthScale);
}

- (CGFloat)convertPt:(CGFloat)pt scale:(CGFloat)scale {
    return pt*scale;
}

- (CGSize)convertSize:(CGSize)size scale:(CGFloat)scale {
    return CGSizeMake(size.width*scale, size.height*scale);
}

#pragma mark - private
- (instancetype)init {
    if (self=[super init]) {
        [self configAdapter];
    }
    return self;
}



- (void)configAdapter {
    
    self.sizeMap = @{
                     @(TTiPhone678):NSStringFromCGSize(TTIPhone678Size),
                     @(TTiPhone678Plus):NSStringFromCGSize(TTIPhone678PlusSize),
                     @(TTiPhoneXXS):NSStringFromCGSize(TTIPhoneXXSSize),
                     @(TTiPhoneXRXSMAX):NSStringFromCGSize(TTIPhoneXRXSMAXSize),
                     @(TTiPhone55S):NSStringFromCGSize(TTIPhone55S)
                     };
    
    self.iPhoneMap = @{
                       NSStringFromCGSize(TTIPhone678Size):@(TTiPhone678),
                       NSStringFromCGSize(TTIPhone678PlusSize):@(TTiPhone678Plus),
                       NSStringFromCGSize(TTIPhoneXXSSize):@(TTiPhoneXXS),
                       NSStringFromCGSize(TTIPhoneXRXSMAXSize):@(TTiPhoneXRXSMAX),
                       NSStringFromCGSize(TTIPhone55S):@(TTiPhone55S)
                       };
    
    /// 设置当前机型
    CGSize size = [[UIScreen mainScreen] bounds].size;
    self.currentIPhone = [self getIPhoneWithSize:size];

}

- (TTiPhone)getIPhoneWithSize:(CGSize)size {
    NSString *obj = self.iPhoneMap[NSStringFromCGSize(size)];
    NSAssert(obj, @"机型不存在，需要更新配置");
    return [obj integerValue];
}

- (CGSize)getSizeWithIPhone:(TTiPhone)iphone {
    NSString *obj = self.sizeMap[@(iphone)];
    NSAssert(obj, @"尺寸不存在，需要更新配置");
    return CGSizeFromString(obj);
}

- (void)setMarkIPhone:(TTiPhone)markIPhone {
    _markIPhone = markIPhone;
    
    /// 比例尺配置
    CGSize markSize = [self getSizeWithIPhone:markIPhone];
    CGSize targetSzie = [self getSizeWithIPhone:self.currentIPhone];
    self.widthScale = targetSzie.width / markSize.width;
    self.heightScale = targetSzie.height / markSize.height;
    
}

@end

@interface TTAdapterItem ()
@property (nonatomic, strong) NSMutableDictionary *dict;
@end

@implementation TTAdapterItem

+ (instancetype)itemWithFloats:(NSArray<NSNumber *> *)floats {
    return [[self alloc] initWithFloats:floats];
}

- (instancetype)initWithFloats:(NSArray<NSNumber *> *)floats {
    if (self = [super init]) {
        self.dict = [NSMutableDictionary dictionary];
        if (floats.count) {
            [self.dict setValue:floats[0] forKey:@(TTiPhone678)];
        }
        if (floats.count>=2) {
            [self.dict setValue:floats[1] forKey:@(TTiPhone678Plus)];
        }
        if (floats.count>=3) {
            [self.dict setValue:floats[2] forKey:@(TTiPhoneXXS)];
        }
        if (floats.count>=4) {
            [self.dict setValue:floats[3] forKey:@(TTiPhoneXRXSMAX)];
        }
        if (floats.count>=5) {
            [self.dict setValue:floats[4] forKey:@(TTiPhone55S)];
        }
    }
    return self;
}

- (CGFloat)fittingFloat {
    return [self.dict[@(TTSizeAdapter.share.currentIPhone)] floatValue];
}

@end

