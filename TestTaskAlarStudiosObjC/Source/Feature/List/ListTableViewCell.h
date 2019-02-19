//
//  ListTableViewCell.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 11.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Airport.h"
#import "UIImageView+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell

- (void)configureWithAirport:(nullable Airport *)airport;

@end

NS_ASSUME_NONNULL_END
