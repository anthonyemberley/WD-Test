//
//  newCellaringNoteViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/29/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newCellaringNoteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
