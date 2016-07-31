//
//  KLImagePickerViewModel.m
//  LuckyDraw
//
//  Created by Killua Liu on 7/31/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "KLImagePickerViewModel.h"

@interface KLImagePickerViewModel () <PHPhotoLibraryChangeObserver>

@property (nonatomic, strong, readonly) PHPhotoLibrary *photoLibrary;
@property (nonatomic, strong) NSMutableArray *assetCollectionArray;

@end

@implementation KLImagePickerViewModel

- (void)checkAuthorization:(KLVoidBlockType)handler
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (PHAuthorizationStatusNotDetermined == status) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [self checkPhotoLibraryWithStatus:status handler:handler];
        }];
    } else {
        [self checkPhotoLibraryWithStatus:status handler:handler];
    }
}

- (void)checkPhotoLibraryWithStatus:(NSInteger)status handler:(KLVoidBlockType)handler
{
    NSParameterAssert(handler);
    
    if (PHAuthorizationStatusAuthorized == status) {
        [self fetchAssetCollections];
    } else if (PHAuthorizationStatusDenied == status || PHAuthorizationStatusAuthorized == status) {
        handler();
    }
}

#pragma mark - Lifecycle
- (instancetype)init
{
    if (self = [super init]) {
        _assetCollections = [NSMutableArray array];
        [self.photoLibrary registerChangeObserver:self];
    }
    return self;
}

- (PHPhotoLibrary *)photoLibrary
{
    return [PHPhotoLibrary sharedPhotoLibrary];
}

- (void)dealloc
{
    [self.photoLibrary unregisterChangeObserver:self];
}

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    
}

#pragma mark - Public method
- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
    _currentPageIndex = currentPageIndex;
    _selectedAssetCollection = self.assetCollections[currentPageIndex];
    [self.selectedAssetCollection fetchAssets];
}

- (NSUInteger)selectedCollectionAssetCount
{
    return self.selectedAssetCollection.assetCount;
}

- (void)fetchAssetCollections
{
    dispatch_group_t group = dispatch_group_create();
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
    
    [self fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum options:options inGCDGroup:group];
    [self fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum options:options inGCDGroup:group];
    
    KLDispatchGroupMainNotify(group, ^{
        [self.assetCollectionArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"assetCount" ascending:NO]]];
        _assetCollections = self.assetCollectionArray;
    });
}

- (void)fetchAssetCollectionsWithType:(PHAssetCollectionType)type options:(PHFetchOptions *)options inGCDGroup:(dispatch_group_t)group
{
    KLDispatchGroupGlobalAsync(group, ^{
        PHFetchResult *results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:options];
        [results enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self isCoveredForSubtype:collection.assetCollectionSubtype]) {
                @synchronized (self) {
                    if (collection.assetCount > 0)
                        [self.assetCollectionArray addObject:collection];
                }
            }
        }];
    });
}

- (PHAsset *)assetAtIndex:(NSUInteger)index
{
    return self.selectedAssetCollection.assets[index];
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
