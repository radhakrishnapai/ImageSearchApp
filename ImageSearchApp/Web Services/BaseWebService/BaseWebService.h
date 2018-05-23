//
//  BaseWebService.h
//  ImageSearchApp
//
//  Created by Pai on 5/19/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^baseWebServiceSuccessBlock)(NSURLResponse *response, id responseObject);
typedef void (^baseWebServiceFailureBlock)(NSError *error);

@interface BaseWebService : NSObject

+ (void)requestWithParameters:(NSMutableDictionary *)parameters successBlock:(baseWebServiceSuccessBlock)successBlock andFailureBlock:(baseWebServiceFailureBlock)failureBlock;

@end
