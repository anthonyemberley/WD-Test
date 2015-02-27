//
//  forgotPasswordViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 2/3/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgotPasswordViewController : UIViewController <UITextFieldDelegate>
- (IBAction)resetPasswordButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end
