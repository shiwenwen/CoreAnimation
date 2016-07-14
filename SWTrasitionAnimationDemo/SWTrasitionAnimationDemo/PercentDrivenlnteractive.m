//
//  PercentDrivenlnteractive.m
//  SWTrasitionAnimationDemo
//
//  Created by 石文文 on 16/7/14.
//  Copyright © 2016年 石文文. All rights reserved.
//

#import "PercentDrivenlnteractive.h"

@implementation PercentDrivenlnteractive{
    
    UIViewController *_viewController;
    
    BOOL _shouldCompleted;
}


-(void)gestureViewController:(UIViewController *)viewController{
    _viewController = viewController;
    
    [_viewController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:) ]];
    
}
-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}
- (void)handleGesture:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:[UIApplication sharedApplication].keyWindow];
    NSLog(@"%@",NSStringFromCGPoint(point));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            
            _interacting = YES;
            
            [_viewController dismissViewControllerAnimated:YES completion:NULL];
        }

            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat fraction = point.y/500;
            fraction = fminf(fmaxf(fraction,0.0), 1.0);
            
            _shouldCompleted = fraction > 0.5;
            NSLog(@"%f",fraction);
            [self updateInteractiveTransition:fraction];
        }

            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            _interacting = NO;
            
            if (_shouldCompleted) {
                
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            
        }
            
            break;
        default:
            break;
    }
    
}


@end
