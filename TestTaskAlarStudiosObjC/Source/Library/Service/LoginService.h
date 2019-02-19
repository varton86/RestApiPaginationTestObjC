//
//  LoginViewModel.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginServiceDelegate;

@interface LoginService : NSObject

@property (nonatomic, strong) id <LoginServiceDelegate> delegate;

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;
- (void)requestLogin;

@end

@protocol LoginServiceDelegate <NSObject>

- (void)onLoginCompletedWithCode:(NSString *)code;
- (void)onLoginFailedWithReason:(NSString *)reason;

@end

NS_ASSUME_NONNULL_END
