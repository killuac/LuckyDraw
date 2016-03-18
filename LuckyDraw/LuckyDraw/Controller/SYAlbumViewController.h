//
//  SYAlbumViewController.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHPhotoLibrary+Service.h"

@interface SYAlbumViewController : UICollectionViewController

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
