//
//  ViewController.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

- (IBAction)tapLoginButton:(UIButton *)sender;
    
@end

@implementation LoginViewController
{
    ButtonEnablingBehavior *behavior;
    NSString *code;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    __auto_type __weak weakSelf = self;
    behavior = [[ButtonEnablingBehavior alloc] initWithTextFields:[NSArray arrayWithObjects:self.usernameTextField, self.passwordTextField, nil] onChange:^(BOOL enable)
    {
        __auto_type __strong strongSelf = weakSelf;
        if (YES == enable)
        {
            strongSelf.loginButton.enabled = YES;
            strongSelf.loginButton.alpha = 1;
        }
        else
        {
            strongSelf.loginButton.enabled = NO;
            strongSelf.loginButton.alpha = 0.5;
        }
    }];
    [self prepareGestureRecognizer];
}

- (IBAction)tapLoginButton:(UIButton *)sender
{
    [self loginCheck];
}

- (void)loginCheck
{
    self.view.userInteractionEnabled = NO;
    [self.indicatorView startAnimating];
    
    LoginService *loginService = [[LoginService alloc] initWithUsername:self.usernameTextField.text password:self.passwordTextField.text];
    loginService.delegate = self;
    [loginService requestLogin];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"ShowList" isEqualToString:segue.identifier])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ListViewController *listViewController = navigationController.viewControllers.firstObject;
        listViewController.code = code;
    }
}

- (void)prepareGestureRecognizer
{
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)onLoginCompletedWithCode:(NSString *)aCode
{
    self.view.userInteractionEnabled = YES;
    [self.indicatorView stopAnimating];
    code = aCode;
    [self performSegueWithIdentifier:@"ShowList" sender:self];
}

- (void)onLoginFailedWithReason:(NSString *)reason
{
    self.view.userInteractionEnabled = YES;
    [self.indicatorView stopAnimating];

    AlertDisplayer(self, reason);
}

@end
