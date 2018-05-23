//
//  FlickrPhotos.m
//  ImageSearchApp
//
//  Created by Pai on 5/20/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "FlickrPhotos.h"
#import "FlickrPhoto.h"

NSString *const kFlickrPhotosPage = @"page";
NSString *const kFlickrPhotosPages = @"pages";
NSString *const kFlickrPhotosPerPage = @"perpage";
NSString *const kFlickrPhotosTotal = @"total";
NSString *const kFlickrPhotosPhotosArray = @"photo";

@implementation FlickrPhotos

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if(![dictionary[kFlickrPhotosPage] isKindOfClass:[NSNull class]]){
        self.page = [dictionary[kFlickrPhotosPage] integerValue];
    }
    
    if(![dictionary[kFlickrPhotosPages] isKindOfClass:[NSNull class]]){
        self.pages = [dictionary[kFlickrPhotosPages] integerValue];
    }
    
    if(![dictionary[kFlickrPhotosPerPage] isKindOfClass:[NSNull class]]){
        self.perpage = [dictionary[kFlickrPhotosPerPage] integerValue];
    }
    
    if(dictionary[kFlickrPhotosPhotosArray] != nil && [dictionary[kFlickrPhotosPhotosArray] isKindOfClass:[NSArray class]]){
        NSArray * photoDictionaries = dictionary[kFlickrPhotosPhotosArray];
        NSMutableArray * photoItems = [NSMutableArray array];
        for(NSDictionary * photoDictionary in photoDictionaries){
            FlickrPhoto * photoItem = [[FlickrPhoto alloc] initWithDictionary:photoDictionary];
            [photoItems addObject:photoItem];
        }
        self.photosArray = photoItems;
    }
    if(![dictionary[kFlickrPhotosTotal] isKindOfClass:[NSNull class]]){
        self.total = [dictionary[kFlickrPhotosTotal] integerValue];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];

    dictionary[kFlickrPhotosPage] = @(self.page);
    dictionary[kFlickrPhotosPages] = @(self.pages);
    dictionary[kFlickrPhotosPerPage] = @(self.perpage);
    dictionary[kFlickrPhotosTotal] = @(self.total);
    if(self.photosArray != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(FlickrPhoto * photoElement in self.photosArray){
            [dictionaryElements addObject:[photoElement toDictionary]];
        }
        dictionary[kFlickrPhotosPhotosArray] = dictionaryElements;
    }
    return dictionary;
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:@(self.page) forKey:kFlickrPhotosPage];
    [aCoder encodeObject:@(self.pages) forKey:kFlickrPhotosPages];
    [aCoder encodeObject:@(self.perpage) forKey:kFlickrPhotosPerPage];
    [aCoder encodeObject:@(self.total) forKey:kFlickrPhotosTotal];
    
    if(self.photosArray != nil){
        [aCoder encodeObject:self.photosArray forKey:kFlickrPhotosPhotosArray];
    }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    self.page = [[aDecoder decodeObjectForKey:kFlickrPhotosPage] integerValue];
    self.pages = [[aDecoder decodeObjectForKey:kFlickrPhotosPages] integerValue];
    self.perpage = [[aDecoder decodeObjectForKey:kFlickrPhotosPerPage] integerValue];
    self.total = [[aDecoder decodeObjectForKey:kFlickrPhotosTotal] integerValue];
    self.photosArray = [aDecoder decodeObjectForKey:kFlickrPhotosPhotosArray];
    
    return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
    
    FlickrPhotos *copy = [FlickrPhotos new];
    copy.page = self.page;
    copy.pages = self.pages;
    copy.perpage = self.perpage;
    copy.total = self.total;
    copy.photosArray = [self.photosArray copy];
    
    return copy;
}

@end
