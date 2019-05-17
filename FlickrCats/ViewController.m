//
//  ViewController.m
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CustomCollectionViewCell.h"
#import "DetaiControllerView.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, DetailDelegate>

@property (nonatomic,strong) NSMutableArray<Photo*>* photosArray;
@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) Photo* photoObject;
@property (nonatomic,strong) NSString* dateuploaded;
@property (nonatomic,strong) NSString* originalFormat;
@property (nonatomic,strong) NSString* url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosArray = [[NSMutableArray alloc]init];
    self.photoObject = [[Photo alloc]init];
    
    self.dateuploaded = [[NSString alloc]init];
    self.originalFormat = [[NSString alloc]init];
    self.url = [[NSString alloc]init];
    
    [self setupCollectionView];
    [self networkToFlickr];
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"customCell"];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.translatesAutoresizingMaskIntoConstraints = 0;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: 0],
                                              [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant: 0],
                                              [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: 0],
                                                [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant: 0],
                                              ]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    
    Photo* photo = self.photosArray[indexPath.row];
    cell.label.text = photo.title;
    [cell loadImageFromWeb:photo.url];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (self.collectionView.frame.size.width / 2) - 40;
    return CGSizeMake(width,width);
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
        NSArray* photosArray = [photosDictionary objectForKey:@"photo"];
        
        for (NSDictionary* dict in photosArray) {
            Photo* photo = [Photo parseJson:dict];
            [self.photosArray addObject:photo];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }]; // 5
    
    [dataTask resume]; // 6
}

-(void)networkToFlickrGetMoreInfo:(Photo*)photo{
  
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.photoObject = self.photosArray[indexPath.row];
    NSString* string = [NSString stringWithFormat:@"%@", self.photoObject.idString];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&format=json&nojsoncallback=1&api_key=ee7022884e6a1d08111f705e8e1afba8&photo_id=%@",string]];
    // 1
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
        NSDictionary *photoDetailInfoArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary* photoDictionary = [photoDetailInfoArray objectForKey:@"photo"];
        
        NSString* dateString = [NSString stringWithFormat:@"%@", (NSString*)[photoDictionary objectForKey:@"dateuploaded"]];
        self.dateuploaded = dateString;
        
        NSString* formatString = [NSString stringWithFormat:@"%@", (NSString*)[photoDictionary objectForKey:@"originalformat"]];
        self.originalFormat = formatString;
        
        NSArray* urlArray = [photoDictionary[@"urls"]objectForKey:@"url"];
        NSDictionary* urlDictionary = urlArray[0];
        NSString* url = [urlDictionary objectForKey:@"_content"];
        self.url = url;
        
        NSLog(@"%@", url);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            DetaiControllerView* detailVC = [[DetaiControllerView alloc]init];
            detailVC.delegate = self;
            [self.navigationController pushViewController:detailVC animated:YES];
        }];
    }]; // 5
    
    [dataTask resume]; // 6
    
}

- (nonnull NSString *)setupDate {
    return self.dateuploaded;
}

- (nonnull NSString *)setupFormat {
    return self.originalFormat;
}

- (NSString *)setupUrl{
    return self.url;
}

@end
