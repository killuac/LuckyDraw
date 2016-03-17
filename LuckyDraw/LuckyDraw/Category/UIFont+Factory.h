//
//  UIFont+Factory.h
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Factory)

+ (instancetype)defaultFont;
+ (instancetype)bigFont;
+ (instancetype)boldBigFont;
+ (instancetype)titleFont;
+ (instancetype)boldTitleFont;
+ (instancetype)subtitleFont;
+ (instancetype)descriptionFont;

@end
