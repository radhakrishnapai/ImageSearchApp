//
//  BaseWebService.m
//  ImageSearchApp
//
//  Created by Pai on 5/19/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "BaseWebService.h"

@implementation BaseWebService

+ (void)requestWithParameters:(NSMutableDictionary *)parameters successBlock:(baseWebServiceSuccessBlock)successBlock andFailureBlock:(baseWebServiceFailureBlock)failureBlock {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    parameters[API_KEY_PARAM] = FLICKR_API_KEY;
    parameters[FORMAT_PARAM] = @"json";
    parameters[@"nojsoncallback"] = @1;
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:FLICKR_BASE_URL parameters:parameters error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            successBlock(response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
