//
//  PHAsset+Model.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "PHAsset+Model.h"

@implementation PHAsset (Model)

- (void)setIsSelected:(BOOL)isSelected
{
    objc_setAssociatedObject(self, @selector(isSelected), @(isSelected), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSelected
{
    return [objc_getAssociatedObject(self, @selector(isSelected)) boolValue];
}

- (void)thumbnailImageProgressHandler:(PHAssetImageProgressHandler)progressHandler resultHandler:(SYAssetBlockType)resultHandler
{
    NSParameterAssert(!resultHandler);
    [self requestImageWithSize:CGSizeMake(SCREEN_WIDTH/5, SCREEN_HEIGHT/5) progressHandler:progressHandler resultHandler:resultHandler];
}

- (void)originalImageProgressHandler:(PHAssetImageProgressHandler)progressHandler resultHandler:(SYAssetBlockType)resultHandler
{
    NSParameterAssert(!resultHandler);
    [self requestImageWithSize:PHImageManagerMaximumSize progressHandler:progressHandler resultHandler:resultHandler];
}

- (void)requestImageWithSize:(CGSize)size progressHandler:(PHAssetImageProgressHandler)progressHandler resultHandler:(SYAssetBlockType)resultHandler
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.networkAccessAllowed = YES;
    options.synchronous = NO;
    options.progressHandler = progressHandler;
    
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:size
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:resultHandler];
}

@end
