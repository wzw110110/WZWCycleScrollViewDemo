//
//  ViewController.m
//  WZWCycleScrollView
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ViewController.h"
#import "WZWCycleScrollView.h"

@interface ViewController () <WZWCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        NSArray * imageNames = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    WZWCycleScrollView * cycleScrollView = [WZWCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) imageStrArr:imageNames];
    cycleScrollView.delegate = self;
    [self.view addSubview:cycleScrollView];
}

-(void)cycleScrollView:(WZWCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld张图片",index);
}

-(void)cycleScrollView:(WZWCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSLog(@"滚动到第%ld张图片",index);
}



@end
