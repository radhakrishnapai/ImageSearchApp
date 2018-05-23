//
//	FlickrSearchResponce.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "FlickrSearchResponce.h"

NSString *const kFlickrSearchResponcePhotos = @"photos";
NSString *const kFlickrSearchResponceStat = @"stat";

@interface FlickrSearchResponce ()
@end
@implementation FlickrSearchResponce

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[kFlickrSearchResponcePhotos] isKindOfClass:[NSNull class]]){
		self.photos = [[FlickrPhotos alloc] initWithDictionary:dictionary[kFlickrSearchResponcePhotos]];
	}

	if(![dictionary[kFlickrSearchResponceStat] isKindOfClass:[NSNull class]]){
		self.stat = dictionary[kFlickrSearchResponceStat];
	}	
	return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.photos != nil){
		dictionary[kFlickrSearchResponcePhotos] = [self.photos toDictionary];
	}
	if(self.stat != nil){
		dictionary[kFlickrSearchResponceStat] = self.stat;
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
	if(self.photos != nil){
		[aCoder encodeObject:self.photos forKey:kFlickrSearchResponcePhotos];
	}
	if(self.stat != nil){
		[aCoder encodeObject:self.stat forKey:kFlickrSearchResponceStat];
	}
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	self.photos = [aDecoder decodeObjectForKey:kFlickrSearchResponcePhotos];
	self.stat = [aDecoder decodeObjectForKey:kFlickrSearchResponceStat];
	return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
	FlickrSearchResponce *copy = [FlickrSearchResponce new];

	copy.photos = [self.photos copy];
	copy.stat = [self.stat copy];

	return copy;
}

@end
