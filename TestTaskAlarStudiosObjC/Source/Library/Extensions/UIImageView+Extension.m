//
//  UIImageView+LoadImage.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation UIImageView (Extension)

- (NSURLSessionDataTask *)loadImageFromURL:(NSString *)imageURL
{
    NSURL *url = [NSURL URLWithString:imageURL];
    NSURLCache *cache = NSURLCache.sharedURLCache;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask;
    dataTask = nil;

    __auto_type __weak weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSData *data = [cache cachedResponseForRequest:request].data;
        UIImage * image = [UIImage imageWithData:data];
        if ((nil != data) && (nil != image))
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                __auto_type __strong strongSelf = weakSelf;
                strongSelf.image = image;
            });
        }
        else
        {
            NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
            {
                if ([response respondsToSelector:@selector(statusCode)] && [(NSHTTPURLResponse *) response statusCode] < 300)
                {
                    NSCachedURLResponse *cachedData = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                    [cache storeCachedResponse:cachedData forRequest:request];
                    UIImage * image = [UIImage imageWithData:data];
                    if (nil != image)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            __auto_type __strong strongSelf = weakSelf;
                            strongSelf.image = image;
                        });
                    }
                }
            }];
            [dataTask resume];
        }
    });
    return dataTask;
}

@end
