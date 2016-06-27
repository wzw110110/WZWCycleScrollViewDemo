//
//  WZWCycleScrollView.h
//  WZWCycleScrollView
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZWCycleScrollView : UIView

/**
 *  网络图片url数组
 */
@property (nonatomic,strong) NSArray * imageStrArr;
+(instancetype)cycleScrollViewWithFrame:(CGRect)frame imageStrArr:(NSArray *)imageStrArr;

@end
