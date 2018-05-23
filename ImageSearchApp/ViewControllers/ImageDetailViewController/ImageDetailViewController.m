//
//  ImageDetailViewController.m
//  ImageSearchApp
//
//  Created by Pai on 5/22/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "ImageDownloadManager.h"

@interface ImageDetailViewController ()

@end

@implementation ImageDetailViewController

static NSString * const originalURL = @"https://farm%ld.staticflickr.com/%@/%@_%@_h.jpg";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self downloadDetailedImage];
    [self enableZooming];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.imageView.image = self.image;
}

- (void)enableZooming {
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.delegate = self;
}

- (void)downloadDetailedImage {
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:originalURL, (long)self.flickrPhoto.farm, self.flickrPhoto.server, self.flickrPhoto.idField, self.flickrPhoto.secret]];
    [[ImageDownloadManager sharedInstance] downloadImageForUrl:imageUrl completionBlock:^(NSURL *url, UIImage *image, NSError *error) {
        if (error == nil) {
            if (![url.absoluteString containsString:FLICKR_PHOTO_UNAVAILABLE_URL_STRING]) {
                self.image = image;
                self.imageView.image = image;
            }
        }
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.zoomScale = 1.0;
    }];
}

@end
