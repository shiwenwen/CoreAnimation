//
//  FromViewController.m
//  SWTrasitionAnimationDemo
//
//  Created by 石文文 on 16/7/14.
//  Copyright © 2016年 石文文. All rights reserved.
//

#import "FromViewController.h"
#import "ToViewController.h"
#import "PresentAnimated.h"
#import "DisMissAnimated.h"
#import "PercentDrivenlnteractive.h"
@interface FromViewController ()<UIViewControllerTransitioningDelegate>{
    
    PercentDrivenlnteractive *_per;
}

@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"From";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:button];

    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    

}
- (void)present{
    
    ToViewController *to = [ToViewController new];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:to];
    navi.transitioningDelegate = self;
    _per = [PercentDrivenlnteractive new];
    [_per gestureViewController:to];
    
    
    [self presentViewController:navi animated:YES completion:NULL];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
 
    return [PresentAnimated new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [DisMissAnimated new];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
 
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    
    return _per.interacting ? _per:nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
