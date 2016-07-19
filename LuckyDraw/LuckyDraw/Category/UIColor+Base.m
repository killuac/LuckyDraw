//
//  UIColor+Base.m
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright © 2015 Syzygy. All rights reserved.
//

#import "UIColor+Base.h"

@implementation UIColor (Base)

- (UIColor *)lighterColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h saturation:s brightness:MIN(b * 1.3, 1.0) alpha:a];
    return self;
}

- (UIColor *)darkerColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h saturation:s brightness:b * 0.75 alpha:a];
    return self;
}

#pragma mark - Tint color
+ (instancetype)tintColor
{
    return [UIColor colorWithRed:102/255.0 green:153/255.0 blue:161/255.0 alpha:1.0];   // 青浅葱
}

+ (instancetype)barTintColor
{
    return [UIColor colorWithRed:64/255.0 green:91/255.0 blue:85/255.0 alpha:1.0];      // 青铁御纳户
}

#pragma mark - Background color
+ (instancetype)backgroundColor
{
    return [UIColor colorWithRed:240/255.0 green:240/255.0 blue:244/255.0 alpha:1.0];   // 冷白
}

+ (instancetype)darkBackgroundColor
{
    return [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1.0];
}

#pragma mark - Text color
+ (instancetype)titleColor
{
    return [UIColor colorWithRed:55/255.0 green:60/255.0 blue:56/255.0 alpha:1.0];
}

+ (instancetype)subtitleColor
{
    return [UIColor colorWithRed:145/255.0 green:152/255.0 blue:159/255.0 alpha:1.0];   // 银鼠
}

+ (instancetype)separatorColor
{
    return [UIColor lightGrayColor];
}

#pragma mark - Button color
+ (instancetype)defaultButtonColor
{
    return [UIColor whiteColor];
}

+ (instancetype)primaryButtonColor
{
    return [UIColor tintColor];
}

+ (instancetype)destructiveButtonColor
{
    return [UIColor redColor];
}

+ (instancetype)disabledButtonColor
{
    return [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
}

+ (instancetype)linkButtonColor
{
    return [[UIColor blueColor] colorWithAlphaComponent:0.6];
}

@end
