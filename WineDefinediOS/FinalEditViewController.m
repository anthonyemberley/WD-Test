//
//  FinalEditViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/23/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "FinalEditViewController.h"
#import "FirstViewController.h"
#import "Parse/Parse.h"
#import "TableViewSectionsViewController.h"
#import "newTouringNoteViewController.h"
#import "recentNotesViewController.h"
#import <MessageUI/MessageUI.h>
#import "viewImageViewController.h"

@interface FinalEditViewController () <
MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, weak) IBOutlet UILabel *feedbackMsg;


@end

@implementation FinalEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textView.text = self.textString;
    self.textView.returnKeyType = UIReturnKeyDefault;
    if (self.checkInt == 2) {
        self.navigationItem.hidesBackButton = YES;
       
    }
//    self.rightImageImage = [[UIImage alloc] init];
//    self.leftImageImage = [[UIImage alloc] init];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    self.rightImage.image = self.rightImageImage;
    self.leftImage.image = self.leftImageImage;

    
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
    if ([[segue identifier] isEqualToString:@"leftCellaringPictureSegue2"])
    {
        viewImageViewController *vc = [segue destinationViewController];
        
        vc.leftImageImage = self.leftImageImage;
        vc.switchInt = 1;
    }
    if ([[segue identifier] isEqualToString:@"rightCellaringPictureSegue2"])
    {
        viewImageViewController *vc = [segue destinationViewController];
        
        vc.rightImageImage = self.rightImageImage;
        vc.switchInt = 2;
    }
    
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
    
    
    if (self.fromWhichView == 1){
        UIImage *leftImage = self.leftImage.image;
        UIImage *rightImage = self.rightImage.image;
        
        PFUser *user = [PFUser currentUser];
        NSString *userString = user.username;
        
        PFObject *WDTasting = [PFObject objectWithClassName:@"WDTasting"];
        WDTasting[@"classString"] = self.classString;
        WDTasting[@"noteString"] = self.textView.text;
        WDTasting[@"wineryString"] = self.wineryString;
        WDTasting[@"typeString"] = self.typeString;
        WDTasting[@"userName"] = userString;
        [WDTasting setObject:[NSDate date] forKey:@"myDate"];
        
        NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
        NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
        PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
        PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
        
        WDTasting[@"leftImage"] = leftImageFile;
        WDTasting[@"rightImage"] = rightImageFile;
        
        
        [WDTasting pinInBackground];
        [WDTasting saveInBackground];
        TableViewSectionsViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewSectionsViewController"];
        
        
        [self.navigationController pushViewController:vc2 animated:YES ];
        
    }
    else if ( self.fromWhichView == 2) {
        UIImage *leftImage = self.leftImage.image;
        UIImage *rightImage = self.rightImage.image;
        
        PFUser *user = [PFUser currentUser];
        NSString *userString = user.username;
        
        PFObject *WDTouring = [PFObject objectWithClassName:@"WDTouring"];
        WDTouring[@"classString"] = self.classString;
        WDTouring[@"noteString"] = self.textView.text;
        WDTouring[@"wineryString"] = self.wineryString;
        WDTouring[@"typeString"] = self.typeString;
        WDTouring[@"userName"] = userString;
        WDTouring[@"eventName"] = self.eventName;
        [WDTouring setObject:[NSDate date] forKey:@"myDate"];
        
        NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
        NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
        PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
        PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
        
        WDTouring[@"leftImage"] = leftImageFile;
        WDTouring[@"rightImage"] = rightImageFile;
        
        
        [WDTouring pinInBackground];
        [WDTouring saveInBackground];
        newTouringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newTouringNoteViewController"];
        
        
        [self.navigationController pushViewController:vc2 animated:YES ];
    }
    if (self.checkInt == 1 && self.fromWhichView == 1) {
        UIImage *leftImage = self.leftImage.image;
        UIImage *rightImage = self.rightImage.image;
        
        PFUser *user = [PFUser currentUser];
        NSString *userString = user.username;
        
        
        self.currentTastingObject[@"classString"] = self.classString;
        self.currentTastingObject[@"noteString"] = self.textView.text;
        self.currentTastingObject[@"wineryString"] = self.wineryString;
        self.currentTastingObject[@"typeString"] = self.typeString;
        self.currentTastingObject[@"userName"] = userString;
        [self.currentTastingObject setObject:[NSDate date] forKey:@"myDate"];
        
        NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
        NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
        PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
        PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
        
        self.currentTastingObject[@"leftImage"] = leftImageFile;
        self.currentTastingObject[@"rightImage"] = rightImageFile;
        
        
//        [self.currentTastingObject pinInBackground];
//        [self.currentTastingObject saveInBackground];
//        recentNotesViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"recentNotesViewController"];
//        
//        
//        [self.navigationController pushViewController:vc2 animated:YES ];
    }
    if (self.checkInt == 1 && self.fromWhichView == 2) {
        UIImage *leftImage = self.leftImage.image;
        UIImage *rightImage = self.rightImage.image;
        
        PFUser *user = [PFUser currentUser];
        NSString *userString = user.username;
        
        
        self.currentTastingObject[@"classString"] = self.classString;
        self.currentTastingObject[@"noteString"] = self.textView.text;
        self.currentTastingObject[@"wineryString"] = self.wineryString;
        self.currentTastingObject[@"typeString"] = self.typeString;
        self.currentTastingObject[@"eventName"] = self.eventName;
        self.currentTastingObject[@"userName"] = userString;
        [self.currentTastingObject setObject:[NSDate date] forKey:@"myDate"];
        
        NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
        NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
        PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
        PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
        
        self.currentTastingObject[@"leftImage"] = leftImageFile;
        self.currentTastingObject[@"rightImage"] = rightImageFile;
        
        
//        [self.currentTastingObject pinInBackground];
//        [self.currentTastingObject saveInBackground];
        //        recentNotesViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"recentNotesViewController"];
        //
        //
        //        [self.navigationController pushViewController:vc2 animated:YES ];
    }
    
    
    
    
}
-(void)leftBarButtonPressed:(id) sender{
    
}
- (BOOL)textViewShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



//Sharing Stuff

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
//    NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//    NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
//    
//    [picker setToRecipients:toRecipients];
//    [picker setCcRecipients:ccRecipients];
//    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
    NSData *myData = UIImageJPEGRepresentation(self.leftImageImage, 1);
    NSData *myData2 = UIImageJPEGRepresentation(self.leftImageImage, 1);
    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
    
    [picker addAttachmentData:myData2 mimeType:@"image/jpeg" fileName:@"rainy2"];
    // Fill out the email body text
    NSString *emailBody = self.textView.text;
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
    picker.body = self.textView.text;
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    // you can have multiple textfields here
    
    
}

- (IBAction)leftImageTapped:(id)sender {
}
@end
