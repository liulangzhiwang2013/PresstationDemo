//
//  PPresentationVC.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "PPresentationVC.h"

@interface PPresentationVC()
@end

@implementation PPresentationVC
//设置要显示的view的frame
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    
    if (self.type == PPresentTypeAlert) {
        self.presentedView.frame = CGRectMake(self.containerView.center.x-self.size.width*0.5, self.containerView.center.y-self.size.height*0.5, self.size.width, self.size.height);
    } else if (self.type==PPresentTypeSheet){
        self.presentedView.frame = CGRectMake(0, self.containerView.bounds.size.height-self.height, self.containerView.bounds.size.width, self.height);
    }
    //将蒙版插入最下面
    [self.containerView insertSubview:self.coverView atIndex:0];
}

- (CGRect)frameOfPresentedViewInContainerView
{
    if (self.type == PPresentTypeAlert) {
        self.presentedView.frame = CGRectMake(self.containerView.center.x-self.size.width*0.5, self.containerView.center.y-self.size.height*0.5, self.size.width, self.size.height);
    } else if (self.type==PPresentTypeSheet){
        self.presentedView.frame = CGRectMake(0, self.containerView.bounds.size.height-self.height, self.containerView.bounds.size.width, self.height);
    }
    return self.presentedView.frame;
}

- (BOOL)shouldPresentInFullscreen
{
    return NO;
}

- (BOOL)shouldRemovePresentersView
{
    return NO;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:self.containerView.bounds];
        _coverView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (void)dismissAction
{
    if (!self.shadowCanNotDismiss) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
}



@end
