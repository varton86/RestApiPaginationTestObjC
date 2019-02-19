//
//  DataService.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "DataService.h"

@implementation DataService
{
    NSString *code;
    BOOL isFetchInProgress;
    
    NSMutableArray<Airport *> *airports;
    NSInteger total;
    NSInteger currentPage;
}

- (instancetype)initWithCode:(NSString *)aCode
{
    if ((self = [super init]))
    {
        code = aCode;
        isFetchInProgress = NO;
        total = NUMBER_OF_ROWS_AT_PAGE;
        currentPage = 1;
        airports = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)totalCount
{
    return total;
}

- (NSInteger)currentCount
{
    return airports.count;
}

- (Airport *)airportAtIndex:(NSInteger)index
{
    return [airports objectAtIndex:index] ;
}

- (void)fetchData
{
    if (YES == isFetchInProgress)
    {
        return;
    }
    isFetchInProgress = YES;
    
    NSString *dataUrl = [NSString stringWithFormat:@"https://alarstudios.com/test/data.cgi?code=%@&p=%ld", code, (long)currentPage];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    __auto_type __weak weakSelf = self;
    NSURLSessionDataTask *loginTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if ([response respondsToSelector:@selector(statusCode)] && [(NSHTTPURLResponse *) response statusCode] < 300)
        {
            self->isFetchInProgress = NO;
            __auto_type __strong strongSelf = weakSelf;
            [strongSelf processResponseUsingData:data];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self->isFetchInProgress = NO;
                self->total = self->total - NUMBER_OF_ROWS_AT_PAGE;
                __auto_type __strong strongSelf = weakSelf;
                [strongSelf.delegate onFetchFailedWithReason:@"An error occurred while fetching data. Please, check network connection"];
            });
            
        }
    }];
    [loginTask resume];
}

- (void)processResponseUsingData:(NSData *)data
{
    NSError *parseJsonError = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseJsonError];
    
    __auto_type __weak weakSelf = self;
    if (nil == parseJsonError)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *locations = jsonDict[@"data"];
            self->total = self->total + NUMBER_OF_ROWS_AT_PAGE;
            self->currentPage++;
            __auto_type __strong strongSelf = weakSelf;
            [strongSelf addData:locations];
            [strongSelf.delegate onFetchCompletedWithNewIndexPathsToReload:[self calculateIndexPathsToReload]];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->total = self->total - NUMBER_OF_ROWS_AT_PAGE;
            __auto_type __strong strongSelf = weakSelf;
            [strongSelf.delegate onFetchFailedWithReason:@"An error occurred while decoding data. Please, check data"];
        });
    }
}

- (void)addData:(NSArray *)locations
{
    for (NSDictionary *location in locations)
    {
        Airport *airport = [[Airport alloc] init];
        airport.name = location[@"name"];
        airport.country = location[@"country"];
        airport.idn = location[@"id"];
        airport.lat = [location[@"lat"]stringValue];
        airport.lon = [location[@"lon"]stringValue];
        airport.imageURL = [NSString stringWithFormat:@"https://www.gstatic.com/webp/gallery/%u%s", arc4random_uniform(4) + 1, ".jpg"];
        [airports addObject:airport];
    }
}

- (NSArray<NSIndexPath *> *)calculateIndexPathsToReload
{
    NSUInteger startIndex = airports.count - NUMBER_OF_ROWS_AT_PAGE;
    NSUInteger endIndex = airports.count;
    NSMutableArray *indexPathsToReload = [[NSMutableArray alloc] init];
    for (NSUInteger index = startIndex; index < endIndex; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [indexPathsToReload addObject:indexPath];
    }
    return indexPathsToReload;
}

@end
