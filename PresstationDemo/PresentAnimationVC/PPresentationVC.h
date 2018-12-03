//
//  PPresentationVC.h
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPresentHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 presentedView ： 要显示的view
 containerView ： 目标控制器的容器视图,透明蒙版和presentedView的父视图
 **/

///弹出viewFrame管理类
@interface PPresentationVC : UIPresentationController


@property (nonatomic,strong) UIView *coverView;

@property (nonatomic,assign) PPresentType type;

@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat height; 

///点击阴影是否关闭页面
@property (nonatomic,assign) BOOL shadowCanNotDismiss;

@end

NS_ASSUME_NONNULL_END
