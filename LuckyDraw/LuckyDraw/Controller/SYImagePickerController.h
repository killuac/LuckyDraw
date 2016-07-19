//
//  SYImagePickerController.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHAsset+Model.h"

@class SYImagePickerController;

@protocol SYImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(SYImagePickerController *)picker didFinishPickingImages:(NSArray<PHAsset *> *)assets;
- (void)imagePickerControllerDidClose:(UIImagePickerController *)picker;

@end


@interface SYImagePickerController : UIViewController

@end
