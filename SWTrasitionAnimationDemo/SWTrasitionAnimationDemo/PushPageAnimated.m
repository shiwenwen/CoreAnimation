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
    
    return 0.4;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    CALayer *fromLayer = fromVC.view.layer;
    
    CALayer *toLayer = toVC.view.layer;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1/500.0;
    
    toLayer.sublayerTransform = transform;
    [self setAnrcPoint:CGPointMake(0, 0.5) layer:fromLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"rotation.y"];
    
    animation.fromValue = @(0);
                                   
    animation.toValue = @(M_PI_2);
    
    animation.duration = 0.4;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    
    [fromLayer addAnimation:animation forKey:@"pushRotation"];
    
    
    
}
-(void)animationDidStart:(CAAnimation *)anim{
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    
}
-(void)setAnrcPoint:(CGPoint )point layer:(CALayer *)layer{
    
    layer.frame = CGRectOffset(layer.frame, (point.x - layer.anchorPoint.x) * layer.frame.size.width, (point.y - layer.anchorPoint.y) * layer.frame.size.height);
    layer.anchorPoint = point;
    
    
    
}


@end
