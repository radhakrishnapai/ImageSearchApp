//
//  FlickrPhotos.h
//  ImageSearchApp
//
//  Created by Pai on 5/20/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhoto : NSObject

@property (nonatomic, assign) NSInteger farm;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger isfamily;
@property (nonatomic, assign) NSInteger isfriend;
@property (nonatomic, assign) NSInteger ispublic;
@property (nonatomic, strong) NSString * owner;
@property (nonatomic, strong) NSString * secret;
@property (nonatomic, strong) NSString * server;
@property (nonatomic, strong) NSString * title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
