//
//  ButtonEnablingBehavior.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockHandlers.h"

NS_ASSUME_NONNULL_BEGIN

@interface ButtonEnablingBehavior : NSObject

- (instancetype)initWithTextFields:(NSArray *)textFields onChange:(Block1Bool)onChange;

@end

NS_ASSUME_NONNULL_END
