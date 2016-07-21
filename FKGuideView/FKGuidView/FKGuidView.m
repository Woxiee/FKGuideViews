//
//  FKGuidView.m
//  FKGuideView
//
//  Created by Faker on 16/7/21.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "FKGuidView.h"
#import "AppDelegate.h"
@interface FKGuidView() <UIScrollViewDelegate>

@property (weak,nonatomic) UIScrollView *scrollView;
@property (nonatomic,assign) BOOL finish;
@end


@implementation FKGuidView

+(instancetype)fkGuideViewImgaeArray:(NSArray *)imgArray finish:(FKGuideViewFinishBlock)finishBlock
{
    return [[self alloc] initGuideViewImageArray:imgArray finish:finishBlock];
}


- (instancetype)initGuideViewImageArray:(NSArray *)imgArray finish:(FKGuideViewFinishBlock)finishBlock
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect bFrame = [UIScreen mainScreen].bounds;
        bFrame.origin.x = [UIScreen mainScreen].bounds.size.width;
        self.frame = bFrame;
        AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
        
        [appdelegate.window addSubview:self];
        
        //添加下面的ScrollView显示
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor lightGrayColor];
        
        CGFloat width = self.scrollView.frame.size.width;
        CGFloat height = self.scrollView.frame.size.height;
        [self.scrollView setContentSize:CGSizeMake(width * imgArray.count, height)];
        
        //设置ScrollView的属性
        self.scrollView.pagingEnabled = YES;
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < imgArray.count; i ++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            NSString *iconName = imgArray[i];
            [imgView setImage:[UIImage imageNamed:iconName]];
            [self.scrollView addSubview:imgView];
            if (i == (imgArray.count - 1)) {
                [self addListener:imgView];
            }
        }
        self.finishBlock = finishBlock;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = [UIScreen mainScreen].bounds;
        }];
        

    }
    
    return self;
}


- (void)addListener:(UIImageView *)imgView
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [imgView setUserInteractionEnabled:YES];
    [imgView addGestureRecognizer:gesture];
}

- (void)click:(UITapGestureRecognizer *)sender
{
    UIImageView *view = (UIImageView *)sender.view;
    CGPoint point = [sender locationInView:view];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect tempRect = CGRectMake(width / 3.0 - 10, height * 70 / 100.0, width / 3.0 + 20, 100);
    if (CGRectContainsPoint(tempRect, point)) {
        [self finishView];
    }
}


- (void)finishView
{
    self.finish = YES;
    [UIView animateWithDuration:0.5 animations:^{
        //self.alpha = 0;
        self.frame = CGRectMake(-_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
    } completion:^(BOOL finished) {
        if (self.finishBlock) {
            self.finishBlock();
        }
        [self removeFromSuperview];
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > (scrollView.contentSize.width - scrollView.frame.size.width + 10)) {
        if (!self.finish)
        {
            [self finishView];
        }
    }
}

@end
