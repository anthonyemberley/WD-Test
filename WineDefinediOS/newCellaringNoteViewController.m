//
//  newCellaringNoteViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/29/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "newCellaringNoteViewController.h"
#import "newTouringNoteViewController.h"
#import "TableViewSectionsViewController.h"
#import "initialSearchViewController.h"
#import "cellaringFinalEditViewController.h"
#import "Parse/Parse.h"

@interface newCellaringNoteViewController ()


@property (strong, nonatomic) UIPickerView *classPickerView;
@property NSInteger toggle;
@property NSInteger pickerToggle;
@property NSString *tempYear;
@property UIImageView *leftImage;
@property UIImageView *rightImage;
@property CGSize imageSize;
@property NSInteger rowIsSelectable;
@property NSString* overallRating;
@property NSString* evaluationString;

//Just Trying Stuff
@property (strong, nonatomic) UIPickerView *theDatePicker;
@property (strong, nonatomic) UIView *pickerView;
@property (strong, nonatomic) UIView *randomView;
@property NSString *classString;
@property (strong, nonatomic) UISegmentedControl *viewSegments;

//Cell index paths to show different pickers
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NSIndexPath *classCell;
@property (nonatomic, strong) NSIndexPath *wineryCell;
@property (nonatomic, strong) NSIndexPath *aromasAndFlavorsCell;
@property (nonatomic, strong) NSIndexPath *typeCell;
@property (nonatomic, strong) NSIndexPath *vintageCell;
@property (nonatomic, strong) NSIndexPath *whenCell;
@property (nonatomic, strong) NSIndexPath *whenCell2;
@property (nonatomic, strong) NSIndexPath *whenCell3;
@property (nonatomic, strong) NSIndexPath *appearanceCell;
@property (nonatomic, strong) NSIndexPath *mouthfeelCell;
@property (nonatomic, strong) NSIndexPath *mouthfeelCell2;
@property (nonatomic, strong) NSIndexPath *finishCell;
@property (nonatomic, strong) NSIndexPath *evaluationCell;
@property (nonatomic, strong) NSIndexPath *ratingCell;
@property (nonatomic, strong) NSIndexPath *finalEditCell;




//aromas and flavors cells
@property (nonatomic, strong) NSIndexPath *berryishCell;
@property (nonatomic, strong) NSIndexPath *caramelCell;
@property (nonatomic, strong) NSIndexPath *floralCell;
@property (nonatomic, strong) NSIndexPath *fruityCell;
@property (nonatomic, strong) NSIndexPath *herbalCell;
@property (nonatomic, strong) NSIndexPath *nuttyCell;
@property (nonatomic, strong) NSIndexPath *spicyCell;
@property (nonatomic, strong) NSIndexPath *sweetCell;
@property (nonatomic, strong) NSIndexPath *veggieCell;
@property (nonatomic, strong) NSIndexPath *woodyCell;





@property (nonatomic, strong) UISlider *ratingSlider;


@property (nonatomic, retain) NSArray *aromasCategoriesArray;

@property (nonatomic, retain) NSArray *pickerArray;
@property (nonatomic, retain) NSArray *classArray;
@property (nonatomic, retain) NSArray *appearanceArray;
@property (nonatomic, retain) NSArray *mouthfeelArray;
@property (nonatomic, retain) NSArray *finishArray;
@property (nonatomic, retain) NSArray *evaluationArray;
@property (nonatomic, retain) NSArray *whyArray;
@property (nonatomic, retain) NSMutableArray *yearArray;

@property (nonatomic, retain) NSArray *berryishArray;
@property (nonatomic, retain) NSArray *caramelArray;
@property (nonatomic, retain) NSArray *floralArray;
@property (nonatomic, retain) NSArray *fruityArray;
@property (nonatomic, retain) NSArray *herbalArray;
@property (nonatomic, retain) NSArray *nuttyArray;
@property (nonatomic, retain) NSArray *spicyArray;
@property (nonatomic, retain) NSArray *sweetArray;
@property (nonatomic, retain) NSArray *veggieArray;
@property (nonatomic, retain) NSArray *woodyArray;



@property(assign) BOOL sectBool;



@property (nonatomic, retain) UITextField *wineryTextFieldView;
@property (nonatomic, retain) UITextField *typeTextFieldView;
@property (nonatomic, retain) UITextField *vintageTextFieldView;
@property (nonatomic, retain) UITextField *whenTextFieldView;
@property (nonatomic, retain) UITextField *whereTextFieldView;


@property(strong, nonatomic) NSString *editTextString;



@end

