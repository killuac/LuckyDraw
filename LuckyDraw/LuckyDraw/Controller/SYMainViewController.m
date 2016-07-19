//
//  SYMainViewController.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYMainViewController.h"
#import "SYImagePickerController.h"
#import "SYGroupViewController.h"

@interface SYMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SYMainViewController

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self prepareForUI];
    
    [self.view addTapGesture];
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    SYImagePickerController *imagePicker = [[SYImagePickerController alloc] init];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)prepareForUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - Collection view delegate


#pragma mark - Event handling
- (void)startDraw:(id)sender
{
    
}

- (void)stopDraw:(id)sender
{
    
}

- (void)shakeToStart:(id)sender
{
    
}

- (void)addPhotos:(id)sender
{
    
}

- (void)takePhoto:(id)sender
{
    
}

- (void)choosePhoto:(id)sender
{
    
}

- (void)longPressChoosePhoto:(id)sender
{
    
}

- (void)reloadPhotos:(id)sender
{
    
}

- (void)slideMenu:(id)sender
{
    
}

- (void)showDrawModes:(id)sender
{
    
}

@end
