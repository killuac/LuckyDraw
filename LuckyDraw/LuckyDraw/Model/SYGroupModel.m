//
//  SYGroupModel.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYGroupModel.h"

@implementation SYGroupModel

- (NSUInteger )photoCount
{
    return self.assetLocalIdentifiers.count;
}

@end
