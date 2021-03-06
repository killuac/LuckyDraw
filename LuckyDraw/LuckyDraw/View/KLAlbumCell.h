//
//  KLAlbumCell.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHAsset+Model.h"

@interface KLAlbumCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView *imageView;

- (void)configWithAsset:(PHAsset *)asset;

@end
