//
//  DetailViewController.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 12.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Airport.h"
#import "Annotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Airport *airport;

@end

NS_ASSUME_NONNULL_END
