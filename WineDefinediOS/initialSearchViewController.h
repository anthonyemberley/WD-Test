//
//  initialSearchViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/5/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface initialSearchViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITextField *classTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *wineryTextField;
@property (weak, nonatomic) IBOutlet UITextField *recentTextField;
@property NSInteger segmentIndex;
- (IBAction)goButton:(id)sender;
- (IBAction)viewAllNotesButton:(id)sender;

@end
