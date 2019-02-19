//
//  LoginViewModel.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService
{
    NSString *username;
    NSString *password;
    BOOL isLoginInProgress;
}

- (instancetype)initWithUsername:(NSString *)aUsername password:(NSString *)aPassword
{
    if ((self = [super init]))
    {
        username = aUsername;
        password = aPassword;
        isLoginInProgress = NO;
    }
    return self;
}

- (void)requestLogin
{
    if (YES == isLoginInProgress)
    {
        return;
    }
    isLoginInProgress = YES;
    
    NSString *dataUrl = [NSString stringWithFormat:@"https://alarstudios.com/test/auth.cgi?username=%@&password=%@", username, password];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    __auto_type __weak weakSelf = self;
    NSURLSessionDataTask *loginTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if ([response respondsToSelector:@selector(statusCode)] && [(NSHTTPURLResponse *) response statusCode] < 300)
        {
            self->isLoginInProgress = NO;
            __auto_type __strong strongSelf = weakSelf;
            [strongSelf processResponseUsingData:data];
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self->isLoginInProgress = NO;
                __auto_type __strong strongSelf = weakSelf;
                [strongSelf.delegate onLoginFailedWithReason:@"An error occurred while fetching data. Please, check network connection"];
            });

        }
    }];
    [loginTask resume];
}

- (void)processResponseUsingData:(NSData*)data
{
    NSError *parseJsonError = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseJsonError];

    __auto_type __weak weakSelf = self;
    if (nil == parseJsonError)
    {
        if ([@"ok" isEqualToString:jsonDict[@"status"]])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                __auto_type __strong strongSelf = weakSelf;
                [strongSelf.delegate onLoginCompletedWithCode:jsonDict[@"code"]];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                __auto_type __strong strongSelf = weakSelf;
                [strongSelf.delegate onLoginFailedWithReason:@"Invalid pair Username/Password. Please, try again"];
            });
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            __auto_type __strong strongSelf = weakSelf;
            [strongSelf.delegate onLoginFailedWithReason:@"An error occurred while decoding data. Please, check data"];
        });
    }
}

@end
