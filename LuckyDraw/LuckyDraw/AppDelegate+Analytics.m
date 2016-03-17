//
//  AppDelegate+Analytics.m
//  LuckyDraw
//
//  Created by Killua Liu on 1/19/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "AppDelegate+Analytics.h"

NSString *const SYLogPageViewName = @"SYLogPageViewName";
NSString *const SYLogTrackedEvents = @"SYLogTrackedEvents";
NSString *const SYLogEventName = @"SYLogEventName";
NSString *const SYLogEventSelectorName = @"SYLogEventSelectorName";
NSString *const SYLogEventHandlerBlock = @"SYLogEventHandlerBlock";

typedef void (^SYAspectHandlerBlock)(id<AspectInfo> aspectInfo);


@interface AppDelegate ()

@property (nonatomic, strong) NSDictionary *configs;

@end

@implementation AppDelegate (Analytics)

- (void)setupAppAnalytics
{
    [self setupUMeng];
    [self loadConfiguration];
    [self setupWithConfiguration];
}

- (void)setupUMeng
{
    NSString *appKey = @"";
#if DEBUG
    [MobClick startWithAppkey:appKey reportPolicy:REALTIME channelId:@"Development"];
#else
    [MobClick startWithAppkey:appKey reportPolicy:BATCH channelId:@"App Store"];
#endif
    [MobClick setAppVersion:XcodeAppVersion];
}

- (void)loadConfiguration
{
    self.configs = @{
            @"SYMainViewController": @{
                    SYLogTrackedEvents: @[
                            @{ SYLogEventName: @"MainVC_ShakeStart", SYLogEventSelectorName: @"shakeToStart:" },
                            @{ SYLogEventName: @"MainVC_StartDraw", SYLogEventSelectorName: @"startDraw:" },
                            @{ SYLogEventName: @"MainVC_StopDraw", SYLogEventSelectorName: @"stopDraw:" },
                            @{ SYLogEventName: @"MainVC_AddPhotos", SYLogEventSelectorName: @"addPhotos:" },
                            @{ SYLogEventName: @"MainVC_TakePhoto", SYLogEventSelectorName: @"takePhoto:" },
                            @{ SYLogEventName: @"MainVC_ChoosePhoto", SYLogEventSelectorName: @"choosePhoto:" },
                            @{ SYLogEventName: @"MainVC_LongPressChoose", SYLogEventSelectorName: @"longPressChoosePhoto:" },
                            @{ SYLogEventName: @"MainVC_ReloadPhotos", SYLogEventSelectorName: @"reloadPhotos:" },
                            @{ SYLogEventName: @"MainVC_SlideMenu", SYLogEventSelectorName: @"slideMenu:" },
                            @{ SYLogEventName: @"MainVC_ShowDrawModes", SYLogEventSelectorName: @"showDrawModes:" }]
                    },
            @"SYAlbumViewController": @{
                    SYLogTrackedEvents: @[
                            @{ SYLogEventName: @"AlbumVC_AddPhotoCompletion", SYLogEventSelectorName: @"addPhotoCompletion:" },
                            @{ SYLogEventName: @"AlbumVC_CloseAlbum", SYLogEventSelectorName: @"closeAlbum:" },
                            @{ SYLogEventName: @"AlbumVC_UnselectPhotos", SYLogEventSelectorName: @"unselectPhotos:" },
                            @{ SYLogEventName: @"AlbumVC_SelectAllPhotos", SYLogEventSelectorName: @"selectAllPhotos:" }]
                    }
            };
}

- (void)setConfigs:(NSDictionary *)configs
{
    objc_setAssociatedObject(self, @selector(configs), configs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)configs
{
    return objc_getAssociatedObject(self, @selector(configs));
}

// aspectInfo.instance is not thread safe, so only call this method in main thread.
- (NSString *)pageViewNameForAspectInfo:(id<AspectInfo>)aspectInfo
{
    NSString *className = NSStringFromClass([aspectInfo.instance class]);
    NSString *pageViewName = self.configs[className][SYLogPageViewName];
    
    return (pageViewName ? pageViewName : className);
}

- (void)setupWithConfiguration
{
//  Hook view controllers
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        if ([self isNeedLoggingForAspectInfo:aspectInfo]) {
            NSString *pageViewName = [self pageViewNameForAspectInfo:aspectInfo];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [MobClick beginLogPageView:pageViewName];
            });
        }
    } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        if ([self isNeedLoggingForAspectInfo:aspectInfo]) {
            NSString *pageViewName = [self pageViewNameForAspectInfo:aspectInfo];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [MobClick endLogPageView:pageViewName];
            });
        }
    } error:NULL];
    
//  Hook events
    [self.configs.allKeys enumerateObjectsUsingBlock:^(NSString *className, NSUInteger idx, BOOL *stop) {
        Class clazz = NSClassFromString(className);
        NSDictionary *config = self.configs[className];
        
        [config[SYLogTrackedEvents] enumerateObjectsUsingBlock:^(NSDictionary *event, NSUInteger idx, BOOL *stop) {
            SEL selector = NSSelectorFromString(event[SYLogEventSelectorName]);
            SYAspectHandlerBlock block = event[SYLogEventHandlerBlock];
            
            [clazz aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if (block) {
                        block(aspectInfo);
                    } else {
                        [MobClick event:event[SYLogEventName]];
                    }
                });
            } error:NULL];
        }];
    }];
}

- (BOOL)isNeedLoggingForAspectInfo:(id<AspectInfo>)aspectInfo
{
    return ([NSStringFromClass([aspectInfo.instance class]) hasPrefix:@"SY"]);
}

@end