//
//  PPresentAnimation.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "PPresentAnimation.h"
#import "PPresentationVC.h"

@interface PPresentAnimation()

{
    BOOL isPrestend; //是否已弹出
}
@property (nonatomic,assign) CGSize alertSize; //弹出的尺寸
@property (nonatomic,assign) CGFloat sheetHeight; //底部弹出时的高度
@property (nonatomic,assign) PPresentType presetType; //弹出类型
@property (nonatomic,assign) BOOL shadowCanNotDismiss; //点击背景是否dismiss

@property (nonatomic,  copy) PCompleteHandle handle; //弹出后block

@property (nonatomic,strong) PPresentationVC *presentationVC; //管理要显示视图的VC
@end

@implementation PPresentAnimation

//构造方法
+ (instancetype)initWithType:(PPresentType)type completeHandle:(PCompleteHandle)handle shadowCanNotDismiss:(BOOL)shadowCanNotDismiss
{
    PPresentAnimation *animation = [PPresentAnimation new];
    animation.presetType = type;
    animation.handle = handle;
    animation.shadowCanNotDismiss = shadowCanNotDismiss;
    
    return animation;
}

- (void)setSize:(CGSize)size
{
    if (self.presetType==PPresentTypeAlert) {
        self.alertSize = size;
    } else if (self.presetType==PPresentTypeSheet){
        self.sheetHeight = size.height;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    PPresentationVC *myPresentationVC = [[PPresentationVC alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    myPresentationVC.type = self.presetType;
    myPresentationVC.size = self.alertSize;
    myPresentationVC.height = self.sheetHeight;
    myPresentationVC.shadowCanNotDismiss = self.shadowCanNotDismiss;
    
    self.presentationVC = myPresentationVC;
    return myPresentationVC;
}

#pragma mark - UIViewControllerAnimatedTransitioning
// 返回的对象控制Presented时的动画 (开始动画的具体细节负责类)
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    isPrestend = YES;
    !self.handle?:self.handle(isPrestend);
    return self;
}

// 由返回的控制器控制dismissed时的动画 (结束动画的具体细节负责类)
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    isPrestend = NO;
    !self.handle? :self.handle(isPrestend);
    return self;
}

//动画时长
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
    return kAnimationDuration;
}


//进行动画
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    isPrestend ? [self animationForPresentedView:transitionContext]:[self animationForDismissedView:transitionContext];
}

#pragma mark - 实现动画的方法 ----
// 弹出
- (void)animationForPresentedView:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    //获得要显示的view
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [self.presentationVC.containerView addSubview:presentedView];
    self.presentationVC.coverView.alpha = 0;
    
    //设置阴影
    transitionContext.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    transitionContext.containerView.layer.shadowOffset = CGSizeMake(0, 5);
    transitionContext.containerView.layer.shadowOpacity = 0.5f;
    transitionContext.containerView.layer.shadowRadius = 10.0f;
    
    WeakSelf(weakSelf)
    if (self.presetType == PPresentTypeAlert) {
        presentedView.alpha = 0.0f;
        presentedView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        // 动画弹出
        [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.presentationVC.coverView.alpha = 1.0f;
            presentedView.alpha = 1.0f;
            presentedView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else if (self.presetType==PPresentTypeSheet){
        presentedView.transform = CGAffineTransformMakeTranslation(0, weakSelf.sheetHeight);
        [UIView animateWithDuration:kAnimationDuration animations:^{
            weakSelf.presentationVC.coverView.alpha = 1.0f;
            presentedView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    
    
}

// 消失
- (void)animationForDismissedView:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    WeakSelf(weakSelf)
    if (self.presetType == PPresentTypeAlert) {
        // 消失
        [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.presentationVC.coverView.alpha = 0.0f;
            presentedView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [presentedView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }else if (self.presetType==PPresentTypeSheet){
        [UIView animateWithDuration:kAnimationDuration animations:^{
            weakSelf.presentationVC.coverView.alpha = 0.0f;
            presentedView.transform = CGAffineTransformMakeTranslation(0, weakSelf.sheetHeight);
        } completion:^(BOOL finished) {
            [presentedView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}


@end
