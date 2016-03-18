//
//  SYAlbumViewController.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYImagePickerController.h"
#import "SYAlbumViewController.h"

@interface SYImagePickerController ()

@property (nonatomic, strong, readonly) PHPhotoLibrary *photoLibrary;
@property (nonatomic, strong) NSArray *assetCollections;
@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UINavigationBar *navigationBar;

@end

@implementation SYImagePickerController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (PHPhotoLibrary *)photoLibrary
{
    return [PHPhotoLibrary sharedPhotoLibrary];
}

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addPageViewController];
    [self addSubviews];
    
    [PHPhotoLibrary checkAuthorization:^{
        [self loadData];
    }];
}

- (void)addPageViewController
{
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    [self.pageViewController setViewControllers:@[self.viewControllers.firstObject]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)addSubviews
{

}

- (void)loadData
{
    [self.photoLibrary loadAssetCollections:^(NSArray<PHAssetCollection *> *assetCollections) {
        self.assetCollections = assetCollections;
    }];
    
    [self.photoLibrary registerChangeObserver:self];
}

- (void)dealloc
{
    [self.photoLibrary unregisterChangeObserver:self];
}

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    
}

#pragma mark - Page view controller datasource and delegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [(id)viewController pageIndex];
    if (index == 0 || index == NSNotFound) return nil;
    
    return self.viewControllers[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(id)viewController pageIndex];
    if (index == NSNotFound) return nil;
    
    return self.viewControllers[index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        
    }
}

#pragma mark - Event handling
- (void)addPhotoCompletion:(id)sender
{
    
}

- (void)closeAlbum:(id)sender
{
    
}

- (void)unselectPhotos:(id)sender
{
    
}

- (void)selectAllPhotos:(id)sender
{
    
}

@end
