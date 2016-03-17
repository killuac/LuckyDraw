//
//  PHAsset+Model.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <Photos/Photos.h>

typedef void (^SYAssetBlockType)(UIImage *image, NSDictionary *info);

@interface PHAsset (Model)

- (void)thumbnailImageProgressHandler:(PHAssetImageProgressHandler)progressHandler resultHandler:(SYAssetBlockType)resultHandler;
- (void)originalImageProgressHandler:(PHAssetImageProgressHandler)progressHandler resultHandler:(SYAssetBlockType)resultHandler;

@end
