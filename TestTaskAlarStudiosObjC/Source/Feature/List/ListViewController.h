//
//  ListViewController.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataService.h"
#import "AlertDisplayer.h"
#import "ListTableViewCell.h"
#import "DetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController <DataServiceDelegate>

@property (strong, nonatomic) NSString *code;

@end

NS_ASSUME_NONNULL_END
