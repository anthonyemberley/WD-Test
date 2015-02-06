//
//  FinalEditViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/23/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//
#import "Parse/Parse.h"
#import <UIKit/UIKit.h>

@interface FinalEditViewController : UIViewController <UITextViewDelegate >
@property(strong, nonatomic) NSString *textString;
@property(strong, nonatomic) NSString *classString;
@property(strong, nonatomic) NSString *typeString;
@property(strong, nonatomic) NSString *wineryString;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (strong, nonatomic) UIImage *rightImageImage;
@property (strong   , nonatomic) UIImage *leftImageImage;
@property NSInteger checkInt;
@property NSInteger fromWhichView;
@property NSString *eventName;
@property PFObject *currentTastingObject;

- (IBAction)leftImageTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rightImageTapped;


@end
