//
//  SignUpViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/24/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:0 blue:18/255.0 alpha:1];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.retypePasswordTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUpButton:(id)sender {
    
    
    if (self.passwordTextField.text != self.retypePasswordTextField.text ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password doesn't match"
                                                        message:@"Please retype your password"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        self.passwordTextField.text = @"";
        self.retypePasswordTextField.text = @"";
    }else{
    
        PFUser *user = [PFUser user];
        user.username = self.emailTextField.text;
        user.password = self.passwordTextField.text;
        user.email = self.emailTextField.text;
        
        
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                [self performSegueWithIdentifier:@"LoginFromSignUpSegue" sender:self];
                
            } else {
                
                // Show the errorString somewhere and let the user try again.
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Failed"
                                                                message:errorString
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
            }
        }];
    }
    
}

-(void)dismissKeyboard {
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}
@end
