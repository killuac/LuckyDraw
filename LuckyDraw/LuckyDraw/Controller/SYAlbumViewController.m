//
//  SYAlbumViewController.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYAlbumViewController.h"
#import "SYAlbumCollectionViewCell.h"
#import "SYImagePickerController.h"

@interface SYAlbumViewController ()

@property (nonatomic, strong) PHAssetCollection *assetCollection;
@property (nonatomic, strong) NSArray *assets;

@property (nonatomic, strong) SYImagePickerController *imagePicker;

@end

@implementation SYAlbumViewController

+ (instancetype)albumViewControllerWithPageIndex:(NSUInteger)index assetCollection:(PHAssetCollection *)collection imagePicker:(SYImagePickerController *)picker
{
    return [[self alloc] initWithPageIndex:index assetCollection:collection imagePicker:picker];
}

- (instancetype)initWithPageIndex:(NSUInteger)index assetCollection:(PHAssetCollection *)collection imagePicker:(SYImagePickerController *)picker
{
    if (self = [super init]) {
        _pageIndex = index;
        _assetCollection = collection;
        _imagePicker = picker;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat spacing = 3.0f;
    CGFloat WH = (self.view.width - spacing * 3) / 4;
    flowLayout.itemSize = CGSizeMake(WH, WH);
    flowLayout.minimumLineSpacing = spacing;
    flowLayout.minimumInteritemSpacing = spacing;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, DEFAULT_TOOLBAR_HEIGHT, 0);
    [self.collectionView registerClass:[SYAlbumCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER_COMMON];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER_COMMON forIndexPath:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

@end
