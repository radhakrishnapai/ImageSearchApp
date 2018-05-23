//
//  CustomPushAnimation.h
//  ImageSearchApp
//
//  Created by Pai on 5/22/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomNavigationAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) CGRect endFrame;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, strong) UIView *animatingView;


- (id)initWithOriginFrame:(CGRect)originFrame endFrame:(CGRect)endFrame animatingView:(UIView *)animatingView duration:(NSTimeInterval)duration isPresenting:(BOOL)isPresenting;

@end
