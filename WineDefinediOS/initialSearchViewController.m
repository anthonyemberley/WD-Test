//
//  initialSearchViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/5/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "initialSearchViewController.h"
#import "recentCellaringViewController.h"
#import "recentNotesViewController.h"
#import "recentTouringViewController.h"


@interface initialSearchViewController ()

@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) NSArray *recentArray;

@property (strong, nonatomic) UIPickerView *theDatePicker;
@property (strong, nonatomic) UIView *pickerView;
@property NSInteger checkViewAllNotes;

@property NSInteger testInt;
@end

@implementation initialSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor redColor];
    self.testInt = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
    [self.classTextField.superview addGestureRecognizer:tapGesture];
    [self.recentTextField.superview addGestureRecognizer:tapGesture];
    self.classTextField.delegate = self;
    
    self.typeTextField.delegate = self;
    self.typeTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.wineryTextField.delegate = self;
    self.wineryTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.recentTextField.delegate = self;
    
    _theDatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(-10, 70, 320, 480)];
    _theDatePicker.delegate = self;
    _theDatePicker.dataSource = self;
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    self.classTextField.inputView = dummyView;
    self.recentTextField.inputView = dummyView;
    self.typeTextField.returnKeyType = UIReturnKeyDone;
    self.wineryTextField.returnKeyType = UIReturnKeyDone;
    // Do any additional setup after loading the view.
    
    [self.segmentControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    
    self.navigationItem.title = @"WineDefined";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Note" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonPressed:)];
    anotherButton.tintColor =[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    
    
    
    //picker array initialization
    NSArray *classStuff = [[NSArray alloc] initWithObjects:@"Red Table Wine", @"White Table Wine", @"Rosé Table Wine", @"Sparkling Wine", @"Aperitif Wine", @"Dessert Wine", nil];
    self.classArray = classStuff;
    
    NSArray *recentStuff = [[NSArray alloc] initWithObjects:@"One Week", @"One Month", @"6 Months", @"All Notes", nil];
    self.recentArray = recentStuff;
    
    self.segmentControl.selectedSegmentIndex =self.segmentIndex;
    self.segmentControl.backgroundColor = [UIColor redColor];
    self.segmentControl.tintColor = [UIColor whiteColor];
   
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    // you can have multiple textfields here
    
    
}


#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        //bring up picker view with picker array of class stuff
        self.testInt = 1;
        self.pickerArray = self.classArray;
        [self createPickerAndShow];
    }
    else if(textField.tag == 3){
        //bring up picker view with picker array of recent times stuff
        self.testInt = 2;
        self.pickerArray = self.recentArray;
        [self createPickerAndShow];
    }
}


#pragma mark - picker view delegate methods


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}



-(void) createPickerAndShow {
    
    //[self.tableview setContentSize:CGSizeMake(self.tableview.frame.size.width, self.tableview.frame.size.height +500)];
    
    
    UIToolbar *controlToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _pickerView.bounds.size.width, 44)];
    
    [controlToolbar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStyleDone target:self action:@selector(setPicker)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDateSet)];
    
    [controlToolbar setItems:[NSArray arrayWithObjects:spacer, cancelButton, setButton, nil] animated:NO];
    
    
    [_theDatePicker setFrame:CGRectMake(0, controlToolbar.frame.size.height - 15, controlToolbar.frame.size.width, _theDatePicker.frame.size.height)];
    
    if (!_pickerView) {
        
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(_theDatePicker.frame.origin.x, _theDatePicker.frame.origin.y, _theDatePicker.frame.size.width, _theDatePicker.frame.size.height + self.tabBarController.tabBar.frame.size.height +15)];
        
    } else { 
        [_pickerView setHidden:NO];
    }
    
    
    CGFloat pickerViewYpositionHidden = self.view.frame.size.height + _pickerView.frame.size.height;
    
    CGFloat pickerViewYposition = self.view.frame.size.height - _pickerView.frame.size.height;
    
    
    [_pickerView setFrame:CGRectMake(_pickerView.frame.origin.x,
                                     pickerViewYpositionHidden,
                                     _pickerView.frame.size.width,
                                     _pickerView.frame.size.height)];
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    [_pickerView addSubview:controlToolbar];
    [_pickerView addSubview:_theDatePicker];
    [_theDatePicker setHidden:NO];
    
    
    [self.view addSubview:_pickerView];
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [_pickerView setFrame:CGRectMake(_pickerView.frame.origin.x,
                                                          pickerViewYposition,
                                                          _pickerView.frame.size.width,
                                                          _pickerView.frame.size.height)];
                     }
                     completion:nil];
    [self.theDatePicker reloadAllComponents];
    
    //    if (self.currentIndexPath.section != 0 && self.currentIndexPath.section != 1) {
    //        CGPoint _contentOffset = CGPointMake(self.tableview.contentOffset.x, _pickerView.frame.size.height + controlToolbar.frame.size.height );
    //        [self.tableview setContentOffset:_contentOffset animated:YES];
    //
    //    }
    
    
}

