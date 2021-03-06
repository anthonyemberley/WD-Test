//
//  cellaringFinalEditViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "cellaringFinalEditViewController.h"
#import "newCellaringNoteViewController.h"
#import "Parse/Parse.h"
#import "MessageUI/MessageUI.h"
#import "viewImageViewController.h"

@interface cellaringFinalEditViewController ()  <
MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,
UINavigationControllerDelegate
>
@property (nonatomic, weak) IBOutlet UILabel *feedbackMsg;

@end

@implementation cellaringFinalEditViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textView.text = self.textString;
    
    self.textView.returnKeyType = UIReturnKeyDefault;
    if (self.checkInt == 2) {
        self.navigationItem.hidesBackButton = YES;
        
    }
    
    //self.evaluationLabel.text = [@"Evaluation: " stringByAppendingString:self.evaluationIntString];
    //    self.rightImageImage = [[UIImage alloc] init];
    //    self.leftImageImage = [[UIImage alloc] init];
    UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    //self.evaluationLabel.font = boldFont;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    self.rightImageView.image = self.rightImageImage;
    self.leftImageView.image = self.leftImageImage;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"leftCellaringPictureSegue"])
    {
        viewImageViewController *vc = [segue destinationViewController];
        
        vc.leftImageImage = self.leftImageImage;
        vc.switchInt = 1;
    }
    if ([[segue identifier] isEqualToString:@"rightCellaringPictureSegue"])
    {
        viewImageViewController *vc = [segue destinationViewController];
        
        vc.rightImageImage = self.rightImageImage;
        vc.switchInt = 2;
    }
    
}
- (BOOL)textViewShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)rightBarButtonPressed:(id) sender{
    
    
    //    FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    //    NSArray *tempArray = [[NSArray alloc] initWithObjects:@"hello World",@"hi come on", nil];
    //    firstViewController.dataArray = tempArray;
    //    firstViewController.myString = @"hiyyya";
    //    //[firstViewController.tableView reloadData];
    //    NSLog(@"this is the info, %@", firstViewController.myString);
    //
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //
    //[self updateTextString];
    //[self performSegueWithIdentifier:@"passTheData" sender:self];
    
    
    
    
    if (self.checkInt == 2){
        PFUser *user = [PFUser currentUser];
        NSString *userString = user.username;
        
        UIImage *leftImage = self.leftImageView.image;
        UIImage *rightImage = self.rightImageView.image;

        
        PFObject *WDCellaring = [PFObject objectWithClassName:@"WDCellaring"];
        WDCellaring[@"classString"] = self.classString;
        WDCellaring[@"noteString"] = self.textView.text;
        WDCellaring[@"wineryString"] = self.wineryString;
        WDCellaring[@"typeString"] = self.typeString;
        WDCellaring[@"userName"] = userString;
        if (self.evaluationIntString != nil){
            WDCellaring[@"evaluation"] = self.evaluationIntString;
        }
        else{
            WDCellaring[@"evaluation"] = [NSNull null];
        }
        [WDCellaring setObject:[NSDate date] forKey:@"myDate"];
        
        NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
        NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
        PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
        PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
        
        WDCellaring[@"leftImage"] = leftImageFile;
        WDCellaring[@"rightImage"] = rightImageFile;
        
        [WDCellaring[@"leftImage"] pinInBackground];
        [WDCellaring[@"rightImage"] pinInBackground];
        [WDCellaring pinInBackground];
        [WDCellaring saveEventually];
        newCellaringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newCellaringNoteViewController"];
        
        
        [self.navigationController pushViewController:vc2 animated:YES ];
    }
    else if(self.checkInt ==1){
        PFUser *user = [PFUser currentUser];
        NSString *userString = user.username;
        
        UIImage *leftImage = self.leftImageView.image;
        UIImage *rightImage = self.rightImageView.image;
        
        
        
        self.currentTastingObject[@"classString"] = self.classString;
        self.currentTastingObject[@"noteString"] = self.textView.text;
        self.currentTastingObject[@"wineryString"] = self.wineryString;
        self.currentTastingObject[@"typeString"] = self.typeString;
        self.currentTastingObject[@"userName"] = userString;
        if (self.evaluationIntString != nil){
            self.currentTastingObject[@"evaluation"] = self.evaluationIntString;
        }
        else{
            self.currentTastingObject[@"evaluation"] = [NSNull null];
        }
        [self.currentTastingObject setObject:[NSDate date] forKey:@"myDate"];
        
        NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
        NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
        PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
        PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
        
        self.currentTastingObject[@"leftImage"] = leftImageFile;
        self.currentTastingObject[@"rightImage"] = rightImageFile;
        
        
//        [WDCellaring pinInBackground];
//        [WDCellaring saveInBackground];
        newCellaringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newCellaringNoteViewController"];
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    // you can have multiple textfields here
    
    
}


#pragma mark - Actions

// -------------------------------------------------------------------------------
//  showMailPicker:
//  IBAction for the Compose Mail button.
// -------------------------------------------------------------------------------
- (IBAction)showMailPicker:(id)sender
{
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet];
    }
    else
        // The device can not send email.
    {
        self.feedbackMsg.hidden = NO;
        self.feedbackMsg.text = @"Device not configured to send mail.";
    }
}

