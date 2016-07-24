//
//  SYSegmentControl.m
//  LuckyDraw
//
//  Created by Killua Liu on 7/17/16.
//  Copyright © 2016 Syzygy. All rights reserved.
//

#import "SYSegmentControl.h"

@implementation SYSegmentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    _titleLabel = [UILabel newAutoLayoutView];
    _titleLabel.font = [UIFont subtitleFont];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel constraintsCenterInSuperview];
}

- (void)setHighlighted:(BOOL)highlighted
{
    self.titleLabel.textColor = highlighted ? [self.titleLabel.textColor darkerColor] : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected
{
    self.titleLabel.textColor = selected ? [UIColor orangeColor] : [UIColor whiteColor];
}

@end


@interface SYSegmentControl () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSMutableDictionary *itemWidths;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat itemInset;
@property (nonatomic, assign) CGFloat defaultItemInset;

@end

@implementation SYSegmentControl

+ (instancetype)segmentControlWithItems:(NSArray *)items
{
    return [[self alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.defaultItemInset = SYViewDefaultMargin / 2;
        self.itemWidths = [NSMutableDictionary dictionaryWithCapacity:items.count];
        self.items = items;
        [self addSubviews];
        [self addObservers];
        
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [items enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        self.itemWidths[indexPath] = @([item widthWithFont:[UIFont titleFont]]);
    }];
}

- (void)addSubviews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, self.defaultItemInset, 0, self.defaultItemInset);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.backgroundColor = [UIColor darkBackgroundColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.collectionView registerClass:[SYSegmentCollectionViewCell class] forCellWithReuseIdentifier:CVC_REUSE_IDENTIFIER];
    [self addSubview:_collectionView];
    [self.collectionView constraintsEqualWithSuperView];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    self.itemInset = self.isNeedResizeItem ? (SCREEN_WIDTH - [self totalItemWidth]) / (self.items.count + 1) / 2 : self.defaultItemInset;
    
    UICollectionViewFlowLayout *flowLayout = (id)self.collectionView.collectionViewLayout;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, self.itemInset, 0, self.itemInset);
    [flowLayout invalidateLayout];
}

- (BOOL)isNeedResizeItem
{
    CGFloat totalWidth = [self totalItemWidth];
    return (totalWidth + self.defaultItemInset * 2 * (self.items.count + 1)) <= SCREEN_WIDTH;
}

- (CGFloat)totalItemWidth
{
    return [[self.itemWidths.allValues valueForKeyPath:@"@sum.self"] floatValue];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Collection view delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self.itemWidths[indexPath] floatValue];
    return CGSizeMake(width + self.itemInset * 2, self.height);
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYSegmentCollectionViewCell *cell = (id)[collectionView dequeueReusableCellWithReuseIdentifier:CVC_REUSE_IDENTIFIER forIndexPath:indexPath];
    cell.titleLabel.text = self.items[indexPath.item];
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.delegate segmentControl:self didSelectSegmentAtIndex:indexPath.item];
}

@end
