//
//  UIViewController+PPresentVC.h
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPresentHeader.h"
#import "PPresentAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PPresentVC)

///动画管理类
@property (nonatomic,strong) PPresentAnimation  *animation;

/**
 prestedVC ： 要显示的控制器
 type ： 显示类型，alert在屏幕中间显示，sheet在底部显示，
 size ： 底部显示时宽度固定是屏幕宽度
 shadowCanNotDismiss : 点击阴影是否dismiss当前页面
 handle ： 动画结束后的回调
 **/
- (void)showPresentedController:(UIViewController*)prestedVC WithType:(PPresentType)type presentSize:(CGSize)size shadowCanNotDismiss:(BOOL)shadowCanNotDismiss completeHandle:(PCompleteHandle)handle;


@end

NS_ASSUME_NONNULL_END
