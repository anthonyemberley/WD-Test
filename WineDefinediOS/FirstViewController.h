//
//  FirstViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 10/15/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineTasting.h"

@interface FirstViewController : UIViewController
- (IBAction)newFileButton:(id)sender;
- (IBAction)addButton:(id)sender;
- (IBAction)settingsButton:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *viewSegments;
- (IBAction)addNote:(id)sender;
- (IBAction)recentNotesButton:(id)sender;
- (IBAction)searchNotes:(id)sender;

@end

