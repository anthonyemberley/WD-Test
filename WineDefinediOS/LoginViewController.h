//
//  LoginViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/24/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailLoginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordLoginTextField;
- (IBAction)loginButton:(id)sender;


@end
