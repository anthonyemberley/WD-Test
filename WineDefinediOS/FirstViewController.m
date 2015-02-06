//
//  FirstViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 10/15/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "FirstViewController.h"
#import "TableViewSectionsViewController.h"
#import "newCellaringNoteViewController.h"
#import "newTouringNoteViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, self.navigationController.navigationBar.frame.origin.x + 44,self.navigationController.navigationBar.frame.size.width ,self.navigationController.navigationBar.frame.size.height );
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    
    [self.navigationController.view addSubview:toolBar];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
  
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









- (IBAction)newFileButton:(id)sender {
    
    
}

- (IBAction)addButton:(id)sender {
}

- (IBAction)settingsButton:(id)sender {
}
- (IBAction)addNote:(id)sender {
    NSInteger selectedSegment = self.viewSegments.selectedSegmentIndex;
    if (selectedSegment == 0) {
        TableViewSectionsViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewSectionsViewController"];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    else if (selectedSegment == 1) {
        newCellaringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newCellaringNoteViewController"];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    else if (selectedSegment == 2) {
        newTouringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newTouringNoteViewController"];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    
    
}

- (IBAction)recentNotesButton:(id)sender {
     NSInteger selectedSegment = self.viewSegments.selectedSegmentIndex;
    if (selectedSegment == 0) {
        TableViewSectionsViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"recentNotesViewController"];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    else if (selectedSegment == 1) {
        newCellaringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"recentCellaringViewController"];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    else if (selectedSegment == 2) {
        newTouringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"recentTouringViewController"];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
}

- (IBAction)searchNotes:(id)sender {
}
@end
