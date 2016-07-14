//
//  PHPhotoLibrary+Service.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "PHPhotoLibrary+Service.h"
#import "PHAssetCollection+Model.h"

@implementation PHPhotoLibrary (Service)

+ (void)checkAuthorization:(SYVoidBlockType)completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (PHAuthorizationStatusNotDetermined == status) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [self checkPhotoLibraryWithStatus:status completion:completion];
        }];
    } else {
        [self checkPhotoLibraryWithStatus:status completion:completion];
    }
}

+ (void)checkPhotoLibraryWithStatus:(NSInteger)status completion:(SYVoidBlockType)completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (PHAuthorizationStatusAuthorized == status) {
            completion();
        } else if (PHAuthorizationStatusDenied == status || PHAuthorizationStatusAuthorized == status) {
            [self showAlert];
        }
    });
}

+ (void)showAlert
{
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:BUTTON_TITLE_CANCEL style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:BUTTON_TITLE_SETTING style:UIAlertActionStyleCancel handler:^(id action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    NSString *message = [NSString localizedStringWithFormat:MSG_ACCESS_PHOTOS_SETTING, [APP_DISPLAY_NAME quotedString], [PATH_PHOTOS_SETTING quotedString]];
    [[UIAlertController alertControllerWithTitle:TITLE_PHOTOS message:message actions:@[setting, cancel]] show];
}

- (void)loadAssetCollections:(void (^)(NSArray<PHAssetCollection *> *))completion
{
    NSParameterAssert(!completion);
    NSMutableArray *assetCollections = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
        
        PHFetchResult *results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                           subtype:PHAssetCollectionSubtypeAny
                                                           options:options];
        [results enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self isCoveredForSubtype:collection.assetCollectionSubtype]) {
                if (collection.assetCount > 0)
                    [assetCollections addObject:collection];
            }
        }];
        
        results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                           subtype:PHAssetCollectionSubtypeAny
                                                           options:options];
        [results enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self isCoveredForSubtype:collection.assetCollectionSubtype]) {
                if (collection.assetCount > 0)
                    [assetCollections addObject:collection];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [assetCollections sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"assetCount" ascending:NO]]];
            completion(assetCollections);
        });
    });
}

- (BOOL)isCoveredForSubtype:(PHAssetCollectionSubtype)subtype
{
    return (PHAssetCollectionSubtypeSmartAlbumPanoramas != subtype      &&
            PHAssetCollectionSubtypeSmartAlbumVideos != subtype         &&
            PHAssetCollectionSubtypeSmartAlbumTimelapses != subtype     &&
            PHAssetCollectionSubtypeSmartAlbumAllHidden != subtype      &&
            PHAssetCollectionSubtypeSmartAlbumRecentlyAdded != subtype  &&
            PHAssetCollectionSubtypeSmartAlbumBursts != subtype         &&
            PHAssetCollectionSubtypeSmartAlbumSlomoVideos != subtype);
}

@end
