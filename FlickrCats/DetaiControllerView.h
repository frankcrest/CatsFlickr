//
//  DetaiControllerView.h
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DetailDelegate <NSObject>

-(NSString*)setupDate;
-(NSString*)setupFormat;
-(NSString*)setupUrl;

@end
@interface DetaiControllerView : UIViewController

@property(weak,nonatomic) id<DetailDelegate>delegate;

@property (nonatomic,strong) NSString* dateUploaded;
@property (nonatomic, strong) NSString* originalFormat;


@end

NS_ASSUME_NONNULL_END
