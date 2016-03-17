//
//  UIView+Utility.h
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright (c) 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYViewProtocol <NSObject>

@optional
- (void)addSubviews;
- (void)addSubviews:(NSArray *)subviews;

- (void)addTapGesture;
- (void)removeTapGesture;
- (void)singleTap:(UITapGestureRecognizer *)recognizer;

- (void)addObservers;

@end


@interface UIView (Utility) <SYViewProtocol>

@property (nonatomic, strong, readonly) id superViewController;

@property (nonatomic, strong, readonly) id superTableView;
@property (nonatomic, strong, readonly) id superCollectionView;
@property (nonatomic, strong, readonly) id superTableViewCell;
@property (nonatomic, strong, readonly) id superCollectionViewCell;

@property (nonatomic, strong, readonly) id subTableView;
@property (nonatomic, strong, readonly) id subCollectionView;

- (void)findAndResignFirstResponder;

- (void)addBlurBackground;
- (void)removeBlurBackground;

@end
