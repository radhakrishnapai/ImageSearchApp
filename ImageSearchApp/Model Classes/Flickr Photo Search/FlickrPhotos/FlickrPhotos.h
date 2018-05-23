//
//  FlickrPhotos.h
//  ImageSearchApp
//
//  Created by Pai on 5/20/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhotos : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger perpage;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSArray *photosArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
