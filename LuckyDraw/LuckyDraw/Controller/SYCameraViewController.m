//
//  SYCameraViewController.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYCameraViewController.h"
@import AVFoundation;

@implementation SYCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.delegate = self;
    
    [self.class checkAuthorization:nil];
}

+ (void)checkAuthorization:(SYNoParameterBlockType)completion
{
    if (![self isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if (completion) completion();
                } else {
                    [self showAlert];
                }
            }];
            break;
        }
            
        case AVAuthorizationStatusAuthorized:
            if (completion) completion();
            break;
            
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            [self showAlert];
            break;
    }
}

+ (void)showAlert
{
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:BUTTON_TITLE_CANCEL style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:BUTTON_TITLE_SETTING style:UIAlertActionStyleCancel handler:^(id action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    [[UIAlertController alertControllerWithTitle:TITLE_CAMERA message:MSG_ACCESS_CAMERA_SETTING actions:@[setting, cancel]] show];
}

@end
