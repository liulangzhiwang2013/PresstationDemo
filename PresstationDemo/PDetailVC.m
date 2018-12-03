//
//  PDetailVC.m
//  PresstationDemo
//
//  Created by pxx on 2018/10/15.
//  Copyright © 2018年 pxx. All rights reserved.
//

#import "PDetailVC.h"

@interface PDetailVC ()

@end

@implementation PDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)dismissAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)dismisssAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
