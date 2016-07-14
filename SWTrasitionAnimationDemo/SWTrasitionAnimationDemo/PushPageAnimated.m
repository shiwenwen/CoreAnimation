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
    
    
    
    [UIView animateWithDuration:.8 animations:^{
     fromLayer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        fromVC.view.alpha = 0.9;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
    

    
}

-(void)setAnrcPoint:(CGPoint )point view:(UIView *)view{
    
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
    
    
    
}


@end
