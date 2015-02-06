//
//  TableViewSectionsViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 11/21/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "WineTasting.h"
#import "FinalEditViewController.h"

@interface TableViewSectionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UIToolbarDelegate, UITabBarControllerDelegate>
@property (strong, nonatomic) NSDictionary *names;
@property (strong, nonatomic) NSArray   *keys;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
