//
//  DataService.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Airport.h"

NS_ASSUME_NONNULL_BEGIN

static const NSUInteger NUMBER_OF_ROWS_AT_PAGE = 10;

@protocol DataServiceDelegate;

@interface DataService : NSObject

@property (nonatomic, strong) id <DataServiceDelegate> delegate;

- (instancetype)initWithCode:(NSString *)code;
- (void)fetchData;
- (NSInteger)totalCount;
- (NSInteger)currentCount;
- (Airport *)airportAtIndex:(NSInteger)index;

@end

@protocol DataServiceDelegate <NSObject>

- (void)onFetchCompletedWithNewIndexPathsToReload:(NSArray<NSIndexPath *> *)newIndexPathsToReload;
- (void)onFetchFailedWithReason:(NSString *)reason;

@end

NS_ASSUME_NONNULL_END
