//
//  KLImagePickerViewModel.h
//  LuckyDraw
//
//  Created by Killua Liu on 7/31/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHAssetCollection+Model.h"

@interface KLImagePickerViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray<PHAssetCollection *> *assetCollections;
@property (nonatomic, strong, readonly) NSArray<NSString *> *collectionTitles;

@property (nonatomic, strong, readonly) PHAssetCollection *selectedAssetCollection;
@property (nonatomic, assign, readonly) NSUInteger selectedCollectionAssetCount;

@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign, readonly) BOOL isPageScrollEnabled;
@property (nonatomic, assign, readonly) NSUInteger collectionCount;

- (void)checkAuthorization:(KLVoidBlockType)handler;
- (PHAsset *)assetAtIndex:(NSUInteger)index;

@end
