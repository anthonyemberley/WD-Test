//
//  initialAccessoriesViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/31/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "initialAccessoriesViewController.h"
#import "TextDataReader.h"
#import "AccessoriesView.h"

@interface initialAccessoriesViewController ()

@end

@implementation initialAccessoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    AccessoriesView *av = [[AccessoriesView alloc] initWithFrame:self.view.bounds];
    [av setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:av];
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
