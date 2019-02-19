//
//  Annotation.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 12.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

NS_ASSUME_NONNULL_END