-(void) cancelDateSet {
    CGFloat pickerViewYpositionHidden = self.view.frame.size.height + _pickerView.frame.size.height;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [_pickerView setFrame:CGRectMake(_pickerView.frame.origin.x,
                                                          pickerViewYpositionHidden,
                                                          _pickerView.frame.size.width,
                                                          _pickerView.frame.size.height)];
                     }
                     completion:nil];
    
    [self.view endEditing:YES];
    
    
}

-(void)setPicker{
    CGFloat pickerViewYpositionHidden = self.view.frame.size.height + _pickerView.frame.size.height;
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [_pickerView setFrame:CGRectMake(_pickerView.frame.origin.x,
                                                          pickerViewYpositionHidden,
                                                          _pickerView.frame.size.width,
                                                          _pickerView.frame.size.height)];
                     }
                     completion:nil];
    [self.view endEditing:YES];
    
//    UITableViewCell *tempCell = [self.tableview cellForRowAtIndexPath:self.currentIndexPath];
    NSInteger row = [_theDatePicker selectedRowInComponent:0];
//    tempCell.detailTextLabel.text = [self.pickerArray objectAtIndex:row];
//    if (self.pickerArray == self.classArray) {
//        self.classString = [self.pickerArray objectAtIndex:row];
//    }
    //[self.tableview reloadData];
    
    if (self.testInt ==1 ) {
        self.classTextField.text = [self.pickerArray objectAtIndex:row];
    }
    else if (self.testInt == 2){
        self.recentTextField.text = [self.pickerArray objectAtIndex:row];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
       
        
    }
    tView.textAlignment = NSTextAlignmentCenter;
    
    // Fill the label text here
    tView.textAlignment = NSTextAlignmentCenter;
    
    
    tView.text = [self.pickerArray objectAtIndex:row];
    
    
    
    return tView;
}

-(void)leftBarButtonPressed:(id) sender{
    
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self performSegueWithIdentifier:@"searchToTasting" sender:self];
    }else if (self.segmentControl.selectedSegmentIndex == 1){
        [self performSegueWithIdentifier:@"searchToCellaring" sender:self];
    }else if (self.segmentControl.selectedSegmentIndex == 2){
        [self performSegueWithIdentifier:@"searchToTouring" sender:self];
    }
}

- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (CGRectContainsPoint(self.classTextField.frame, point) || CGRectContainsPoint(self.recentTextField.frame, point) )
        {
            [self createPickerAndShow];
        }
    }
}

- (IBAction)goButton:(id)sender {
    self.checkViewAllNotes = 0;
    
    if (self.segmentControl.selectedSegmentIndex == 0){
        [self performSegueWithIdentifier:@"recentNotesSegue" sender:self
         ];
    }
    else if (self.segmentControl.selectedSegmentIndex == 1){
        [self performSegueWithIdentifier:@"recentCellaringSegue" sender:self
         ];
    }
    else if (self.segmentControl.selectedSegmentIndex == 2){
        [self performSegueWithIdentifier:@"recentTouringSegue" sender:self
         ];
    }
    
}

