//
//  PAlertVC.h
//  PresstationDemo
//
//  Created by pxx on 2018/10/10.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PAlertVC : UIViewController

typedef void(^ReturnActionBlock)(void);

@property (nonatomic,  copy) ReturnActionBlock myblock;
 
@end

NS_ASSUME_NONNULL_END
