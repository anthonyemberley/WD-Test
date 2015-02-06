//
//  newTouringNoteViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/29/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newTouringNoteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
