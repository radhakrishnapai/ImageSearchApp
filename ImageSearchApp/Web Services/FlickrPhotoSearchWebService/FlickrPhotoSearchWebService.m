//
//  FlickrPhotoSearchWebService.m
//  ImageSearchApp
//
//  Created by Pai on 5/19/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "FlickrPhotoSearchWebService.h"

#define FLICKR_SEARCH_API @"flickr.photos.search"
#define FlICKR_GET_RECENT_API @"flickr.photos.getRecent"
#define PER_PAGE @"per_page"

@implementation FlickrPhotoSearchWebService

+ (void)getFlickrPhotoSearchWithSearchText:(NSString *)searchtext page:(NSInteger)page success:(baseWebServiceSuccessBlock)successBlock failure:(baseWebServiceFailureBlock)failureBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    parameters[PAGE_PARAM] = @(page);
    if (![searchtext isEqualToString:@""] && searchtext != nil) {
        parameters[@"text"] = searchtext;
        parameters[METHOD_PARAM] = FLICKR_SEARCH_API;
    } else {
        parameters[METHOD_PARAM] = FlICKR_GET_RECENT_API;
    }
    parameters[PER_PAGE] = @30;

    [FlickrPhotoSearchWebService getFlickrPhotoSearchWithParams:parameters success:successBlock failure:failureBlock];
}

+ (void)getFlickrPhotoSearchWithParams:(NSMutableDictionary *)params success:(baseWebServiceSuccessBlock)successBlock failure:(baseWebServiceFailureBlock)failureBlock {
    [BaseWebService requestWithParameters:params successBlock:successBlock andFailureBlock:failureBlock];
}

@end