- (IBAction)viewAllNotesButton:(id)sender {
    self.checkViewAllNotes = 1;
    if (self.segmentControl.selectedSegmentIndex == 0){
        [self performSegueWithIdentifier:@"recentNotesSegue" sender:self
         ];
    }
    else if (self.segmentControl.selectedSegmentIndex == 1){
        [self performSegueWithIdentifier:@"recentCellaringSegue" sender:self
         ];
    }
    else if (self.segmentControl.selectedSegmentIndex == 2){
        [self performSegueWithIdentifier:@"recentTouringSegue" sender:self
         ];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"recentNotesSegue"])
    {
        if (self.checkViewAllNotes == 0) {
            recentNotesViewController *vc = [segue destinationViewController];
            vc.wineryString = self.wineryTextField.text;
            vc.typeString = self.typeTextField.text;
            vc.timeString = self.recentTextField.text;
            vc.classString = self.classTextField.text;
        }
        else{
            recentNotesViewController *vc = [segue destinationViewController];
            vc.wineryString = @"";
            vc.typeString = @"";
            vc.timeString = @"";
            vc.classString = @"";
            
        }
        
    }
    if ([[segue identifier] isEqualToString:@"recentCellaringSegue"])
    {
        if (self.checkViewAllNotes == 0) {
            recentCellaringViewController *vc = [segue destinationViewController];
            vc.wineryString = self.wineryTextField.text;
            vc.typeString = self.typeTextField.text;
            vc.evaluationString = self.recentTextField.text;
            vc.classString = self.classTextField.text;
        }
        else{
            recentCellaringViewController *vc = [segue destinationViewController];
            vc.wineryString = @"";
            vc.typeString = @"";
            vc.evaluationString = @"";;
            vc.classString = @"";
        }
    }
    if ([[segue identifier] isEqualToString:@"recentTouringSegue"])
    {
        
        if (self.checkViewAllNotes == 0) {
            recentTouringViewController *vc = [segue destinationViewController];
            vc.wineryString = self.wineryTextField.text;
            vc.typeString = self.typeTextField.text;
            vc.timeString = self.classTextField.text;
            vc.classString = self.classTextField.text;
        }
        else{
            recentTouringViewController *vc = [segue destinationViewController];
            vc.wineryString = @"";
            vc.typeString = @"";
            vc.timeString = @"";
            vc.classString = @"";
            
        }
    }
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
        
    {
        // code for the first button
        NSArray *classStuff = [[NSArray alloc] initWithObjects:@"Red Table Wine", @"White Table Wine", @"RoséTable Wine", @"Sparkling Wine", @"Aperitif Wine", @"Dessert Wine", nil];
        self.classArray = classStuff;
        self.classTextField.placeholder = @"Class";
        self.typeTextField.hidden = NO;
        self.wineryTextField.hidden = NO;
        self.recentTextField.hidden = NO;
        self.recentTextField.placeholder = @"How Recent?";
        NSArray *recentStuff = [[NSArray alloc] initWithObjects:@"One Week", @"One Month", @"6 Months", @"All Notes", nil];
        self.classTextField.text = @"";
        self.typeTextField.text = @"";
        self.wineryTextField.text = @"";
        self.recentTextField.text = @"";
        self.recentArray = recentStuff;
    }
        else if (segment.selectedSegmentIndex == 1){
            NSArray *newRecentArray = [[NSArray alloc] initWithObjects:@"5", @"4", @"3", @"2", @"1", @"0", @"All", nil];
            self.recentTextField.placeholder = @"Cellaring Rating";
            self.recentArray = newRecentArray;
            self.typeTextField.hidden = NO;
            self.wineryTextField.hidden = NO;
            self.recentTextField.hidden = NO;
            self.classTextField.text = @"";
            self.typeTextField.text = @"";
            self.wineryTextField.text = @"";
            self.recentTextField.text = @"";
            self.classTextField.placeholder = @"Class";
    
    }
        else if (segment.selectedSegmentIndex == 2){
            
            self.classTextField.placeholder = @"Search By Date";
            NSArray *dateSearchArray = [[NSArray alloc] initWithObjects:@"One Week", @"One Month", @"One Year", @"All Touring Notes", nil];
            self.classArray = dateSearchArray;
            self.typeTextField.hidden = YES;
            self.wineryTextField.hidden = YES;
            self.recentTextField.hidden = YES;
            self.classTextField.text = @"";
            self.typeTextField.text = @"";
            self.wineryTextField.text = @"";
            self.recentTextField.text = @"";
        }

}

@end
