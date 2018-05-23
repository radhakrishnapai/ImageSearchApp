//
//  ImageDownloadManager.m
//  ImageSearchApp
//
//  Created by Pai on 5/21/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "ImageDownloadManager.h"

@implementation ImageDownloadManager

+ (ImageDownloadManager *)sharedInstance {
    
    static ImageDownloadManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageDownloadManager alloc] init];
        NSURLSessionConfiguration *sessionConfigurtion = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedInstance.session = [NSURLSession sessionWithConfiguration:sessionConfigurtion delegate:sharedInstance delegateQueue:[NSOperationQueue mainQueue]];
        sharedInstance.cache = [[NSCache alloc] init];
        sharedInstance.pendingUrls = [[NSMutableArray alloc] init];
    });
    
    return sharedInstance;
}

- (void)downloadImageForUrl:(NSURL *)url completionBlock:(DownloadImageCompletionBlock)completionBlock {
    UIImage *cachedImage = [self.cache objectForKey:url.absoluteString];
    if (cachedImage) {
        completionBlock(url, cachedImage, nil);
    } else if ([_pendingUrls containsObject:url.absoluteString]) {
        [self.session getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
            for (NSURLSessionDownloadTask *downloadTask in downloadTasks) {
                if ([downloadTask.originalRequest.URL.absoluteString isEqualToString:url.absoluteString]) {
                    downloadTask.priority = 1.0;
                    [downloadTask resume];
                }
            }
        }];
    } else {
        NSURLSessionDownloadTask *downloadTask = [[NSURLSessionDownloadTask alloc] init];
        downloadTask = [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
            [self.cache setObject:image forKey:response.URL.absoluteString];
            [[ImageDownloadManager sharedInstance].pendingUrls removeObject:response.URL.absoluteString];
            completionBlock(response.URL, image, error);
        }];
        [downloadTask resume];
        [_pendingUrls addObject:url.absoluteString];
    }
}

@end
