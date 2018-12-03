//
//  PAlertVC.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/10.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "PAlertVC.h"
#import "PDetailVC.h"
#import "UIViewController+PPresentVC.h"

@interface PAlertVC ()

@end

@implementation PAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (IBAction)goTodetail:(UIButton *)sender
{
    PDetailVC *detail = [PDetailVC new];
    [self showPresentedController:detail WithType:PPresentTypeAlert presentSize:[UIScreen mainScreen].bounds.size shadowCanNotDismiss:NO completeHandle:^(BOOL presented) {
        
    }];
    
}


@end
