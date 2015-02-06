//
//  cellaringFinalEditViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface cellaringFinalEditViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIImage *rightImageImage;
@property (strong   , nonatomic) UIImage *leftImageImage;
@property (weak, nonatomic) IBOutlet UILabel *evaluationLabel;
- (IBAction)leftPictureButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rightPictureButton;



@property NSInteger checkInt;
@property(strong, nonatomic) NSString *textString;
@property(strong, nonatomic) NSString *classString;
@property(strong, nonatomic) NSString *typeString;
@property(strong, nonatomic) NSString *wineryString;
@property (strong,nonatomic) NSString *evaluationIntString;
@property PFObject *currentTastingObject;

@end
