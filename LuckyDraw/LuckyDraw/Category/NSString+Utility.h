//
//  NSString+Utility.h
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright (c) 2016 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utility)

- (NSString *)toMD5String;
- (NSString *)toSHA1String;

- (NSString *)toBase62String;
- (NSString *)fromBase62String;
- (NSString *)increment;
- (NSString *)decrement;

- (BOOL)isValidMobile;
- (BOOL)isValidEmail;
- (BOOL)isValidPassword;
- (BOOL)isValidSMSCode;

- (BOOL)containsUnicodeCharacter;
- (BOOL)isNumberCharacter;
- (BOOL)isEmailCharacter;
- (BOOL)isNicknameCharacter;

- (CGFloat)widthWithFont:(UIFont *)font;
- (CGFloat)heightWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)width;

@end
