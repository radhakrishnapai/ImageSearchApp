//
//  CustomPushAnimation.m
//  ImageSearchApp
//
//  Created by Pai on 5/22/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "CustomNavigationAnimation.h"
#import "ImageDetailViewController.h"
#import <PBImageView/PBImageView-Swift.h>

@implementation CustomNavigationAnimation

- (id)initWithOriginFrame:(CGRect)originFrame endFrame:(CGRect)endFrame animatingView:(UIView *)animatingView duration:(NSTimeInterval)duration isPresenting:(BOOL)isPresenting {
    self = [super init];
    if( !self ) return nil;
    
    self.originFrame = originFrame;
    self.endFrame = endFrame;
    self.animatingView = animatingView;
    self.duration = duration;
    self.isPresenting = isPresenting;
    
    return self;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    PBImageView *snapshot = [[PBImageView alloc] initWithImage:((UIImageView *)_animatingView).image];
    
    snapshot.backgroundColor = [UIColor blackColor];
    snapshot.clipsToBounds = YES;
    [containerView addSubview:toViewController.view];
    
    snapshot.frame = _originFrame;
    [containerView addSubview:snapshot];
    if (_isPresenting) {
        toViewController.view.alpha = 0;
        snapshot.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        snapshot.contentMode = UIViewContentModeScaleAspectFit;
        [containerView bringSubviewToFront:fromViewController.view];
        [containerView bringSubviewToFront:snapshot];
        fromViewController.view.alpha = 0;
    }
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapshot.frame = _endFrame;
        if (_isPresenting) {
            snapshot.contentMode = UIViewContentModeScaleAspectFit;
        } else {
            snapshot.contentMode = UIViewContentModeScaleAspectFill;
            fromViewController.view.alpha = 0;
        }
    } completion:^(BOOL finished) {
        [snapshot removeFromSuperview];
        if (_isPresenting) {
            toViewController.view.alpha = 1;
        }
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
