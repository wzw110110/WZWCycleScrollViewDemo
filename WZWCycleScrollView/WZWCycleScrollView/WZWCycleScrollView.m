//
//  WZWCycleScrollView.m
//  WZWCycleScrollView
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "WZWCycleScrollView.h"
#import "WZWCollectionViewCell.h"

@interface WZWCycleScrollView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic,assign) NSInteger itemsCount;
@property (nonatomic,strong) NSTimer * timer;

@end

static NSString * cellID = @"cycleCell";

@implementation WZWCycleScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        [self setupTimer];
    }
    return self;
}

#pragma mark - 界面及属性初始化
-(void)setupView{
    //设置flowLayout
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = self.frame.size;
    
    //设置collectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor grayColor];
    [_collectionView registerClass:[WZWCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self addSubview:_collectionView];
    
}

-(void)setImageStrArr:(NSArray *)imageStrArr{
    _imageStrArr = imageStrArr;
    _itemsCount = self.imageStrArr.count * 100;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_collectionView.contentOffset.x == 0) {
        NSInteger targetIndex = _itemsCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imageStrArr:(NSArray *)imageStrArr{
    WZWCycleScrollView * cycleScrollView = [[self alloc]initWithFrame:frame];
    cycleScrollView.imageStrArr = imageStrArr;
    return cycleScrollView;
}
    

#pragma mark - 循环滚动
//启动循环滚动
-(void)setupTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

//停止循环滚动
-(void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}

-(void)autoScroll{
    NSInteger currentIndex = [self getCurrentIndex];
    NSInteger targetIndex = currentIndex + 1;
    BOOL animated = YES;
    if (targetIndex >= self.itemsCount) {
        targetIndex = self.itemsCount * 0.5;
        animated = NO;
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
}

-(NSInteger)getCurrentIndex{
    NSInteger index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5)/_flowLayout.itemSize.width;
    return index;
}

#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WZWCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.imageStrArr.count;
    NSString * imageName = self.imageStrArr[itemIndex];
    cell.imageV.image = [UIImage imageNamed:imageName];
    return cell;
}

@end
