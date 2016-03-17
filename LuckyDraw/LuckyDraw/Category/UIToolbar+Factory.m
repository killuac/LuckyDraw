//
//  UIToolbar+Factory.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/16/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "UIToolbar+Factory.h"

@implementation UIToolbar (Factory)

+ (instancetype)toolbarWithItems:(NSArray<UIBarButtonItem *> *)items
{
    return [[UIToolbar alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray<UIBarButtonItem *> *)items
{
    if (self = [super initWithFrame:CGRectZero]) {
        NSMutableArray *barItems = [NSMutableArray array];
        
        [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [barItems addObject:obj];
            if (idx < items.count - 1) {
                [barItems addObject:[UIBarButtonItem flexibleSpaceBarButtonItem]];
            }
        }];
        self.items = barItems;
    }
    
    return self;
}

@end