@implementation newCellaringNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewSegments.backgroundColor = [UIColor redColor];
    self.viewSegments.tintColor = [UIColor whiteColor];
    
    self.pickerToggle = 0;
    NSArray *itemArray = [NSArray arrayWithObjects: @"Tasting", @"Cellaring", @"Touring", nil];
    self.viewSegments = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.viewSegments.frame = CGRectMake(0, 0, self.view.frame.size.width-2, 30);
    [self.viewSegments addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.viewSegments.selectedSegmentIndex = 1;
    //self.tableview.tableHeaderView = self.viewSegments;
    
    //self.navigationController.navigationItem.titleView = self.viewSegments;
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.tintColor = [UIColor redColor];
    toolbar.barTintColor = [UIColor redColor];
    toolbar.frame = CGRectMake(0, 64, self.view.frame.size.width, 35);
    
    [self.view addSubview:toolbar];
    
    UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeparator.width = -15;
    UIBarButtonItem *segItem = [[UIBarButtonItem alloc] initWithCustomView:self.viewSegments];
    
    [toolbar setItems:[NSArray arrayWithObjects:negativeSeparator, segItem,nil] animated:YES];
    
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonPressed:)];
    anotherButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = anotherButton;
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
    
    self.sectBool = true;
    
    self.wineryTextFieldView.delegate = self;
    self.typeTextFieldView.delegate = self;
    self.vintageTextFieldView.delegate = self;
    self.whenTextFieldView.delegate = self;
    self.whereTextFieldView.delegate = self;
    
    self.aromasCategoriesArray = [[NSArray alloc] initWithObjects:@"Berryish:", @"Caramel:", @"Floral:", @"Fruity:", @"Herbal:", @"Nutty:", @"Spicy:", @"Sweet:", @"Veggy:", @"Woody:", nil];
    
    
    
    
    
    
    //Navigation bar custimization
    self.navigationItem.title = @"WineDefined";
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    anotherButton2.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = anotherButton2;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    //Picker View Allocations:
    //    self.classPickerView = [[UIPickerView alloc] initWithFrame:(CGRect){{0, 0}, 320, 480}];
    //    self.classPickerView.delegate = self;
    //    self.classPickerView.dataSource = self;
    //    self.classPickerView.center = (CGPoint){160, 640};
    //    self.classPickerView.hidden = YES;
    //    [self.view addSubview:self.classPickerView];
    UIPickerView *dp = [[UIPickerView alloc]init];
    self.classPickerView = dp;
    //self.classPickerView.hidden = YES;
    
    //[self.view addSubview:self.classPickerView];
    
    self.toggle = 0;
    
    
    // setup our data source
    //    NSMutableDictionary *itemOne = [@{ kTitleKey : @"Tap a cell to change its date:" } mutableCopy];
    //    NSMutableDictionary *itemTwo = [@{ kTitleKey : @"Start Date",
    //                                       kDateKey : [NSDate date] } mutableCopy];
    //    NSMutableDictionary *itemThree = [@{ kTitleKey : @"End Date",
    //                                         kDateKey : [NSDate date] } mutableCopy];
    //    NSMutableDictionary *itemFour = [@{ kTitleKey : @"(other item1)" } mutableCopy];
    //    NSMutableDictionary *itemFive = [@{ kTitleKey : @"(other item2)" } mutableCopy];
    //    self.dataArray = @[itemOne, itemTwo, itemThree, itemFour, itemFive];
    
    
    _theDatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(-10, 70, 320, 480)];
    _theDatePicker.delegate = self;
    _theDatePicker.dataSource = self;
    
    //[self.view addSubview:_theDatePicker];
    
    self.tableview.bounces = YES;
    
    
    //Array's for UIPickerViews
    NSMutableArray *yearArray = [[NSMutableArray alloc] init];
    
    for (int i = 2000; i<= 2099; i++) {
        NSString *strFromInt = [NSString stringWithFormat:@"%d",i];
        [yearArray addObject:strFromInt];
    }
    self.yearArray = yearArray;
    
    
    NSArray *classStuff = [[NSArray alloc] initWithObjects:@"Red Table Wine", @"White Table Wine", @"Rosé Table Wine", @"Sparkling Wine", @"Aperitif Wine", @"Dessert Wine", nil];
    self.classArray = classStuff;
    
    
    NSArray *appearanceStuff = [[NSArray alloc] initWithObjects:@"A wine deliberately selected for the Cellar.", @"Received as part of a “wine club” membership.", @"Received as a gift.", @"Received through a trade.", nil];
    NSMutableArray *appearanceArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i<= 100; i++) {
        NSString *strFromInt = [NSString stringWithFormat:@"%d",i];
        [appearanceArray addObject:strFromInt];
    }
    
    
    self.appearanceArray = appearanceStuff;
    
    
    
    
    
    
    NSArray *mouthfeelStuff = [[NSArray alloc] initWithObjects: @"A distinguished wine exceeding expectation.", @"The distinguished wine expected.", @"A good wine but short of expectation.", @"Falls way short of expectation.", @"Disappointing and over the hill.", @"Flawed wine.", nil];
    self.mouthfeelArray = mouthfeelStuff;
    
    
    
    
    
    NSArray *finishStuff = [[NSArray alloc] initWithObjects:@"5 Send to an Auction! Or, serve it and dazzle guests.", @"4 Continue to quietly age this wine!", @"3 Feature this wine at a hosted Dinner!", @"2 Gift (take it to someone as a small present).", @"1 Consume it now as a “Tuesday Night” wine.", @"0 Dead storage (curiosity interest only)", nil];
    self.finishArray = finishStuff;
    
    

    
    NSArray *whyArray = [[NSArray alloc] initWithObjects: @"Exceptional aromas and flavors, balance and length.", @"Attractive aromas, flavors, mouthfeel and length.", @"Pleasing aromas and flavors, rough mouthfeel, touch short.",@" Undistinguished aromas and flavors, smooth mouthfeel, short.", nil];
    self.whyArray = whyArray;
    
    
    
    
    
    
    
    
    NSIndexPath *tempIndexPath = [[NSIndexPath alloc] init];
    self.currentIndexPath = tempIndexPath;
    
    self.viewSegments.backgroundColor = [UIColor redColor];
    self.viewSegments.tintColor = [UIColor whiteColor];
    
    
    
}
-(void)doneButton{
    TableViewSectionsViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewSectionsViewController"];
    [self.navigationController pushViewController:vc2 animated:YES];
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



#pragma mark = UITableViewDataSource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self checkSavebutton];
    
    
    
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    
    if (section == 0){
        if (row == 0 ) {
            static NSString *CellIdentifier = @"PhotoCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                //Add custom objects to the cell in here!
                
                
                
                CGRect tempRect = cell.frame;
                cell.frame = CGRectMake(tempRect.origin.x, tempRect.origin.y, tempRect.size.width, tempRect.size.height +30);
                
                //right label
                UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x + 80, 38, cell.frame.size.height, cell.frame.size.height)];
                rightLabel.text = @"Back Label";
                rightLabel.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:rightLabel];
                
                //left label
                UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 40, 38, cell.frame.size.height, cell.frame.size.height)];
                leftLabel.text = @"Front Label";
                leftLabel.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:leftLabel];
                
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera.jpg"]];
                cell.textLabel.text = @"Add Photo";
                imageView.frame = CGRectMake(self.view.center.x +70, 38, cell.frame.size.height-10, cell.frame.size.height-10);
                
                
                imageView.center = CGPointMake(self.view.center.x +110, 33 );
                
                self.rightImage = imageView;
                [cell.contentView addSubview:self.rightImage];
                
                UIImageView *newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera.jpg"]];
                cell.textLabel.text = @"Add Photo";
                newImageView.frame = CGRectMake(310, 48, cell.frame.size.height-10, cell.frame.size.height-10);
                self.leftImage = newImageView;
                
                self.imageSize = CGSizeMake(self.leftImage.frame.size.width, self.leftImage.frame.size.height);
                
                newImageView.center = CGPointMake(self.view.center.x - 7,33 );
                [cell.contentView addSubview:self.leftImage];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button addTarget:self
                           action:@selector(rightImageButton)
                 forControlEvents:UIControlEventTouchUpInside];
                
                button.frame = CGRectMake(self.view.center.x +70, 38, cell.frame.size.height-10, cell.frame.size.height-10);
                button.center = CGPointMake(self.view.center.x +110, 33 );
                [cell.contentView addSubview:button];
                
                UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button2 addTarget:self
                            action:@selector(leftImageButton)
                  forControlEvents:UIControlEventTouchUpInside];
                
                button2.frame = CGRectMake(310, 48, cell.frame.size.height-10, cell.frame.size.height-10);
                button2.center = CGPointMake(self.view.center.x - 7,33 );
                [cell.contentView addSubview:button2];
            }
            
            
            cell.textLabel.text = @"Add Photo";
            CGRect tempRect = cell.frame;
            cell.frame = CGRectMake(tempRect.origin.x, tempRect.origin.y, tempRect.size.width, tempRect.size.height +30);
            return cell;
            
            
        }
    }
    if (row == 0 && section == 1){
            self.classCell = indexPath;
            static NSString *CellIdentifier = @"ClassCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            
            
            cell.textLabel.text = @"*Select Class (required)";
            
            return cell;
            
    }
    else if (row == 1 && section == 1){
            static NSString *CellIdentifier = @"WineryCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x +15, cell.frame.origin.y, cell.frame.size.width, 40)];
                textField.placeholder = @"*Enter Winery or Brand (required)";
                textField.adjustsFontSizeToFitWidth = YES;
                textField.returnKeyType = UIReturnKeyDone;
                textField.delegate = self;
                [textField addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
                self.wineryTextFieldView = textField;
                
                
                
                
                [cell.contentView addSubview:self.wineryTextFieldView];
            }
            
            
            //cell.textLabel.text = @"Winery/Title";
            self.wineryCell = indexPath;
            
            
            return cell;
            
            
    }
    else if (row == 2 && section == 1){
            static NSString *CellIdentifier = @"TypeCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x +15, cell.frame.origin.y, cell.frame.size.width, 40)];
                textField.placeholder = @"*Enter Type of Wine (required)";
                textField.adjustsFontSizeToFitWidth = YES;
                textField.returnKeyType = UIReturnKeyDone;
                
                textField.delegate = self;
                [textField addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
                self.typeTextFieldView = textField;
                [cell.contentView addSubview:self.typeTextFieldView];
                
            }
            
            
            //cell.textLabel.text = @"Type of Wine";
            self.typeCell = indexPath;
            return cell;
            
            
        }
        
    else if (section == 2 && row == 0){
        static NSString *CellIdentifier = @"VintageCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            //cell.textLabel.text = @"Vintage/Appellation/Price";
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 15, cell.frame.origin.y, cell.frame.size.width, 40)];
            textField.placeholder = @"Add label specifics; Vintage, et al . . .";
            textField.adjustsFontSizeToFitWidth = YES;
            textField.returnKeyType = UIReturnKeyDone;
            
            textField.delegate = self;
            [textField addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
            self.vintageTextFieldView = textField;
            
            [cell.contentView addSubview:self.vintageTextFieldView];
        }
        
        
        self.vintageCell = indexPath;
        
        return cell;
    }
    
    else if (section == 2 && row == 1){
        static NSString *CellIdentifier = @"WhenCell";
        self.whenCell = indexPath;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            //cell.textLabel.text = @"When/Where Tasted";
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 15, cell.frame.origin.y, cell.frame.size.width,40)];
            textField.placeholder = @"When Last Tasted:";
            textField.adjustsFontSizeToFitWidth = YES;
            textField.returnKeyType = UIReturnKeyDone;
            
            textField.delegate = self;
            [textField addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
            self.whenTextFieldView  = textField;
            
            [cell.contentView addSubview:self.whenTextFieldView];
        }
        
        
        
        return cell;
    
        
    }
    else if(section == 3 && row ==0){
        
        static NSString *CellIdentifier = @"HowManyCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        
        cell.textLabel.text = @"Source of Cellared Wine:";
        self.appearanceCell = indexPath;
        return cell;
    }
    else if (section == 3 && row ==1){
        static NSString *CellIdentifier = @"WhenNotedCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        
        self.whenCell3 = indexPath;
        //cell.textLabel.text = @"When/Where Tasted";
        //                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 15, cell.frame.origin.y, cell.frame.size.width,40)];
        cell.textLabel.text = @"When Noted:";
        NSDate* now = [NSDate date];
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterMediumStyle];
        [df setTimeStyle:NSDateFormatterShortStyle];
        NSString* myString = [df stringFromDate:now];
        cell.detailTextLabel.text = myString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //                textField.adjustsFontSizeToFitWidth = YES;
        //                textField.returnKeyType = UIReturnKeyDone;
        //
        //                textField.delegate = self;
        //                [textField addTarget:self
        //                              action:@selector(textFieldDidChange:)
        //                    forControlEvents:UIControlEventEditingChanged];
        //                self.whenTextFieldView  = textField;
        //
        //                [cell.contentView addSubview:self.whenTextFieldView];
        //
        return cell;
    }
    
    else if(section == 4){
        
        
        
        
        self.aromasAndFlavorsCell = indexPath;
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"WhyCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = @"Evaluation";
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            return cell;
        }
        else if (indexPath.row == 1){
            static NSString *CellIdentifier = @"BerryCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.berryishCell = indexPath;
            return cell;
            
        }
        
    }
    else if(section ==5){
        if (row == 0){
            static NSString *CellIdentifier = @"WhenLastTastedCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.textLabel.text = @"Strengths and Weaknesses:";
            self.mouthfeelCell = indexPath;
            return cell;
        }
        
        
    }
    
    else if(section == 6){
        
        self.ratingCell = indexPath;
        
        static NSString *CellIdentifier = @"RatingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [cell setUserInteractionEnabled:NO];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            UISlider *slider = [[UISlider alloc] init];
            slider.minimumValue = 70;
            slider.maximumValue = 100;
            
            [cell.contentView addSubview:slider];
            slider.bounds = CGRectMake(30, 0, cell.contentView.bounds.size.width - 80, slider.bounds.size.height -10);
            slider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds) +70, CGRectGetMidY(cell.contentView.bounds));
            //slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            [slider addTarget:self
                       action:@selector(sliderValueChanged:)
             forControlEvents:UIControlEventValueChanged];
            self.ratingSlider = slider;
        }
        
        
        cell.textLabel.text = @"My Rating";
        
        
        return cell;
    }
    
    
    else if(section == 7){
        self.finalEditCell = indexPath;
        static NSString *CellIdentifier = @"FinalEditCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = @"Final Edit";
        
        return cell;
        
        
    }
    
    
    else{
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        return cell;
        
        
        
        
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    return cell;
    
    
    
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0){
        return 1;
    }
   
    else if (section == 1 ){
        return 3;
    }
