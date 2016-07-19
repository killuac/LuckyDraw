//
//  SYAlbumCollectionViewCell.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYAlbumCollectionViewCell.h"

@implementation SYAlbumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
//  TODO: Add checkmark
}

- (void)configWithAsset:(id)asset
{
    [asset thumbnailImageProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//      TODO: Add load image progress
    } resultHandler:^(UIImage *image, NSDictionary *info) {
        self.imageView.image = image;
        [self setNeedsLayout];
    }];
}

@end
