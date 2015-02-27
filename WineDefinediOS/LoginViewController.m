//
//  LoginViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/24/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:233/255.0 green:0 blue:18/255.0 alpha:1];
    // Do any additional setup after loading the view.
    self.passwordLoginTextField.delegate = self;
    self.emailLoginTextField.delegate = self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3323.png"]];
    
    //self.wineImage.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake((self.view.frame.size.width/2) - (250/2),
                                 (self.view.frame.size.height/2) - (230 ),
                                 250,
                                 200);
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:0 blue:18/255.0 alpha:1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.passwordLoginTextField.secureTextEntry = YES;
    
    
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"LoginSegue"]) {
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            return YES;
        }
        else{
            return NO;
            
        }
        
    }
    else{
        return YES;
    }
    
    
    
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

-(void)dismissKeyboard {
    [self.passwordLoginTextField resignFirstResponder];
    [self.emailLoginTextField resignFirstResponder];
}

- (IBAction)loginButton:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.emailLoginTextField.text password:self.passwordLoginTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSString *errorString = [[error userInfo] objectForKey:@"error"];
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                                                            message:errorString
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"OK"
                                                                                  otherButtonTitles:nil];
                                            [alert show];
                                            
                                        }
                                    }];
    
  
    

    
}

@end
