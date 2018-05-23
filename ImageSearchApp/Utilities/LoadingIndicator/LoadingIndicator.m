//
//  LoadingIndicator.m
//  ImageSearchApp
//
//  Created by Pai on 5/22/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "LoadingIndicator.h"

@implementation LoadingIndicator

+ (LoadingIndicator *)sharedInstance {
    
    static LoadingIndicator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[NSBundle mainBundle] loadNibNamed:@"LoadingIndicator" owner:self options:nil] firstObject];
    });
    
    return sharedInstance;
}


+ (void)startAnimatingInView:(UIView *)view {
    UIView *indicatorView = [LoadingIndicator sharedInstance];
    [view addSubview:indicatorView];
    [view bringSubviewToFront:indicatorView];
    [indicatorView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [indicatorView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    [indicatorView.leftAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
    [indicatorView.rightAnchor constraintEqualToAnchor:view.rightAnchor].active = YES;
    indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [view layoutIfNeeded];
}

+ (void)stopAnimating {
    [[LoadingIndicator sharedInstance] removeFromSuperview];
}

@end
