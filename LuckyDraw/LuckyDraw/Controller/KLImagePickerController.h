//
//  KLImagePickerController.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLPhotoLibrary.h"

@class KLImagePickerController;

@protocol KLImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(KLImagePickerController *)picker didFinishPickingImages:(NSArray<PHAsset *> *)assets;
- (void)imagePickerControllerDidClose:(KLImagePickerController *)picker;

@end


@interface KLImagePickerController : UIViewController

+ (instancetype)imagePickerController;

@property (nonatomic, weak) id <KLImagePickerControllerDelegate> delegate;

@end
