//
//  CustomCollectionViewCell.h
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel* label;
@property (nonatomic,strong) UIImageView* imageView;
-(void)loadImageFromWeb:(NSURL*)url;

@end

NS_ASSUME_NONNULL_END
