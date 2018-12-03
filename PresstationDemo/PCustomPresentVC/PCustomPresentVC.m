//
//  PCustomPresentVC.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/10.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "PCustomPresentVC.h"


@interface PCustomPresentVC()
/** 黑色半透明背景 */
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation PCustomPresentVC

#pragma mark - UIViewControllerTransitioningDelegate
//来告诉控制器，谁是动画主管(UIPresentationController)，因为此类继承了UIPresentationController，就返回了
- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return self;
}

#pragma mark - 重写UIPresentationController的方法
//重写构造方法
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        // 在自定义动画效果的情况下，苹果强烈建议设置为 UIModalPresentationCustom自定义
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

// 呈现过渡即将开始的时候被调用的
// 可以在此方法创建和设置自定义动画所需的view
- (void)presentationTransitionWillBegin
{
    // 背景遮罩
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.opaque = NO; //是否透明
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    [self.containerView addSubview:dimmingView]; // 添加到动画容器View中。
    
    // 获取presentingViewController 的转换协调器，应该动画期间的一个类？上下文？之类的，负责动画的一个东西
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    // 动画期间，背景View的动画方式
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.4f;
    } completion:NULL];
}

#pragma mark 点击了背景遮罩view
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
}

// 在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed
{

}

// 消失过渡即将开始的时候被调用的
- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

// 消失过渡完成之后调用，此时应该将视图移除
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES) {
        [self.dimmingView removeFromSuperview];
        self.dimmingView = nil;
    }
}

// 返回目标控制器Viewframe
- (CGRect)frameOfPresentedViewInContainerView
{
#warning  这里直接按照想要的大小写死，其实这样写不好
    CGFloat height = 300.f;
    
    CGRect containerViewBounds = self.containerView.bounds;
    containerViewBounds.origin.y = containerViewBounds.size.height - height;
    containerViewBounds.size.height = height;
    return containerViewBounds;
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}


- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
}


@end
