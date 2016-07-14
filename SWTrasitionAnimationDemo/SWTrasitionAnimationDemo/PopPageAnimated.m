//
//  PopPageAnimated.m
//  SWTrasitionAnimationDemo
//
//  Created by 石文文 on 16/7/14.
//  Copyright © 2016年 石文文. All rights reserved.
//

#import "PopPageAnimated.h"

@implementation PopPageAnimated

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return .8;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //
    UIView *view = [transitionContext containerView];
    UIView *toView = toVC.view;
    [view addSubview:fromVC.view];
    [view addSubview:toView];
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1/500.0;
    toVC.view.alpha = 0.8;
    view.layer.sublayerTransform = transform;
    toVC.view.layer.transform = CATransform3DMakeRotation( -M_PI_2, 0, 1, 0);
    [UIView animateWithDuration:.9 animations:^{
        toView.layer.transform = CATransform3DIdentity;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    
}

-(void)setAnrcPoint:(CGPoint )point view:(UIView *)view{
    
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
    
    
    
}
@end
