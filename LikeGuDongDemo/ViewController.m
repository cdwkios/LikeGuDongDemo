//
//  ViewController.m
//  LikeGuDongDemo
//
//  Created by jianjun-wu on 2017/3/14.
//  Copyright © 2017年 jianjun-wu. All rights reserved.
//

#import "ViewController.h"
#import "TrainShowView.h"

@interface ViewController ()<UIScrollViewDelegate>
{

    UIView *OperAtionView;
    
    
}

#define scwidth 0.2


@property(nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,assign)CGFloat lastValue;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TrainShowView *tsv=[[TrainShowView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tsv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
