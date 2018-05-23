//
//  ImageDetailViewController.h
//  ImageSearchApp
//
//  Created by Pai on 5/22/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface ImageDetailViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) FlickrPhoto *flickrPhoto;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
