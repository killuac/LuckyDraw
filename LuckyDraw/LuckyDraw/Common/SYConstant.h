//
//  SYConstant.h
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYUtility.h"
#import "SYLocalizableConstant.h"

#ifndef SYConstant_h
#define SYConstant_h

typedef void (^SYNoParameterBlockType)(void);

#define IS_IOS_VERSION_9                __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
#define UUID_STRING                     [UIDevice currentDevice].identifierForVendor.UUIDString

#define APP_VERSION                     [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
#define APP_BUNDLE_NAME                 [NSBundle mainBundle].infoDictionary[@"CFBundleName"]
#define APP_DISPLAY_NAME                [NSBundle mainBundle].localizedInfoDictionary[@"CFBundleDisplayName"]
#define APP_COPYRIGHT                   [NSBundle mainBundle].localizedInfoDictionary[@"NSHumanReadableCopyright"]

#define RESOLUTION_SIZE                 [UIScreen mainScreen].preferredMode.size
#define RESOLUTION_WIDTH                RESOLUTION_SIZE.width
#define RESOLUTION_HEIGHT               RESOLUTION_SIZE.height
#define SCREEN_SCALE                    [UIScreen mainScreen].scale
#define SCREEN_BOUNDS                   [UIScreen mainScreen].bounds
#define SCREEN_SIZE                     SCREEN_BOUNDS.size
#define SCREEN_WIDTH                    SCREEN_SIZE.width
#define SCREEN_HEIGHT                   SCREEN_SIZE.height
#define SCREEN_CENTER                   CGPointMake(CGRectGetMidX(SCREEN_BOUNDS), CGRectGetMidY(SCREEN_BOUNDS))

#define DECLARE_WEAK_SELF               __weak typeof(self) weakSelf = self
#define RADIANS(degree)                 degree * M_PI/180
#define DATA_FILE_PATH                  SYDocumentFilePath(@"data")

#define DEFAULT_INSET                   5.0f
#define SMALL_MARGIN                    5.0f
#define MEDIUM_MARGIN                   10.0
#define DEFAULT_MARGIN                  15.0
#define DEFAULT_HEADER_HEIGHT           20.0
#define DEFAULT_FOOTER_HEIGHT           20.0
#define DEFAULT_ROW_HEIGHT              44.0
#define DEFAULT_TOOLBAR_HEIGHT          44.0
#define DEFAULT_BUTTON_HEIGHT           40.0
#define DEFAULT_CORNER_RADIUS           5.0f
#define DEFAULT_ANIMATION_DURATION      0.25
#define DEFAULT_DAMPING                 0.25
#define DEFAULT_BORDER_WIDTH            2.0f

#define CELL_IDENTIFIER_COMMON          @"CommonCell"

#define SYLocalizedString(key)          NSLocalizedString(key, "")

#endif /* SYConstant_h */
