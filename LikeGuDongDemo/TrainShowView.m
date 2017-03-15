//
//  TrainShowView.m
//  LikeGuDongDemo
//
//  Created by jianjun-wu on 2017/3/14.
//  Copyright © 2017年 jianjun-wu. All rights reserved.
//

#import "TrainShowView.h"
#import "UIView+SDAutoLayout.h"

#define scwidth 0.2

@interface TrainShowView()<UIScrollViewDelegate>
{
    UIView *OperAtionView;
    UIScrollView *_pScrollView;
    UIView *pointView;
    
}

@property(nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,assign)CGFloat lastValue;

@property(nonatomic,strong)NSMutableArray *titleLabelArray;


@end


@implementation TrainShowView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self Init_UI];
    }
    return self;
}


#pragma mark -getter

-(NSMutableArray *)titleLabelArray
{
  if(_titleLabelArray==nil)
  {
      _titleLabelArray=[NSMutableArray array];
  }
    
  return _titleLabelArray;
}

-(void)Init_UI
{
    //显示的页面数量
    NSInteger pageCount=4;
    
    self.backgroundColor= [UIColor colorWithRed:32.0f/255 green:160.f/255 blue:255.0/255 alpha:1];
    

    
    
    
    OperAtionView=[[UIView alloc] initWithFrame:CGRectMake(0,self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height*2)];
    OperAtionView.layer.anchorPoint= CGPointMake(0.5f, 1.0f);
    [self addSubview:OperAtionView];
    
    
    self.currentIndex = 0 ;
    self.lastValue = 0;
    
    for (int i = 0; i<pageCount; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,//(self.view.bounds.size.width-self.view.bounds.size.width/4)/2,
                                                                self.bounds.size.height,
                                                                self.bounds.size.width,
                                                                self.bounds.size.height*2)];
        
        view.layer.borderWidth=1;
        view.layer.borderColor=[UIColor whiteColor].CGColor;
        
        view.backgroundColor=[UIColor greenColor];
        
        if(i%10==0)
        {
            view.backgroundColor=[UIColor blackColor];
        }
        else if (i%10==1)
        {
            view.backgroundColor=[UIColor yellowColor];
            
        }
        else if (i%10==2)
        {
            view.backgroundColor=[UIColor redColor];
            
        }
        else if(i%10==3)
        {
            view.backgroundColor=[UIColor greenColor];
            
        }
        else if(i==4)
        {
            view.backgroundColor=[UIColor grayColor];
            
        }
        else if(i==5)
        {
            view.backgroundColor=[UIColor darkTextColor];
        }
        
        
        
        view.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
        view.transform= CGAffineTransformMakeRotation(M_PI*scwidth*i);
        
        [OperAtionView addSubview:view];
     }
    
    
    
    
    _pScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _pScrollView.showsHorizontalScrollIndicator = NO;
    _pScrollView.showsVerticalScrollIndicator = NO;
    //_pScrollView.scrollsToTop = NO;
    _pScrollView.pagingEnabled=YES;
    _pScrollView.bounces=NO;
    _pScrollView.userInteractionEnabled=YES;
    _pScrollView.delegate = self;
    //_pScrollView.backgroundColor = [UIColor colorWithRed:28.0f/255 green:185.0f/255 blue:110.f/255 alpha:1];
    [self addSubview:_pScrollView];
    
    
    [_pScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_pScrollView setContentSize:CGSizeMake(self.frame.size.width*pageCount,self.bounds.size.height)];

    
    
    //添加title
    NSArray *titleArray=@[@"科目一",@"科目二",@"科目三",@"科目四"];
    
    for (int i=0; i<[titleArray count]; i++)
    {
        UILabel *label=[[UILabel alloc] init];
        label.text=titleArray[i];
        label.frame=CGRectMake(i*self.bounds.size.width/[titleArray count], 0, self.bounds.size.width/[titleArray count], 40);
        label.font=[UIFont systemFontOfSize:14];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        
        [self.titleLabelArray addObject:label];
    }
    
    //添加point
    UILabel *fristLabel=(UILabel *)self.titleLabelArray[0];
    pointView=[[UIView alloc] initWithFrame:CGRectMake((fristLabel.width-6)/2, fristLabel.bottom,6,6)];
    pointView.backgroundColor=[UIColor whiteColor];
    pointView.layer.cornerRadius=3;
    [self addSubview:pointView];
    
    
    
    UIView *bottomMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , OperAtionView.size.height-100, OperAtionView.size.height-100)];
    bottomMenuView.center =CGPointMake( self.bounds.size.width/2,self.bounds.size.height*1.5);
    bottomMenuView.backgroundColor = [UIColor whiteColor];
    bottomMenuView.layer.cornerRadius = bottomMenuView.frame.size.height/2;
    [self addSubview:bottomMenuView];


    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.currentIndex=offset.x/self.bounds.size.width;
    _lastValue = 0;
    
    
    UILabel *fristLabel=(UILabel *)self.titleLabelArray[0];
    if(fristLabel)
    {
       pointView.frame=CGRectMake(self.currentIndex*(self.bounds.size.width)/4+(fristLabel.width-6)/2,fristLabel.bottom+2,6,6);
    }
    
    if(self.currentIndex==0)
        OperAtionView.transform=CGAffineTransformIdentity;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat x =0;
    CGFloat outValue = scrollView.contentOffset.x-self.frame.size.width*self.currentIndex;
    if (_lastValue == 0)
    {
        x = outValue;
    }else
    {
        x = outValue - _lastValue;
    }
    _lastValue = outValue;
    
    
    if(outValue>0)
    {
        OperAtionView.transform= CGAffineTransformRotate(OperAtionView.transform, -M_PI *x/self.frame.size.width*scwidth);
    }
    else if(outValue<0)
    {
        OperAtionView.transform= CGAffineTransformRotate(OperAtionView.transform, -M_PI *x/self.frame.size.width*scwidth);
        
    }
}



 

@end
