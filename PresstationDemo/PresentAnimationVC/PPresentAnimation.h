//
//  PPresentAnimation.h
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPresentHeader.h"

///弹出动画管理类
@interface PPresentAnimation : NSObject<UIViewControllerTransitioningDelegate , UIViewControllerAnimatedTransitioning>

//初始化构造方法
+ (instancetype)initWithType:(PPresentType)type
              completeHandle:(PCompleteHandle)handle
         shadowCanNotDismiss:(BOOL)shadowCanNotDismiss;

- (void)setSize:(CGSize)size;

@end


