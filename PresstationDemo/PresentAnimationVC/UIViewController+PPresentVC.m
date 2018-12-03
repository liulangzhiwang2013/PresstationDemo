//
//  UIViewController+PPresentVC.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "UIViewController+PPresentVC.h"
#import <objc/runtime.h>



static const char animationKey;
@implementation UIViewController (PPresentVC)

#pragma mark  - 使用关联方法给分类添加属性
- (PPresentAnimation *)animation
{
    return objc_getAssociatedObject(self, &animationKey);
}

- (void)setAnimation:(PPresentAnimation *)animation
{
    objc_setAssociatedObject(self, &animationKey, animation, OBJC_ASSOCIATION_RETAIN) ;
}


- (void)showPresentedController:(UIViewController*)prestedVC WithType:(PPresentType)type presentSize:(CGSize)size shadowCanNotDismiss:(BOOL)shadowCanNotDismiss completeHandle:(nonnull PCompleteHandle)handle
{
    
    self.animation = [PPresentAnimation initWithType:type completeHandle:handle shadowCanNotDismiss:shadowCanNotDismiss];
    [self.animation setSize:size];
    
    prestedVC.modalPresentationStyle = UIModalPresentationCustom; //设置目标vc的动画为自定义
    prestedVC.transitioningDelegate = self.animation; //设置动画管理代理类
    
    [self presentViewController:prestedVC animated:YES completion:nil];
}

@end
