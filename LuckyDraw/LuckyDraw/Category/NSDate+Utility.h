//
//  NSDate+Utility.h
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright (c) 2016 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)

+ (instancetype)dateWithString:(NSString *)string;

- (NSString *)toString;
- (NSString *)toDateString;
- (NSString *)toTimeString;
- (NSString *)toShortDateString;
- (NSString *)toShortTimeString;

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isThisYear;

@end
