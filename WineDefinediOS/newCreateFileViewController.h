//
//  newCreateFileViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 11/9/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newCreateFileViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *appearancePickerView;

@end
