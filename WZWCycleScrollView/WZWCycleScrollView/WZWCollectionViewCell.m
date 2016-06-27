//
//  WZWCollectionViewCell.m
//  WZWCycleScrollView
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "WZWCollectionViewCell.h"

@implementation WZWCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupViews];
    }
    return self;
}

#pragma mark - 设置子控件
-(void)setupViews{
    _imageV = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageV.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_imageV];
}

@end