//    else if (section == 2){
//        return 2;
//    }
    else{
        
        return 1;
    }
}




#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0 && indexPath.section == 0)
        return 85;
    else
    {
        return 44;
    }
}

- (NSString *)tableView:(UITableView *)tv titleForFooterInSection:(NSInteger)section
{
    if (section == 1)
        return @"(*Above data is required for saving and recall of your notes)";
    else if (section == 6){
        return @"(*Above data is required for saving and recall of your notes)";
    }
    else
        return @"";
    
}
- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return @"Identify winery, class and type of wine";
    }else if (section ==3 ){
        return @"ADD Specific Wine Identity such as: vintage, Vineyard Appellation, special identity, etc.";
    }
   return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    self.currentIndexPath = indexPath;
    [self cancelDateSet];
    
    
    if(indexPath.row == 0 && indexPath.section == 1)
    {
        self.pickerArray = self.classArray;
        
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self createPickerAndShow];
    }
    else if(indexPath.row == 0 && indexPath.section == 3){
        self.pickerArray = self.appearanceArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
        
    }
    
    
    else if((indexPath.row == 0 || indexPath.row == 1) && indexPath.section == 4){
        self.pickerArray = self.mouthfeelArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    
    
    else if(indexPath.row == 0 && indexPath.section == 6){
        self.pickerArray = self.finishArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
        
        
    }
    else if (indexPath.section == 5 && indexPath.row == 0){

        self.pickerArray = self.whyArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
        
    }

    else if (indexPath.section == 7)   {
        
        //segue for final edit of cellaring
        [self performSegueWithIdentifier:@"cellaringFinalEditSegue" sender:self];
    }
    
    
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
    
}





