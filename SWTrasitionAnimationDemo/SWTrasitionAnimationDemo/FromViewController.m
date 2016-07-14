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
#import "PushViewController.h"
#import "PushPageAnimated.h"
#import "PopPageAnimated.h"
#import "PopPercentDrivenInteractive.h"
@interface FromViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>{
    
    PercentDrivenlnteractive *_per;
    PopPercentDrivenInteractive *_pop;
}

@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"From";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:button];

//    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.delegate = self;
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"1"].CGImage);
   
    
    
}

-(void)push{
    _pop = [PopPercentDrivenInteractive new];
    PushViewController *push = [PushViewController new];
    [_pop gestureViewController:push];
    [self.navigationController pushViewController:push animated:YES];
    
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



- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        return [PushPageAnimated new];
    }
    
    return [PopPageAnimated new];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    
    
    return _pop.interacting? _pop:nil;
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
