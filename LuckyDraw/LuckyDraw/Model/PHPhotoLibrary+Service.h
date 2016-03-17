//
//  PHPhotoLibrary+Service.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHPhotoLibrary (Service)

+ (void)checkAuthorization:(SYNoParameterBlockType)completion;

- (void)loadAssetCollections:(void (^)(NSArray<PHAssetCollection *> *))completion;

@end
