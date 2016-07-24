//
//  SYSegmentControl.h
//  LuckyDraw
//
//  Created by Killua Liu on 7/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYSegmentCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;

@end


@class SYSegmentControl;
@protocol SYSegmentControlDelegate <NSObject>

- (void)segmentControl:(SYSegmentControl *)segmentControl didSelectSegmentAtIndex:(NSUInteger)index;

@end


@interface SYSegmentControl : UIView

+ (instancetype)segmentControlWithItems:(NSArray *)items;   // items can be NSStrings

@property (nonatomic, weak) id <SYSegmentControlDelegate> delegate;

@end
