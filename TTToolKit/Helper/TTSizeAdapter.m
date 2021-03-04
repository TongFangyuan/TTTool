//
//  TTViewSizeAdapter.m
//  TTToolSamples
//
//  Created by Tong on 2019/8/6.
//  Copyright © 2019 tongfy. All rights reserved.
//

#define TTIPhone55S             CGSizeMake(320.f, 568.f)
#define TTIPhone678Size         CGSizeMake(375.f, 667.f)       // iPhone 6/6S/7/8
#define TTIPhone678PlusSize     CGSizeMake(414.f, 736.f)   // iPhone 6 P/6S P/7 P/8 P
#define TTIPhoneXXSSize         CGSizeMake(375.f, 812.f)       // iPhone X/XS/11 Pro/12 mini
#define TTIPhoneXRXSMAXSize     CGSizeMake(414.f, 896.f)   // iPhone XR/11/XS Max/11 Pro Max
#define TTIPhone12Size          CGSizeMake(390.f,844.f)         // iPhone 12/12 Pro
#define TTIPhone12ProMaxSize    CGSizeMake(428.f,926.f)       // iPhone 12 Pro Max

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
                     @(TTiPhone55S):NSStringFromCGSize(TTIPhone55S),
                     @(TTiPhone12):NSStringFromCGSize(TTIPhone12Size),
                     @(TTiPhone12ProMax):NSStringFromCGSize(TTIPhone12ProMaxSize)
                     };
    
    self.iPhoneMap = @{
                       NSStringFromCGSize(TTIPhone678Size):@(TTiPhone678),
                       NSStringFromCGSize(TTIPhone678PlusSize):@(TTiPhone678Plus),
                       NSStringFromCGSize(TTIPhoneXXSSize):@(TTiPhoneXXS),
                       NSStringFromCGSize(TTIPhoneXRXSMAXSize):@(TTiPhoneXRXSMAX),
                       NSStringFromCGSize(TTIPhone55S):@(TTiPhone55S),
                       NSStringFromCGSize(TTIPhone12Size):@(TTiPhone12),
                       NSStringFromCGSize(TTIPhone12ProMaxSize):@(TTiPhone12ProMax)
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
        if (floats.count>=6) {
            [self.dict setValue:floats[5] forKey:@(TTiPhone12)];
        }
        if (floats.count>=7) {
            [self.dict setValue:floats[6] forKey:@(TTiPhone12ProMax)];
        }
    }
    return self;
}

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict  {
    if (self = [super init]) {
        self.dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    return self;
}

- (CGFloat)fittingFloat {
    return [self.dict[@(TTSizeAdapter.share.currentIPhone)] floatValue];
}

@end

