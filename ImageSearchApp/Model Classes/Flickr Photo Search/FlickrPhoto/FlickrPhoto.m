//
//	Photo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FlickrPhoto.h"

NSString *const kPhotoFarm = @"farm";
NSString *const kPhotoIdField = @"id";
NSString *const kPhotoIsfamily = @"isfamily";
NSString *const kPhotoIsfriend = @"isfriend";
NSString *const kPhotoIspublic = @"ispublic";
NSString *const kPhotoOwner = @"owner";
NSString *const kPhotoSecret = @"secret";
NSString *const kPhotoServer = @"server";
NSString *const kPhotoTitle = @"title";
NSString *const kPhotoPage = @"page";
NSString *const kPhotoPages = @"pages";
NSString *const kPhotoPerpage = @"perpage";
NSString *const kPhotoPhoto = @"photo";
NSString *const kPhotoTotal = @"total";

@interface FlickrPhoto ()
@end
@implementation FlickrPhoto

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if(![dictionary[kPhotoFarm] isKindOfClass:[NSNull class]]){
		self.farm = [dictionary[kPhotoFarm] integerValue];
	}

	if(![dictionary[kPhotoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kPhotoIdField];
	}	
	if(![dictionary[kPhotoIsfamily] isKindOfClass:[NSNull class]]){
		self.isfamily = [dictionary[kPhotoIsfamily] integerValue];
	}

	if(![dictionary[kPhotoIsfriend] isKindOfClass:[NSNull class]]){
		self.isfriend = [dictionary[kPhotoIsfriend] integerValue];
	}

	if(![dictionary[kPhotoIspublic] isKindOfClass:[NSNull class]]){
		self.ispublic = [dictionary[kPhotoIspublic] integerValue];
	}

	if(![dictionary[kPhotoOwner] isKindOfClass:[NSNull class]]){
		self.owner = dictionary[kPhotoOwner];
	}	
	if(![dictionary[kPhotoSecret] isKindOfClass:[NSNull class]]){
		self.secret = dictionary[kPhotoSecret];
	}	
	if(![dictionary[kPhotoServer] isKindOfClass:[NSNull class]]){
		self.server = dictionary[kPhotoServer];
	}	
	if(![dictionary[kPhotoTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kPhotoTitle];
	}	
	
	return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (NSDictionary *)toDictionary {
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPhotoFarm] = @(self.farm);
	if(self.idField != nil){
		dictionary[kPhotoIdField] = self.idField;
	}
	dictionary[kPhotoIsfamily] = @(self.isfamily);
	dictionary[kPhotoIsfriend] = @(self.isfriend);
	dictionary[kPhotoIspublic] = @(self.ispublic);
	if(self.owner != nil){
		dictionary[kPhotoOwner] = self.owner;
	}
	if(self.secret != nil){
		dictionary[kPhotoSecret] = self.secret;
	}
	if(self.server != nil){
		dictionary[kPhotoServer] = self.server;
	}
	if(self.title != nil){
		dictionary[kPhotoTitle] = self.title;
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
	[aCoder encodeObject:@(self.farm) forKey:kPhotoFarm];	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kPhotoIdField];
	}
	[aCoder encodeObject:@(self.isfamily) forKey:kPhotoIsfamily];	[aCoder encodeObject:@(self.isfriend) forKey:kPhotoIsfriend];	[aCoder encodeObject:@(self.ispublic) forKey:kPhotoIspublic];	if(self.owner != nil){
		[aCoder encodeObject:self.owner forKey:kPhotoOwner];
	}
	if(self.secret != nil){
		[aCoder encodeObject:self.secret forKey:kPhotoSecret];
	}
	if(self.server != nil){
		[aCoder encodeObject:self.server forKey:kPhotoServer];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kPhotoTitle];
	}
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	self.farm = [[aDecoder decodeObjectForKey:kPhotoFarm] integerValue];
	self.idField = [aDecoder decodeObjectForKey:kPhotoIdField];
	self.isfamily = [[aDecoder decodeObjectForKey:kPhotoIsfamily] integerValue];
	self.isfriend = [[aDecoder decodeObjectForKey:kPhotoIsfriend] integerValue];
	self.ispublic = [[aDecoder decodeObjectForKey:kPhotoIspublic] integerValue];
	self.owner = [aDecoder decodeObjectForKey:kPhotoOwner];
	self.secret = [aDecoder decodeObjectForKey:kPhotoSecret];
	self.server = [aDecoder decodeObjectForKey:kPhotoServer];
	self.title = [aDecoder decodeObjectForKey:kPhotoTitle];
	return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone {
	FlickrPhoto *copy = [FlickrPhoto new];

	copy.farm = self.farm;
	copy.idField = [self.idField copy];
	copy.isfamily = self.isfamily;
	copy.isfriend = self.isfriend;
	copy.ispublic = self.ispublic;
	copy.owner = [self.owner copy];
	copy.secret = [self.secret copy];
	copy.server = [self.server copy];
	copy.title = [self.title copy];

	return copy;
}

@end
