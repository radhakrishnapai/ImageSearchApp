//
//  LoadingIndicator.h
//  ImageSearchApp
//
//  Created by Pai on 5/22/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingIndicator : UIView

+ (void)startAnimatingInView:(UIView *)view;
+ (void)stopAnimating;

@end
