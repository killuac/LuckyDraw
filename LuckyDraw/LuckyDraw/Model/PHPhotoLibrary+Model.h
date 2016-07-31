//
//  PHPhotoLibrary+Model.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHPhotoLibrary (Model)

+ (void)checkAuthorization:(KLVoidBlockType)completion;

@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign, readonly) BOOL isPageScrollEnabled;

- (void)loadAssetCollections:(void (^)(NSArray<PHAssetCollection *> *assetCollections))completion;

@end
