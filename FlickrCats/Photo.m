//
//  Photo.m
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithServer:(NSString*)server withFarm:(NSString*)farm withId:(NSString*)idString withSecret:(NSString*)secret withTitle:(NSString*)title;
{
    self = [super init];
    if (self) {
        _server = server;
        _farm = farm;
        _idString = idString;
        _secret = secret;
        _title = title ? title : @"no title";
        _url = [[NSURL alloc]initWithString: [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", _farm,_server,_idString,_secret]];
    }
    return self;
}

+(instancetype)parseJson:(NSDictionary*)json{
    return [[Photo alloc]initWithServer:json[@"server"] withFarm:json[@"farm"] withId:json[@"id"] withSecret:json[@"secret"] withTitle:json[@"title"]];
}



@end