#pragma mark Picker View methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    
    
    //[self.tableview reloadData];
    
    NSLog(@"row selected:%ld", (long)row);
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        
        tView = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        if (self.pickerArray == self.classArray) {
            [tView setFont:[UIFont systemFontOfSize:24]];
        }
        else if (self.pickerArray == self.mouthfeelArray){
            
            [tView setFont:[UIFont systemFontOfSize:12]];
        }
        else if (self.pickerArray == self.appearanceArray){
            
            [tView setFont:[UIFont systemFontOfSize:18]];
        }
        else if (self.pickerArray == self.finishArray){
            
            [tView setFont:[UIFont systemFontOfSize:12]];
        }
        else if (self.pickerArray == self.evaluationArray){
            
            [tView setFont:[UIFont systemFontOfSize:15]];
        }else if (self.pickerArray == self.whyArray){
            
            [tView setFont:[UIFont systemFontOfSize:12]];
        }
        
        
    }
    tView.textAlignment = NSTextAlignmentCenter;
    
    // Fill the label text here
    tView.textAlignment = NSTextAlignmentCenter;
    
    
    tView.text = [self.pickerArray objectAtIndex:row];
    
    [tView sizeToFit];
    
    
    return tView;
}

//helper function for deciding which picker view to show
-(void)updatePickerForIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(void)checkSavebutton{
    
    
    if (self.classString.length >= 1  && ([self.wineryTextFieldView.text length] >= 1 ) && ([self.typeTextFieldView.text length] >= 1 ) && (self.evaluationString.length >=1)) {
        self.rowIsSelectable = 1;
        self.navigationItem.rightBarButtonItem.enabled =YES;
    }
    else{
        self.rowIsSelectable = 0;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self checkSavebutton];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkSavebutton];
}
-(void)textFieldDidChange:(id) sender{
    [self checkSavebutton];
    
}

