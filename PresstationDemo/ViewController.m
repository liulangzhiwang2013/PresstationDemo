//
//  ViewController.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/10.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "ViewController.h"
#import "PAlertVC.h"

#import "PCustomPresentVC.h"

#import "UIViewController+PPresentVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark ==================   PCustomPresentVC   ======================
//系统弹出动画
- (IBAction)ShowAlertViewAction:(UIButton *)sender
{
    PAlertVC *alertVc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PAlertVC class])];

    PCustomPresentVC *presentVC = [[PCustomPresentVC alloc]initWithPresentedViewController:alertVc presentingViewController:self];
    
    alertVc.transitioningDelegate = presentVC;
    alertVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical; //设置系统弹出动画的类型
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark ==================   PresentAnimationVC   ======================
//自定义-alert弹出
- (IBAction)alertAction:(UIButton *)sender
{
    PAlertVC *alertVc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PAlertVC class])];
    [self showPresentedController:alertVc WithType:PPresentTypeAlert presentSize:CGSizeMake(200, 100) shadowCanNotDismiss:NO completeHandle:^(BOOL presented) {
        
    }];
}

//自定义-sheet弹出
- (IBAction)sheetAction:(UIButton *)sender {
    PAlertVC *alertVc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PAlertVC class])];
    [self showPresentedController:alertVc WithType:PPresentTypeSheet presentSize:CGSizeMake(0, 200) shadowCanNotDismiss:NO completeHandle:^(BOOL presented) {
        
    }];
}

@end
