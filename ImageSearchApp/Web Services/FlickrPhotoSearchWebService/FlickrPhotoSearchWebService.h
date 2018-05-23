//
//  FlickrPhotoSearchWebService.h
//  ImageSearchApp
//
//  Created by Pai on 5/19/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "BaseWebService.h"

@interface FlickrPhotoSearchWebService : BaseWebService

+ (void)getFlickrPhotoSearchWithSearchText:(NSString *)searchtext page:(NSInteger)page success:(baseWebServiceSuccessBlock)successBlock failure:(baseWebServiceFailureBlock)failureBlock;

@end
