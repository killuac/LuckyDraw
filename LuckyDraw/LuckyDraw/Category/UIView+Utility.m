//
//  UIView+Utility.m
//  LuckyDraw
//
//  Created by Killua Liu on 12/16/15.
//  Copyright (c) 2016 Syzygy. All rights reserved.
//

#import "UIView+Utility.h"

@implementation UIView (Utility)

- (id)superViewController
{
    for (UIView *view = self.superview; view; view = view.superview) {
        UIResponder* nextResponder = view.nextResponder;
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return nextResponder;
        }
    }
    
    return nil;
}

#pragma mark - Super and sub view
- (id)superTableView
{
    if ([self.superview isKindOfClass:[UITableView class]]) {
        return self.superview;
    } else {
        return [self.superview superTableView];
    }
}

- (id)superCollectionView
{
    if ([self.superview isKindOfClass:[UICollectionView class]]) {
        return self.superview;
    } else {
        return [self.superview superCollectionView];
    }
}

- (id)superTableViewCell
{
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return self.superview;
    } else {
        return [self.superview superTableViewCell];
    }
}

- (id)superCollectionViewCell
{
    if ([self.superview isKindOfClass:[UICollectionViewCell class]]) {
        return self.superview;
    } else {
        return [self.superview superCollectionViewCell];
    }
}

- (id)subTableView
{
    id resultView = nil;
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UITableView class]]) {
            resultView = subview;
        } else {
            resultView = [subview subTableView];
        }
    }
    return resultView;
}

- (id)subCollectionView
{
    id resultView = nil;
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UICollectionView class]]) {
            resultView = subview;
        } else if ([subview subviews].count > 0) {
            resultView = [subview subCollectionView];
        }
    }
    return resultView;
}

#pragma mark - Gesture
- (void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:tap];
}

- (void)removeTapGesture
{
    [self removeGestureRecognizer:self.gestureRecognizers.firstObject];
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    [self findAndResignFirstResponder];
}

- (void)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return;
    }
    
    if (self.subviews.count != 0) {
        for (UIView *subView in self.subviews) {
            [subView findAndResignFirstResponder];
        }
    } else {
        return;
    }
}

#pragma mark - Blur background view
- (void)addBlurBackground
{
    [self removeBlurBackground];
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *blurBackground = [[UIImageView alloc] initWithImage:[image gaussianBlurWithBias:20]];
    blurBackground.tag = 100;
    blurBackground.userInteractionEnabled = YES;
    [self addSubview:blurBackground];
}

- (void)removeBlurBackground
{
    [[self viewWithTag:100] removeFromSuperview];
}

@end
