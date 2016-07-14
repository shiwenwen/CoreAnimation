//
//  PopPercentDrivenInteractive.m
//  SWTrasitionAnimationDemo
//
//  Created by 石文文 on 16/7/14.
//  Copyright © 2016年 石文文. All rights reserved.
//

#import "PopPercentDrivenInteractive.h"

@interface PopPercentDrivenInteractive(){
    UIViewController *_viewController;
    
    BOOL _shouldCompleted;
}

@end

@implementation PopPercentDrivenInteractive
-(void)gestureViewController:(UIViewController *)viewController{
    _viewController = viewController;
    
    [_viewController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:) ]];
    
}
-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}
- (void)handleGesture:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:pan.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            
            _interacting = YES;
            
            [_viewController.navigationController popToRootViewControllerAnimated:YES];
        }
            
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat fraction = point.x/(pan.view.bounds.size.width);
            fraction = fminf(fmaxf(fraction,0.0), 1.0);
            
            _shouldCompleted = fraction > 0.4;
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
