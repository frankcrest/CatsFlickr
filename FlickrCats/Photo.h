//
//  Photo.h
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject

@property (nonatomic,strong) NSString* server;
@property (nonatomic,strong) NSString* farm;
@property (nonatomic,strong) NSString* idString;
@property (nonatomic,strong) NSString* secret;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSURL* url;

-(instancetype)initWithServer:(NSString*)server withFarm:(NSString*)farm withId:(NSString*)idString withSecret:(NSString*)secret withTitle:(NSString*)title;

+(instancetype)parseJson:(NSDictionary*)json;

@end

NS_ASSUME_NONNULL_END
