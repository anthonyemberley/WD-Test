//
//  CreateNoteViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 11/9/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "CreateNoteViewController.h"

@interface CreateNoteViewController ()

@end

@implementation CreateNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewyView.hidden = YES;
    self.tabBarController.tabBar.hidden  = YES;
    
    
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

- (IBAction)addPhotoButton:(id)sender {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}


@end
