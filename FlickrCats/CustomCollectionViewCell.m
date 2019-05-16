//
//  CustomCollectionViewCell.m
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.translatesAutoresizingMaskIntoConstraints = 0;
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = 0;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
                                                  [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
                                                   [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
                                                  [self.imageView.bottomAnchor constraintEqualToAnchor:self.label.topAnchor constant:0],
                                                  [self.label.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:0],
                                                  [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0],
                                                  [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0],
                                                  [self.label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0],
                                                  [self.label.heightAnchor constraintEqualToConstant:40],
                                                  ]];
    }
    return self;
}

-(void)loadImageFromWeb:(NSURL*)url{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData* data = [NSData dataWithContentsOfURL:location];
        UIImage* image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];
        
    }]; // 4
    
    [downloadTask resume]; // 5
}

@end
