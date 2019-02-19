//
//  ViewController.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonEnablingBehavior.h"
#import "ListViewController.h"
#import "LoginService.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController <LoginServiceDelegate>

@end

NS_ASSUME_NONNULL_END
