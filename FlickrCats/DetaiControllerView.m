//
//  DetaiControllerView.m
//  FlickrCats
//
//  Created by Frank Chen on 2019-05-16.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "DetaiControllerView.h"
#import <SafariServices/SafariServices.h>

@interface DetaiControllerView () <SFSafariViewControllerDelegate>

@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UILabel* descriptionLabel;
@property (nonatomic,strong) UIButton* button;

@end

@implementation DetaiControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

-(void)setupView{
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = 0;
    titleLabel.backgroundColor = [UIColor brownColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [self.delegate setupDate];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel* descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = 0;
    descriptionLabel.text = [self.delegate setupFormat];
    descriptionLabel.backgroundColor = [UIColor magentaColor];
    descriptionLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:descriptionLabel];
    self.descriptionLabel = descriptionLabel;
    
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectZero];
    button.translatesAutoresizingMaskIntoConstraints = 0;
    [button setTitle:@"PRESS FOR SAFARI" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    self.button = button;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [titleLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
                                              [titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                                              [titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                                              [descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:0],
                                              [descriptionLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                                              [descriptionLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                                              [titleLabel.heightAnchor constraintEqualToConstant:40],
                                              [descriptionLabel.heightAnchor constraintEqualToConstant:40],
                                              [button.topAnchor constraintEqualToAnchor:descriptionLabel.bottomAnchor constant:0],
                                              [button.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                                              [button.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                                              [button.heightAnchor constraintEqualToConstant:40],
                                              ]];
    
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)handleButton:(UIButton*)sender{
    
    NSURL* url = [[NSURL alloc]initWithString:[self.delegate setupUrl]];
    SFSafariViewController* svc  = [[SFSafariViewController alloc]initWithURL:url];
    svc.delegate = self;
    [self presentViewController:svc animated:true completion:nil];
}
@end
