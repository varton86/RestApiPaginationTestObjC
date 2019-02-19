//
//  ButtonEnablingBehavior.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "ButtonEnablingBehavior.h"

@implementation ButtonEnablingBehavior
{
    NSMutableArray<UITextField *> *textFields;
    Block1Bool onChange;
}

- (instancetype)initWithTextFields:(NSArray *)aTextFields onChange:(Block1Bool)aOnChange
{
    if ((self = [super init]))
    {
        textFields = [NSMutableArray arrayWithArray:aTextFields];
        onChange = aOnChange;
    }
    [self setup];
    return self;
}

- (void)setup
{
    for (UITextField *textField in textFields)
    {
        [textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    Block1BoolSafeCall(onChange, false);
}

- (void)textFieldDidChange
{
    BOOL enable = true;
    for (UITextField *textField in textFields)
    {
        if ((nil == textField.text) || ([@"" isEqualToString:textField.text]))
        {
            enable = false;
            break;
        }
    }
    Block1BoolSafeCall(onChange, enable);
}

@end
