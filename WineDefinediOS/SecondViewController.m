//
//  SecondViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 10/15/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Failed"
                                                    message:@"hello"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
