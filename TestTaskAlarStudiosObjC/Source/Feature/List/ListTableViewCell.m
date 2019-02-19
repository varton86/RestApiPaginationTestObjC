//
//  ListTableViewCell.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "ListTableViewCell.h"

@interface ListTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation ListTableViewCell
{
    NSURLSessionDataTask *dataTask;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.picture.contentMode = UIViewContentModeScaleAspectFill;
    self.picture.layer.cornerRadius = 6.0;
    self.picture.clipsToBounds = YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    if (nil != dataTask)
    {
        [dataTask cancel];
        dataTask = nil;
    }
    [self configureWithAirport:nil];
}

- (void)configureWithAirport:(Airport *)airport
{
    if (nil == airport)
    {
        self.nameLabel.alpha = 0;
        self.picture.alpha = 0;

        [self.indicatorView startAnimating];
    } else {
        self.nameLabel.text = airport.name;
        self.nameLabel.alpha = 1;
        self.picture.image = [UIImage imageNamed:@"Placeholder"];
        dataTask = [self.picture loadImageFromURL:airport.imageURL];
        self.picture.alpha = 1;

        [self.indicatorView stopAnimating];
    }
}

@end
