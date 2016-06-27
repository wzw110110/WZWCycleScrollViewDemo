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
@property (nonatomic,strong) UIPageControl * pageControl;

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
    
    //设置pageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(10, 170, 100, 20)];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    _pageControl.numberOfPages = 4;
    [self addSubview:_pageControl];
    
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

-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    _flowLayout.scrollDirection = scrollDirection;
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
    NSInteger index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ) {
        index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5)/_flowLayout.itemSize.width;
    }else{
       index = (_collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5)/_flowLayout.itemSize.height;
    }
    
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

-(void)collectionView:(UICollectionView *)collectionView    didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger currentIndex = indexPath.item % self.imageStrArr.count;
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:currentIndex];
    }
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = [self getCurrentIndex];
    NSInteger currentPage = index % self.imageStrArr.count;
    self.pageControl.currentPage = currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation");
    NSInteger index = [self getCurrentIndex];
    NSInteger currentPage = index % self.imageStrArr.count;
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
        [self.delegate cycleScrollView:self didScrollToIndex:currentPage];
    }
}

@end