- (void)sliderValueChanged:(id)sender {
    UITableViewCell *cell   = [self.tableview cellForRowAtIndexPath:self.ratingCell];
    
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)self.ratingSlider.value];
    cell.detailTextLabel.text =  inStr;
    
    
    
}



//Problem is because we have a reuse Identifier in the storyboard for the other app but we don't here.  Fix this in wherever it uses the reuse Identifier in the code

-(void) createPickerAndShow {
    [self.tableview setFrame:CGRectMake(self.tableview.frame.origin.x, self.tableview.frame.origin.y, self.tableview.frame.size.width, self.tableview.frame.size.height -100)];
    //[self.tableview setContentSize:CGSizeMake(self.tableview.frame.size.width, self.tableview.frame.size.height +500)];
    
    
    UIToolbar *controlToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _pickerView.bounds.size.width, 44)];
    
    [controlToolbar sizeToFit];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStyleDone target:self action:@selector(setPicker)];
    UIBarButtonItem *skipButton = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDateSet)];
    
    
    [controlToolbar setItems:[NSArray arrayWithObjects:spacer, setButton, skipButton, nil] animated:NO];
    
    
    [_theDatePicker setFrame:CGRectMake(0, controlToolbar.frame.size.height - 15, controlToolbar.frame.size.width, _theDatePicker.frame.size.height)];
    
    if (!_pickerView) {
        
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(_theDatePicker.frame.origin.x, _theDatePicker.frame.origin.y, _theDatePicker.frame.size.width, _theDatePicker.frame.size.height + self.tabBarController.tabBar.frame.size.height +15)];
        
    } else {
        [_pickerView setHidden:NO];
    }
    
    //Title for toolbar on ui picker view
    
    
    if (self.pickerArray == self.yearArray) {
        
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
    
    UITableViewCell *tempCell = [self.tableview cellForRowAtIndexPath:self.currentIndexPath];
    NSInteger row = [_theDatePicker selectedRowInComponent:0];
   
    NSString *shortenedImprovementString = @"Expected improvement between ";
    NSString *shortenedEveryDayString = @"Purchased as pleasing “everyday wine” for year ";
    NSString *shortenedTargetString = @"Received as a gift. (estimate target year for drinking: ";
    NSString *shortenedTarget2String = @"Target year for peak improvement: ";
    NSString *shortenedNeedToBeDrunkString = @"The wine needs to be drunk while still appealing (by ";
    
    //code for multiple pickers along the way
    if(self.pickerArray == self.whyArray && row == 0){
        
        
        
        [self createPickerAndShow];
        
    }
    
    else if (self.pickerArray == self.mouthfeelArray && row ==1){
        self.pickerArray = self.yearArray;
        self.pickerToggle = 6;
        
        
        [self createPickerAndShow];
    }
    else if(self.pickerArray == self.whyArray && row == 1){
        
        
        
        [self createPickerAndShow];
        
    }
    else if(self.pickerArray == self.whyArray && row == 2){
        
        
        
        [self createPickerAndShow];
        
    }
    else if(self.pickerArray == self.yearArray && self.pickerToggle == 1){
        self.pickerToggle = 2;
        shortenedImprovementString = [shortenedImprovementString stringByAppendingString:[self.pickerArray objectAtIndex:row]];
        shortenedImprovementString = [shortenedImprovementString stringByAppendingString:@" and 20__"];
        tempCell.detailTextLabel.text = shortenedImprovementString;
        self.tempYear = [self.pickerArray objectAtIndex:row];
        [self createPickerAndShow];
        
    }
    else if (self.pickerArray == self.yearArray && self.pickerToggle == 2){
        shortenedImprovementString = [shortenedImprovementString stringByAppendingString:self.tempYear];
        shortenedImprovementString = [shortenedImprovementString stringByAppendingString:@" and "];
        shortenedImprovementString = [shortenedImprovementString stringByAppendingString:[self.pickerArray objectAtIndex:row]];
        tempCell.detailTextLabel.text = shortenedImprovementString;
        
    }
    else if (self.pickerArray == self.yearArray && self.pickerToggle == 3){
        shortenedEveryDayString = [shortenedEveryDayString stringByAppendingString:[self.pickerArray objectAtIndex:row]];
        tempCell.detailTextLabel.text = shortenedEveryDayString;
        
    }
    else if (self.pickerArray == self.yearArray && self.pickerToggle == 4){
        shortenedTargetString = [shortenedTargetString stringByAppendingString:[self.pickerArray objectAtIndex:row]];
        shortenedTargetString = [shortenedTargetString stringByAppendingString:@" )"];
        tempCell.detailTextLabel.text = shortenedTargetString;
        
    }
    else if (self.pickerArray == self.yearArray && self.pickerToggle == 5){
        shortenedTarget2String = [shortenedTarget2String stringByAppendingString:[self.pickerArray objectAtIndex:row]];
        
        tempCell.detailTextLabel.text = shortenedTarget2String;
        
    }
    else if (self.pickerArray == self.yearArray && self.pickerToggle == 6){
        shortenedNeedToBeDrunkString = [shortenedNeedToBeDrunkString stringByAppendingString:[self.pickerArray objectAtIndex:row]];
        shortenedNeedToBeDrunkString = [shortenedNeedToBeDrunkString stringByAppendingString:@" )."];
        tempCell.detailTextLabel.text = shortenedNeedToBeDrunkString;
        
    }
    
    
    
    else{
        tempCell.detailTextLabel.text = [self.pickerArray objectAtIndex:row];
        //[self.tableview reloadData];
    }
    
    if (self.pickerArray == self.finishArray) {
        NSInteger test = 5 - row;
        self.overallRating = [NSString stringWithFormat:@"%ld", (long)test];
        
    }
    if (self.pickerArray == self.classArray) {
        self.classString = [self.pickerArray objectAtIndex:row];
    }
    else if (self.pickerArray == self.finishArray){
        self.evaluationString = [self.pickerArray objectAtIndex:row];
    }
    [self checkSavebutton];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    // you can have multiple textfields here
    
    
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
    //[self performSegueWithIdentifier:@"passTheData" sender:self];
    [self updateTextString];
    PFUser *user = [PFUser currentUser];
    NSString *userString = user.username;
    
    UIImage *leftImage = self.leftImage.image;
    UIImage *rightImage = self.rightImage.image;
    
    
    PFObject *WDCellaring = [PFObject objectWithClassName:@"WDCellaring"];
    WDCellaring[@"classString"] = self.classString;
    WDCellaring[@"noteString"] = self.editTextString;
    WDCellaring[@"wineryString"] = self.wineryTextFieldView.text;
    WDCellaring[@"typeString"] = self.typeTextFieldView.text;
    WDCellaring[@"userName"] = userString;
    if (self.overallRating != nil){
        WDCellaring[@"evaluation"] = self.overallRating;
    }
    else{
        WDCellaring[@"evaluation"] = [NSNull null];
    }
    WDCellaring[@"evaluationString"] = self.evaluationString;
    [WDCellaring setObject:[NSDate date] forKey:@"myDate"];
    
    NSData *leftImageData = UIImageJPEGRepresentation(leftImage, 1);
    NSData *rightImageData = UIImageJPEGRepresentation(rightImage, 1);
    PFFile *leftImageFile = [PFFile fileWithName:@"Image.jpg" data:leftImageData];
    PFFile *rightImageFile = [PFFile fileWithName:@"Image.jpg" data:rightImageData];
    
    WDCellaring[@"leftImage"] = leftImageFile;
    WDCellaring[@"rightImage"] = rightImageFile;
    
    
    [WDCellaring pinInBackground];
    [WDCellaring saveInBackground];
    newCellaringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newCellaringNoteViewController"];
    
    
    [self.navigationController pushViewController:vc2 animated:YES ];
    
    
}
-(void)leftBarButtonPressed:(id) sender{
    [self performSegueWithIdentifier:@"cellaringToInitialSearch" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] isEqualToString:@"cellaringFinalEditSegue"] ){
        self.editTextString = @"";
        [self updateTextString];
        cellaringFinalEditViewController *vc = [segue destinationViewController];
        UIImage *test = self.leftImage.image;
        
        vc.textString = self.editTextString;
        vc.rightImageImage = self.rightImage.image;
        vc.leftImageImage = self.leftImage.image;
        vc.classString = self.classString;
        vc.typeString = self.typeTextFieldView.text;
        vc.wineryString = self.wineryTextFieldView.text;
        vc.checkInt = 2;
        vc.evaluationIntString = self.overallRating;
        //FinalEditViewController *vc = [segue destinationViewController];
        
        
        //vc.textString = self.editTextString;
        
    }
    if ([[segue identifier] isEqualToString:@"cellaringToInitialSearch"] ){
        self.editTextString = @"";
        [self updateTextString];
        initialSearchViewController *vc = [segue destinationViewController];
        vc.segmentIndex = 1;
        //FinalEditViewController *vc = [segue destinationViewController];
        
        
        //vc.textString = self.editTextString;
        
    }
}

