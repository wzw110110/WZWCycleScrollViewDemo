//
//  WZWCycleScrollView.h
//  WZWCycleScrollView
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZWCycleScrollView;
@protocol WZWCycleScrollViewDelegate <NSObject>

/** 图片点击回调 */
-(void)cycleScrollView:(WZWCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
-(void)cycleScrollView:(WZWCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;
@end

@interface WZWCycleScrollView : UIView

/**
 *  网络图片url数组
 */
@property (nonatomic,strong) NSArray * imageStrArr;
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imageStrArr:(NSArray *)imageStrArr;

@property (nonatomic,weak) id<WZWCycleScrollViewDelegate>delegate;
/**
 *  图片滚动方向，默认是水平滚动
 */
@property (nonatomic,assign) UICollectionViewScrollDirection scrollDirection;
@end
