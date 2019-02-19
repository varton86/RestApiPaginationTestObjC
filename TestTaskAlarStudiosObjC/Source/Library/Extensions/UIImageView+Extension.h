//
//  UIImageView+LoadImage.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)

- (NSURLSessionDataTask *)loadImageFromURL:(NSString *)imageURL;

@end

NS_ASSUME_NONNULL_END