- (void)updateTextString{
    UITableViewCell *cell5 = [self.tableview cellForRowAtIndexPath:self.whenCell3];
    UITableViewCell *cell8 = [self.tableview cellForRowAtIndexPath:self.mouthfeelCell];
    UITableViewCell *cell9 = [self.tableview cellForRowAtIndexPath:self.finishCell];
    UITableViewCell *cell10 = [self.tableview cellForRowAtIndexPath:self.evaluationCell];
    UITableViewCell *cell11 = [self.tableview cellForRowAtIndexPath:self.appearanceCell];
    UITableViewCell *cell12 = [self.tableview cellForRowAtIndexPath:self.aromasAndFlavorsCell];
    
    NSString *whyString = cell12.detailTextLabel.text;
    NSString *numberOfBottlesLeftString = cell11.detailTextLabel.text;
    NSString *wineryString = self.wineryTextFieldView.text;
    NSString *typeString = self.typeTextFieldView.text;
    NSString *vintageString = self.vintageTextFieldView.text;
    NSString *whenString3 = self.whenTextFieldView.text;
    NSString *whereString = self.whereTextFieldView.text;
    NSString *whenString = cell5.detailTextLabel.text;
    NSString *whenLastTastedString = cell8.detailTextLabel.text;
    
    NSString *evaluationString = cell9.detailTextLabel.text;
    
    
    
    
    
    NSString *newClassString = @"";
    
    if ([self.classString isEqualToString: @"Red Table Wine"]) {
        newClassString = @"Red";
    }
    else if ([self.classString isEqualToString: @"White Table Wine"]) {
        newClassString = @"White";
    }
    else if ([self.classString isEqualToString: @"Sparkling Wine"]) {
        newClassString = @"Sparkling";
    }
    else if ([self.classString isEqualToString: @"Apertif Wine"]) {
        newClassString = @"Apertif";
    }
    else if ([self.classString isEqualToString: @"Rosé Table Wine"]) {
        newClassString = @"Rosé";
    }
    else  if ([self.classString isEqualToString: @"Dessert Wine"]) {
        newClassString = @"Dessert";
    }
    
    NSString *bigString = wineryString;
    
    
    
    
    
//    bigString = [bigString stringByAppendingString:@": "];
//    bigString = [bigString stringByAppendingString:typeString];
//    bigString = [bigString stringByAppendingString:@" made by "];
//    bigString = [bigString stringByAppendingString:wineryString];
//    bigString = [bigString stringByAppendingString:@" is a "];
//    bigString = [bigString stringByAppendingString:self.classString];
//    bigString = [bigString stringByAppendingString:@". "];
    bigString = [bigString stringByAppendingString:@". "];
    bigString = [bigString stringByAppendingString:typeString];
    bigString = [bigString stringByAppendingString:@". "];
    bigString = [bigString stringByAppendingString:newClassString];
    bigString = [bigString stringByAppendingString:@". "];
    
    
    NSLog(@"this is the big string %@", bigString);
    
    if (whereString.length >0 ) {
        bigString = [bigString stringByAppendingString:@"This wine was tasted at "];
        bigString = [bigString stringByAppendingString:whereString];
        bigString = [bigString stringByAppendingString:@" "];
        bigString = [bigString stringByAppendingString:whenString];
        bigString = [bigString stringByAppendingString:@". "];
        
    }
    
    if (vintageString.length >0 ) {
        bigString = [bigString stringByAppendingString:vintageString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    
    if (numberOfBottlesLeftString.length >0) {
        bigString = [bigString stringByAppendingString:@"Number of bottles left: "];
        bigString = [bigString stringByAppendingString:numberOfBottlesLeftString];
        bigString = [bigString stringByAppendingString:@". "];
        
    }
    
    if (whyString.length >0) {
        bigString = [bigString stringByAppendingString:whyString];
        bigString = [bigString stringByAppendingString:@". "];
        
    }
    
    
    
    
    
    
    
    
    
    
    if (whenLastTastedString.length >0) {
        bigString = [bigString stringByAppendingString:whenLastTastedString];
        
        //bigString = [bigString stringByAppendingString:@". "];
    }
    
    
    if (evaluationString.length > 0) {
        bigString = [bigString stringByAppendingString:evaluationString];
        //bigString = [bigString stringByAppendingString:@". "];
    }
    
    NSDate* now = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    bigString = [bigString stringByAppendingString:@" "];
    bigString = [bigString stringByAppendingString:[df stringFromDate:now]];
    
    
    
    self.editTextString = bigString;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        TableViewSectionsViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewSectionsViewController"];
        [self.navigationController pushViewController:vc2 animated:NO];
    }
    else if (segment.selectedSegmentIndex == 1){
        
    }
    else if (segment.selectedSegmentIndex == 2){
        newTouringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newTouringNoteViewController"];
        [self.navigationController pushViewController:vc2 animated:NO];
    }
}



- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path
{
    // Determine if row is selectable based on the NSIndexPath.
    if (path == self.finalEditCell) {
        if (self.rowIsSelectable == 1)
        {
            return path;
        }
        return nil;
        
    }
    return path;
    
    
}


-(void)leftImageButton{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera] == YES){
        // Create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        self.toggle = 1;
        
        // Show image picker
        [self presentViewController:imagePicker animated:YES completion:nil];    }
    
}
-(void)rightImageButton{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera] == YES){
        // Create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        self.toggle = 2;
        
        // Show image picker
        [self presentViewController:imagePicker animated:YES completion:nil];    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
    image = [self imageWithImage:image scaledToSize:self.imageSize];
    
    if (self.toggle == 1) {
        self.leftImage.image = image;
    }
    else if (self.toggle == 2){
        self.rightImage.image = image;
    }
    
    
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
