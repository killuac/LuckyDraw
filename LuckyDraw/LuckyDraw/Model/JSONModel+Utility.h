//
//  JSONModel+Utility.h
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright (c) 2016 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "NSArray+Model.h"

@interface JSONModel (Utility)

@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)model;
+ (instancetype)modelWithString:(NSString *)string;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithData:(NSData *)data;

@end
