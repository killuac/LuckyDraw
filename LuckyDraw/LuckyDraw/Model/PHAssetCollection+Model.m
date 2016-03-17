//
//  PHAssetCollection+Model.m
//  LuckyDraw
//
//  Created by Bing Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "PHAssetCollection+Model.h"

@interface PHAssetCollection ()

@property (nonatomic, strong) PHFetchResult *fetchResult;

@end

@implementation PHAssetCollection (Model)

- (void)setFetchResult:(PHFetchResult *)fetchResult
{
    objc_setAssociatedObject(self, @selector(fetchResult), fetchResult, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PHFetchResult *)fetchResult
{
    PHFetchResult *results = objc_getAssociatedObject(self, @selector(fetchResult));
    if (!results) {
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        results = [PHAsset fetchAssetsInAssetCollection:self options:options];
    }
    return results;
}

- (NSUInteger)assetCount
{
    return self.fetchResult.count;
}

- (NSArray<PHAsset *> *)assets
{
    NSMutableArray *assetArray = [NSMutableArray array];
    [self.fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
        if (asset) [assetArray addObject:asset];
    }];
    return assetArray;
}

- (void)posterImage:(SYAssetBlockType)resultHandler
{
    [self.assets.lastObject thumbnailImageProgressHandler:nil resultHandler:resultHandler];
}

@end
