//
//  PPresentAnimation.h
//  PresstationDemo
//
//  Created by pxx on 2018/10/11.
//  Copyright © 2018年 pxx. All rights reserved.
//

#ifndef PPresentHeader_h
#define PPresentHeader_h



#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

///弹出动画结束后回调
typedef void(^PCompleteHandle)(BOOL presented);

///弹出类型
typedef NS_ENUM(NSUInteger, PPresentType) {
    ///中间弹出
    PPresentTypeAlert,
    ///底部弹出
    PPresentTypeSheet,
};

#define kAnimationDuration 0.3

#endif /* PPresentHeader_h */
