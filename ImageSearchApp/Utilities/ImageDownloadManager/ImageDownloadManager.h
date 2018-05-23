//
//  ImageDownloadManager.h
//  ImageSearchApp
//
//  Created by Pai on 5/21/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^DownloadImageCompletionBlock)(NSURL *url, UIImage *image, NSError *error);

@interface ImageDownloadManager : NSObject<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) NSMutableArray *pendingUrls;

+ (ImageDownloadManager *)sharedInstance;
- (void)downloadImageForUrl:(NSURL *)url completionBlock:(DownloadImageCompletionBlock)completionBlock;

@end
