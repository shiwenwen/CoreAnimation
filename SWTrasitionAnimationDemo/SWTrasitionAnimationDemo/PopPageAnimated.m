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
    
    
    
    //阴影
    CAGradientLayer *fromArad = [CAGradientLayer new];
    fromArad.frame = fromVC.view.bounds;
    fromArad.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                        (__bridge id)[UIColor blackColor].CGColor];
    fromArad.startPoint = CGPointMake(0.0, 0.5);
    fromArad.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    [fromShadow.layer addSublayer:fromArad];
    fromShadow.alpha = 0.0;
    [fromVC.view addSubview:fromShadow];
    
    CAGradientLayer *toArad = [CAGradientLayer new];
    toArad.frame = toVC.view.bounds;
    toArad.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                      (__bridge id)[UIColor blackColor].CGColor];
    toArad.startPoint = CGPointMake(0.0, 0.5);
    toArad.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *toShadow = [[UIView alloc]initWithFrame:toVC.view.bounds];
    [toShadow.layer addSublayer:toArad];
    toShadow.alpha = 0.0;
    [toVC.view addSubview:toShadow];
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1/500.0;
    toVC.view.alpha = 0.8;
    view.layer.sublayerTransform = transform;
    toVC.view.layer.transform = CATransform3DMakeRotation( -M_PI_2, 0, 1, 0);
    [UIView animateWithDuration:.9 animations:^{
        toView.layer.transform = CATransform3DIdentity;
        toVC.view.alpha = 1;
        toShadow.alpha = 0;
        fromShadow.alpha = 0.9;
    } completion:^(BOOL finished) {
        [fromShadow removeFromSuperview];
        [toShadow removeFromSuperview];
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
    
}

-(void)setAnrcPoint:(CGPoint )point view:(UIView *)view{
    
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
    
    
    
}
@end
