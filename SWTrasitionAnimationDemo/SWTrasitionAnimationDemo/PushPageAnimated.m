//
//  PushPageAnimated.m
//  SWTrasitionAnimationDemo
//
//  Created by 石文文 on 16/7/14.
//  Copyright © 2016年 石文文. All rights reserved.
//

#import "PushPageAnimated.h"

@implementation PushPageAnimated

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return .8;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
    UIView *view = [transitionContext containerView];
    [view addSubview:toVC.view];
    [view addSubview:fromVC.view];
    
    CALayer *fromLayer = fromVC.view.layer;
    
//    CALayer *toLayer = toVC.view.layer;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1/500.0;
    
    view.layer.sublayerTransform = transform;
    [self setAnrcPoint:CGPointMake(0, 0.5) view:fromVC.view];
    
    //阴影
    CAGradientLayer *fromArad = [CAGradientLayer new];
    fromArad.frame = fromLayer.bounds;
    fromArad.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                        (__bridge id)[UIColor blackColor].CGColor];
    fromArad.startPoint = CGPointMake(0.0, 0.5);
    fromArad.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
    [fromShadow.layer addSublayer:fromArad];
    fromShadow.alpha = 0;
    [fromVC.view addSubview:fromShadow];
    
    CAGradientLayer *toArad = [CAGradientLayer new];
    toArad.frame = toVC.view.bounds;
    toArad.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                        (__bridge id)[UIColor blackColor].CGColor];
    toArad.startPoint = CGPointMake(0.0, 0.5);
    toArad.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *toShadow = [[UIView alloc]initWithFrame:toVC.view.bounds];
    [toShadow.layer addSublayer:toArad];
    toShadow.alpha = 0.9;
    [toVC.view addSubview:toShadow];
    
    
    
    
    [UIView animateWithDuration:.8 animations:^{
     fromLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        fromShadow.alpha = 0.9;
        toShadow.alpha = 0;
    } completion:^(BOOL finished) {
        [fromShadow removeFromSuperview];
        [toShadow removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    

    
}

-(void)setAnrcPoint:(CGPoint )point view:(UIView *)view{
    
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
    
    
    
}


@end
