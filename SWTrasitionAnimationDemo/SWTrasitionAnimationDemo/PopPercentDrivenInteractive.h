//
//  PopPercentDrivenInteractive.h
//  SWTrasitionAnimationDemo
//
//  Created by 石文文 on 16/7/14.
//  Copyright © 2016年 石文文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopPercentDrivenInteractive : UIPercentDrivenInteractiveTransition
@property(nonatomic,assign)BOOL interacting;
-(void)gestureViewController:(UIViewController *)viewController;
@end
