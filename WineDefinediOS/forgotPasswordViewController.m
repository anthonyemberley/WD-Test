//
//  forgotPasswordViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 2/3/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "forgotPasswordViewController.h"
#import "Parse/Parse.h"

@interface forgotPasswordViewController ()

@end

@implementation forgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissKeyboard {
    
    [self.emailTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetPasswordButton:(id)sender {
    
    [PFUser requestPasswordResetForEmailInBackground:self.emailTextField.text block:^(BOOL succeeded, NSError *error) {
        if(!error)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Reset"
                                                            message:@"We have sent you an email with instructions on resetting your password"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Reset Failed"
                                                            message:errorString
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}
@end
