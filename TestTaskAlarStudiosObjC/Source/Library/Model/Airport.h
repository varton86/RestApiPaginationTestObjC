//
//  Airport.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Airport : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *idn;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
