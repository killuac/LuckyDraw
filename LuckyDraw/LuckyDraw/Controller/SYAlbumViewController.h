//
//  SYAlbumViewController.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHPhotoLibrary+Model.h"

@class SYImagePickerController;

@interface SYAlbumViewController : UICollectionViewController

+ (instancetype)albumViewControllerWithPageIndex:(NSUInteger)index assetCollection:(PHAssetCollection *)collection imagePicker:(SYImagePickerController *)picker;

@property (nonatomic, assign, readonly) NSUInteger pageIndex;

@end
