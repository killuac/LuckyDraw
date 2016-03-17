//
//  SYGroupModel.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SYGroupModel : JSONModel

@property (nonatomic, strong) NSArray *assetLocalIdentifiers;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, assign, readonly) NSUInteger photoCount;

+ (NSArray *)fetchAllGroups;

@end
