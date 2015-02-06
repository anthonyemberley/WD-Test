//
//  viewImageViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/8/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "viewImageViewController.h"

@interface viewImageViewController ()

@end

@implementation viewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.switchInt == 1) {
        self.imageView.image = self.leftImageImage;
    }
    else if( self.switchInt == 2){
        self.imageView.image = self.rightImageImage;
    }
    // Do any additional setup after loading the view.
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

@end
