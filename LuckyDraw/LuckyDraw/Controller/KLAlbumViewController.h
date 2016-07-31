//
//  KLAlbumViewController.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLImagePickerViewModel;

@interface KLAlbumViewController : UICollectionViewController

+ (instancetype)viewControllerWithPageIndex:(NSUInteger)pageIndex viewModel:(KLImagePickerViewModel *)viewModel;

@property (nonatomic, assign, readonly) NSUInteger pageIndex;

@end