// -------------------------------------------------------------------------------
//  showSMSPicker:
//  IBAction for the Compose SMS button.
// -------------------------------------------------------------------------------
- (IBAction)showSMSPicker:(id)sender
{
    // You must check that the current device can send SMS messages before you
    // attempt to create an instance of MFMessageComposeViewController.  If the
    // device can not send SMS messages,
    // [[MFMessageComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMessageComposeViewController canSendText])
        // The device can send email.
    {
        [self displaySMSComposerSheet];
    }
    else
        // The device can not send email.
    {
        self.feedbackMsg.hidden = NO;
        self.feedbackMsg.text = @"Device not configured to send SMS.";
    }
}

#pragma mark - Compose Mail/SMS

// -------------------------------------------------------------------------------
//  displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"WineDefined Note"];
    
    // Set up recipients
    
   
    
    // Attach an image to the email
    
    NSData *myData = UIImageJPEGRepresentation(self.leftImageImage, 1);
    NSData *myData2 = UIImageJPEGRepresentation(self.leftImageImage, 1);
    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];

    [picker addAttachmentData:myData2 mimeType:@"image/jpeg" fileName:@"rainy2"];

    // Fill out the email body text
    NSString *firstText = self.textView.text;
    firstText = [firstText stringByAppendingString:self.evaluationLabel.text];
    firstText = [firstText stringByAppendingString:@" "];
    NSString *emailBody = firstText;
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// -------------------------------------------------------------------------------
//  displayMailComposerSheet
//  Displays an SMS composition interface inside the application.
// -------------------------------------------------------------------------------
- (void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
    // You can specify one or more preconfigured recipients.  The user has
    // the option to remove or add recipients from the message composer view
    // controller.
    /* picker.recipients = @[@"Phone number here"]; */
    
    // You can specify the initial message text that will appear in the message
    // composer view controller.
    NSString *firstText = self.textView.text;
    firstText = [firstText stringByAppendingString:self.evaluationLabel.text];
    firstText = [firstText stringByAppendingString:@" "];
    picker.body = firstText;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark - Delegate Methods

// -------------------------------------------------------------------------------
//  mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    self.feedbackMsg.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            self.feedbackMsg.text = @"Result: Mail sending canceled";
            break;
        case MFMailComposeResultSaved:
            self.feedbackMsg.text = @"Result: Mail saved";
            break;
        case MFMailComposeResultSent:
            self.feedbackMsg.text = @"Result: Mail sent";
            break;
        case MFMailComposeResultFailed:
            self.feedbackMsg.text = @"Result: Mail sending failed";
            break;
        default:
            self.feedbackMsg.text = @"Result: Mail not sent";
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// -------------------------------------------------------------------------------
//  messageComposeViewController:didFinishWithResult:
//  Dismisses the message composition interface when users tap Cancel or Send.
//  Proceeds to update the feedback message field with the result of the
//  operation.
// -------------------------------------------------------------------------------
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    self.feedbackMsg.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MessageComposeResultCancelled:
            self.feedbackMsg.text = @"Result: SMS sending canceled";
            break;
        case MessageComposeResultSent:
            self.feedbackMsg.text = @"Result: SMS sent";
            break;
        case MessageComposeResultFailed:
            self.feedbackMsg.text = @"Result: SMS sending failed";
            break;
        default:
            self.feedbackMsg.text = @"Result: SMS not sent";
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)leftPictureButton:(id)sender {
}
@end
