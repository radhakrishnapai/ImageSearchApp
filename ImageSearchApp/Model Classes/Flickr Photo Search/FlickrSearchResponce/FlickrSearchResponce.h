//
//  FlickrPhotos.h
//  ImageSearchApp
//
//  Created by Pai on 5/20/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhotos.h"

@interface FlickrSearchResponce : NSObject

@property (nonatomic, strong) FlickrPhotos * photos;
@property (nonatomic, strong) NSString * stat;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
