//
//  CreateNoteViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 11/9/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateNoteViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *fileSectionNameLabel;

- (IBAction)addPhotoButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *filesImage;
@property (weak, nonatomic) IBOutlet UITextField *appearanceTextField;
@property (weak, nonatomic) IBOutlet UITextField *fragranceAndFlavorTextField;
@property (weak, nonatomic) IBOutlet UITextField *mouthFeelTextField;
@property (weak, nonatomic) IBOutlet UITextField *finishTextField;
@property (weak, nonatomic) IBOutlet UITextField *evaluationTextField;
@property (weak, nonatomic) IBOutlet UISlider *ratingSlider;
@property (weak, nonatomic) IBOutlet UILabel *ratingValueLabel;
@property (weak, nonatomic) IBOutlet UITextField *wineNameBrandTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;

@property (weak, nonatomic) IBOutlet UITextField *appalationVintageSpecialTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentsTextField;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *viewyView;

@end
