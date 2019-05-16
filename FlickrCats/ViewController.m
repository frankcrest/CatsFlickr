//
//  ViewController.m
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self networkToFlickr];
     }

-(void)networkToFlickr{
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=ee7022884e6a1d08111f705e8e1afba8&tags=cat"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *flickrDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
    
        NSDictionary* photosDictionary = [flickrDictionary objectForKey:@"photos"];
        NSArray* photoDictionary = [photosDictionary objectForKey:@"photo"];
        for (NSDictionary* dictionary in photoDictionary) {
            <#statements#>
        }
        
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
        }];
    }]; // 5
    
    [dataTask resume]; // 6
    
    
}


@end
