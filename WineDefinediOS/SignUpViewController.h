//
//  SignUpViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/24/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)signUpButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;

@end
