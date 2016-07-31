//
//  KLAlbumViewController.m
//  LuckyDraw
//
//  Created by Killua Liu on 3/18/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "KLAlbumViewController.h"
#import "KLAlbumCell.h"
#import "KLImagePickerController.h"

@interface KLAlbumViewController ()

@property (nonatomic, strong) KLImagePickerViewModel *viewModel;
@property (nonatomic, strong) NSArray *assets;

@property (nonatomic, strong) KLImagePickerController *imagePicker;

@end

@implementation KLAlbumViewController

+ (instancetype)viewControllerWithPageIndex:(NSUInteger)pageIndex viewModel:(id)viewModel
{
    return [[self alloc] initWithPageIndex:pageIndex viewModel:viewModel];
}

- (instancetype)initWithPageIndex:(NSUInteger)pageIndex viewModel:(id)viewModel
{
    if (self = [super initWithCollectionViewLayout:[UICollectionViewFlowLayout new]]) {
        _pageIndex = pageIndex;
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForUI];
    [self addObservers];
}

- (void)prepareForUI
{
    UICollectionViewFlowLayout *flowLayout = (id)self.collectionViewLayout;
    CGFloat w, h, spacing = 3.0f;
    w = h = (self.view.width - spacing * 3) / 4;
    flowLayout.itemSize = CGSizeMake(w, h);
    flowLayout.minimumLineSpacing = spacing;
    flowLayout.minimumInteritemSpacing = spacing;
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.collectionView registerClass:[KLAlbumCell class] forCellWithReuseIdentifier:CVC_REUSE_IDENTIFIER];
}

- (void)addObservers
{
    self.KVOController = [FBKVOController controllerWithObserver:self];
    [self.KVOController observe:self.viewModel keyPath:NSStringFromSelector(@selector(assets)) options:0 action:@selector(reloadData)];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.selectedCollectionAssetCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CVC_REUSE_IDENTIFIER forIndexPath:indexPath];
    [cell configWithAsset:[self.viewModel assetAtIndex:indexPath.item]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}

@end
