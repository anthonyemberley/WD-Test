//
//  newTouringNoteViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/29/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "newTouringNoteViewController.h"
#import "newCellaringNoteViewController.h"
#import "TableViewSectionsViewController.h"
#import "initialSearchViewController.h"
#import "Parse/Parse.h"

@interface newTouringNoteViewController ()

@property (strong, nonatomic) UIPickerView *classPickerView;
@property NSInteger toggle;
@property NSInteger rowIsSelectable;
@property UIImageView *leftImage;
@property UIImageView *rightImage;
@property CGSize imageSize;
@property NSString *classString;
@property NSString *evaluationString;

@property (strong, nonatomic) UISegmentedControl *viewSegments;



//Just Trying Stuff
@property (strong, nonatomic) UIPickerView *theDatePicker;
@property (strong, nonatomic) UIView *pickerView;
@property (strong, nonatomic) UIView *randomView;

//Cell index paths to show different pickers
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NSIndexPath *classCell;
@property (nonatomic, strong) NSIndexPath *wineryCell;
@property (nonatomic, strong) NSIndexPath *aromasAndFlavorsCell;
@property (nonatomic, strong) NSIndexPath *typeCell;
@property (nonatomic, strong) NSIndexPath *vintageCell;
@property (nonatomic, strong) NSIndexPath *whenCell;
@property (nonatomic, strong) NSIndexPath *whenCell2;
@property (nonatomic, strong) NSIndexPath *appearanceCell;
@property (nonatomic, strong) NSIndexPath *mouthfeelCell;
@property (nonatomic, strong) NSIndexPath *mouthfeelCell2;
@property (nonatomic, strong) NSIndexPath *finishCell;
@property (nonatomic, strong) NSIndexPath *evaluationCell;
@property (nonatomic, strong) NSIndexPath *ratingCell;
@property (nonatomic, strong) NSIndexPath *whereCell;
@property (nonatomic, strong) NSIndexPath *finalEditCell;
@property (nonatomic, strong) NSIndexPath *eventCell;
@property (nonatomic, strong) NSIndexPath *cityCell;





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
@property (nonatomic, retain) UITextField *eventTextFieldView;
@property (nonatomic, retain) UITextField *cityTextFieldView;


@property(strong, nonatomic) NSString *editTextString;

@end

@implementation newTouringNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonPressed:)];
    anotherButton2.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = anotherButton2;
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Tasting", @"Cellaring", @"Touring", nil];
    self.viewSegments = [[UISegmentedControl alloc] initWithItems:itemArray];
    self.viewSegments.backgroundColor = [UIColor redColor];
    self.viewSegments.tintColor = [UIColor whiteColor];
    
    self.viewSegments.frame = CGRectMake(0, 0, self.view.frame.size.width-2, 30);
    [self.viewSegments addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.viewSegments.selectedSegmentIndex = 2;
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
    
    
    
    self.sectBool = true;
    
    self.wineryTextFieldView.delegate = self;
    self.typeTextFieldView.delegate = self;
    self.vintageTextFieldView.delegate = self;
    self.whenTextFieldView.delegate = self;
    self.eventTextFieldView.delegate = self;
    self.cityTextFieldView.delegate = self;
    
    
    self.aromasCategoriesArray = [[NSArray alloc] initWithObjects:@"Berryish:",  @"Floral:", @"Fruity:", @"Herbal:", @"Nutty:", @"Spicy:", @"Sweet:", @"Veggy:", @"Woody:", nil];
    
    
    
    
    
    
    //Navigation bar custimization
    self.navigationItem.title = @"WineDefined";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    anotherButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
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
    NSArray *classStuff = [[NSArray alloc] initWithObjects:@"Red Table Wine", @"White Table Wine", @"Rosé Table Wine", @"Sparkling Wine", @"Aperitif Wine", @"Dessert Wine", nil];
    self.classArray = classStuff;
    
    NSArray *appearanceStuff = [[NSArray alloc] initWithObjects:@"Bright and deep with beautiful color.", @"Clear and acceptable color for type.",  nil];
    self.appearanceArray = appearanceStuff;
    
    NSArray *mouthfeelStuff = [[NSArray alloc] initWithObjects:@"Impressive in its texture and balance. ", @"Clean palate impression & good balance.", @"A touch too harsh, rough, hot /or flaccid.",   nil];
    self.mouthfeelArray = mouthfeelStuff;
    
    NSArray *finishStuff = [[NSArray alloc] initWithObjects:@"Outstanding length and memorable. ", @"Appealing aftertaste; refreshing, pleasing,", @"Offers only a short finish and length.", nil];
    self.finishArray = finishStuff;
    
    
    
    NSArray *evaluationStuff = [[NSArray alloc] initWithObjects:@"Remember this one!", @"Seems well-priced for its quality", @"OK but somewhat unmemorable, pricey. ", @"Avoid this one!", nil];
    self.evaluationArray = evaluationStuff;
    
    
    
    
    NSArray *berryishStuff = [[NSArray alloc] initWithObjects:@"Blackberry - subtle", @"Blackberry - forward", @"Blueberry - subtle", @"Blueberry - forward", @"Raspberry - subtle", @"Raspberry - forward", @"Strawberry - subtle", @"Strawberry - forward", nil];
    self.berryishArray = berryishStuff;
    
    NSArray *caramelStuff = [[NSArray alloc] initWithObjects:@"Butter - subtle",@"Butter - forward", @"Chocolet - subtle",@"Chocolet - forward", @"Honey - subtle",@"Honey - forward", nil];
    self.caramelArray = caramelStuff;
    
    NSArray *floralStuff = [[NSArray alloc] initWithObjects:@"Blossomy - subtle",@"Blossomy - forward", @"Lilac - subtle",@"Lilac - forward", @"Violet - subtle", @"Violet - forward", @"Wild Flower - subtle", @"Wild Flower - forward", nil];
    self.floralArray = floralStuff;
    
    NSArray *fruityStuff = [[NSArray alloc] initWithObjects:@"Apple - subtle",@"Apple - forward", @"Citrusy - subtle",@"Citrusy - forward", @"Peach - subtle",@"Peach - forward", @"Pruny - subtle", @"Pruny - forward", @"Tropical - subtle",@"Tropical - forward", nil];
    self.fruityArray = fruityStuff;
    
    NSArray *herbalStuff = [[NSArray alloc] initWithObjects:@"Dried Leaves - subtle", @"Dried Leaves - forward", @"Grassy - subtle",@"Grassy - forward", @"Straw - subtle",@"Straw - forward", nil];
    self.herbalArray = herbalStuff;
    
    NSArray *nuttyStuff = [[NSArray alloc] initWithObjects:@"Almond - subtle",@"Almond - forward", @"Hazelnut - subtle",@"Hazelnut - forward", nil];
    self.nuttyArray = nuttyStuff;
    
    NSArray *spicyStuff = [[NSArray alloc] initWithObjects:@"Black Pepper - subtle", @"Black Pepper - forward", @"Cardamon - subtle", @"Cardamon - forward", @"Cumin - subtle",@"Cumin - forward", nil];
    self.spicyArray = spicyStuff;
    
    NSArray *sweetStuff = [[NSArray alloc] initWithObjects:@"Botrytised - subtle",@"Botrytised - forward", @"Honeyed - subtle",@"Honeyed - forward", @"Fully-Ripe-Fruit - subtle",@"Fully-Ripe-Fruit - forward", @"Strawberry - subtle", @"Strawberry - forward", nil];
    self.sweetArray = sweetStuff;
    
    NSArray *veggyStuff = [[NSArray alloc] initWithObjects:@"Asperagus - subtle",@"Asperagus - forward", @"Bell Pepper - subtle",@"Bell Pepper - forward", nil];
    self.veggieArray = veggyStuff;
    
    NSArray *woodyStuff = [[NSArray alloc] initWithObjects:@"Oaky - subtle",@"Oaky - forward", @"Smoky - subtle", @"Smoky - forward", @"Vanillin - subtle",@"Vanillin - forward",  nil];
    self.woodyArray = woodyStuff;
    
    
    
    
    
    
    
    NSIndexPath *tempIndexPath = [[NSIndexPath alloc] init];
    self.currentIndexPath = tempIndexPath;
    
    
    
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
                //cell.textLabel.text = @"Winery/Title";
                self.wineryCell = indexPath;
                
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
            
            
            
            return cell;
            
            
    }
    else if (row == 2 && section ==1){
            static NSString *CellIdentifier = @"TypeCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                //cell.textLabel.text = @"Type of Wine";
                self.typeCell = indexPath;
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
            
            
            
            return cell;
            
    }
    else if (row == 3 && section == 1){
            static NSString *CellIdentifier = @"EventCell";
            self.eventCell = indexPath;
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                self.whenCell2 = indexPath;
                //cell.textLabel.text = @"When/Where Tasted";
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 15, cell.frame.origin.y, cell.frame.size.width,40)];
                textField.placeholder = @"Event: *";
                textField.adjustsFontSizeToFitWidth = YES;
                textField.returnKeyType = UIReturnKeyDone;
                
                textField.delegate = self;
                [textField addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
                self.eventTextFieldView  = textField;
                
                [cell.contentView addSubview:self.eventTextFieldView];
            }
            
            
            
            return cell;
            
    }
        
    
    else if (section == 2 && row == 0){
        static NSString *CellIdentifier = @"VintageCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            self.vintageCell = indexPath;
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
        
        
        
        return cell;
    }
    
    
    
    else if (section == 2 && row == 1){
        static NSString *CellIdentifier = @"CityCell";
        self.whereCell = indexPath;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            self.whenCell2 = indexPath;
            //cell.textLabel.text = @"When/Where Tasted";
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.origin.x + 15, cell.frame.origin.y, cell.frame.size.width,40)];
            textField.placeholder = @"City/Place:";
            textField.adjustsFontSizeToFitWidth = YES;
            textField.returnKeyType = UIReturnKeyDone;
            
            textField.delegate = self;
            [textField addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
            self.cityTextFieldView  = textField;
            
            [cell.contentView addSubview:self.cityTextFieldView];
        }
        
        
        
        return cell;
        
    }
        
    
    else if(section == 3){
        
        static NSString *CellIdentifier = @"ColorCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        
        cell.textLabel.text = @"Color & Appearance (select one)";
        self.appearanceCell = indexPath;
        return cell;
    }
    
    else if(section == 4){
        
        
        
        
        self.aromasAndFlavorsCell = indexPath;
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"AromasCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = @"Aromas and Flavors - choose up to 3";
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
        else if (indexPath.row == 2){
            static NSString *CellIdentifier = @"FloralCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.floralCell = indexPath;
            return cell;
            
        }
        else if (indexPath.row == 3){
            static NSString *CellIdentifier = @"FruityCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.fruityCell = indexPath;
            return cell;
            
        }
        else if (indexPath.row == 4){
            static NSString *CellIdentifier = @"HerbalCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.herbalCell = indexPath;
            return cell;
            
        }
        else if (indexPath.row == 5){
            static NSString *CellIdentifier = @"NuttyCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.nuttyCell = indexPath;
            return cell;
            
        }
        else if (indexPath.row == 6){
            static NSString *CellIdentifier = @"SpicyCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.spicyCell = indexPath;
            
            return cell;
        }
        else if (indexPath.row == 7){
            static NSString *CellIdentifier = @"SweetCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.sweetCell = indexPath;
            return cell;
            
        }
        else if (indexPath.row == 8){
            static NSString *CellIdentifier = @"VeggieCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.veggieCell = indexPath;
            return cell;
            
        }
        else {
            static NSString *CellIdentifier = @"WoodyCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = [self.aromasCategoriesArray objectAtIndex:indexPath.row -1];
            self.woodyCell = indexPath;
            return cell;
            
        }
        
        
        
    }
    else if(section ==5){
        if (row == 0){
            static NSString *CellIdentifier = @"MouthFeelCell1";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            
            cell.textLabel.text = @"Mouthfeel (select one, refine by editing)";
            self.mouthfeelCell = indexPath;
            return cell;
        }
        else if (row ==1){
            static NSString *CellIdentifier = @"MouthFeelCell2";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            
            cell.textLabel.text =@"Mouthfeel (select one, refine by editing)";
            self.mouthfeelCell2 = indexPath;
            return cell;
        }
        
    }
    
    else if(section == 6){
        
        static NSString *CellIdentifier = @"FinishCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        
        cell.textLabel.text  = @"Finish (select one, refine by editing)";
        self.finishCell = indexPath;
        return cell;
    }
    
    else if(section ==7){
        
        static NSString *CellIdentifier = @"EvaluationCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        
        cell.textLabel.text = @"Evaluation. Select One (mandatory)";
        self.evaluationCell = indexPath;
        return cell;
    }
    else if(section ==8){
        self.ratingCell = indexPath;
        
        static NSString *CellIdentifier = @"RatingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    else if(section == 9){
        self.finalEditCell = indexPath;
        static NSString *CellIdentifier = @"FinalEditCell";
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = @"Final Edit";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
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
    if (section ==1){
        return 4;
    }
    else if (section == 2){
        return 2;
    }
    else if (section == 4){
        if (self.sectBool){
            return 1;
        }
        else{
            return 10;
        }
    }
    else if(section == 5){
        return 2;
    }
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
    if (section == 1){
        return @"(*Above data is required for saving and recall of your notes)";
    }
    else
        return @"";
    
}
- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section{
    if (section == 4){
        return @"Select one or two mouthfeels";
    }
    else if (section == 2){
        return @"ADD Specific Wine Identity such as: vintage, Vineyard Appellation,special identity, etc.";
    }
    else if (section == 1){
        return @"Identify winery, class and type of wine";
    }
    else{
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
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
    
    
    else if((indexPath.row == 0 || indexPath.row == 1) && indexPath.section == 5){
        self.pickerArray = self.mouthfeelArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    
    
    else if(indexPath.row == 0 && indexPath.section == 6){
        self.pickerArray = self.finishArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
        
        
    }
    else if(indexPath.row == 0 && indexPath.section == 7){
        self.pickerArray = self.evaluationArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
        
    }
    else if (indexPath.section == 4 && indexPath.row == 0){
        self.sectBool = !self.sectBool;
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:4]];
        }
        
        if (!self.sectBool) {
            [self.tableview beginUpdates];
            
            [self.tableview insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            
            
            [self.tableview endUpdates];
        }
        else{
            [self.tableview beginUpdates];
            
            [self.tableview deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            
            
            
            [self.tableview endUpdates];
            
        }
        
    }
    else if (indexPath.section == 4 && indexPath.row == 1){
        self.pickerArray = self.berryishArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 2){
        self.pickerArray = self.floralArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 3){
        self.pickerArray = self.fruityArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 4){
        self.pickerArray = self.herbalArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 5){
        self.pickerArray = self.nuttyArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 6){
        self.pickerArray = self.spicyArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 7){
        self.pickerArray = self.sweetArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 8){
        self.pickerArray = self.veggieArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 4 && indexPath.row == 9){
        self.pickerArray = self.woodyArray;
        [self.tableview scrollToRowAtIndexPath:[self.tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        [self createPickerAndShow];
        
    }
    else if (indexPath.section == 9)   {
        [self performSegueWithIdentifier:@"touringToFinalEditSegue" sender:self];
    }
    
    
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
    
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
            
            [tView setFont:[UIFont systemFontOfSize:15]];
        }
        else if (self.pickerArray == self.finishArray){
            
            [tView setFont:[UIFont systemFontOfSize:12]];
        }
        else if (self.pickerArray == self.evaluationArray){
            
            [tView setFont:[UIFont systemFontOfSize:15]];
        }
        
        
    }
    tView.textAlignment = NSTextAlignmentCenter;
    
    // Fill the label text here
    tView.textAlignment = NSTextAlignmentCenter;
    
    
    tView.text = [self.pickerArray objectAtIndex:row];
    
    
    
    return tView;
}

//helper function for deciding which picker view to show
-(void)updatePickerForIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(void)checkSavebutton{
    
    
    if (self.classString.length >= 1  && ([self.wineryTextFieldView.text length] >= 1 ) && ([self.typeTextFieldView.text length] >= 1 ) && ([self.eventTextFieldView.text length] >= 1 ) && (self.evaluationString.length >=1)) {
        self.rowIsSelectable = 1;
        self.navigationItem.rightBarButtonItem.enabled =YES;
        
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        self.rowIsSelectable = 0;
        
        
        
        
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
    tempCell.detailTextLabel.text = [self.pickerArray objectAtIndex:row];
    if (self.pickerArray == self.classArray) {
        self.classString = [self.pickerArray objectAtIndex:row];
    }
    if (self.pickerArray == self.evaluationArray) {
        self.evaluationString = [self.pickerArray objectAtIndex:row];
    }
    [self checkSavebutton];
    //[self.tableview reloadData];
    
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
    self.editTextString  = @"";
    [self updateTextString];
    
    NSString *wineryString = self.wineryTextFieldView.text;
    NSString *typeString = self.typeTextFieldView.text;
    
    UIImage *leftImage = self.leftImage.image;
    UIImage *rightImage = self.rightImage.image;
    
    PFUser *user = [PFUser currentUser];
    NSString *userString = user.username;
    
    PFObject *WDTouring = [PFObject objectWithClassName:@"WDTouring"];
    WDTouring[@"classString"] = self.classString;
    WDTouring[@"noteString"] = self.editTextString;
    WDTouring[@"wineryString"] = wineryString;
    WDTouring[@"typeString"] = typeString;
    WDTouring[@"userName"] = userString;
    WDTouring[@"eventName"] = self.eventTextFieldView.text;
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

-(void)leftBarButtonPressed:(id) sender{
    [self performSegueWithIdentifier:@"touringToInitialSearch" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"touringToFinalEditSegue"] ){
        self.editTextString = @"";
        [self updateTextString];
        FinalEditViewController *vc = [segue destinationViewController];
        
        
        vc.textString = self.editTextString;
        vc.rightImageImage = self.rightImage.image;
        vc.leftImageImage = self.leftImage.image;
        vc.classString = self.classString;
        vc.typeString = self.typeTextFieldView.text;
        vc.wineryString = self.wineryTextFieldView.text;
        vc.checkInt = 2;
        vc.fromWhichView = 2;
        vc.eventName = self.eventTextFieldView.text;
        
        
        
    }
    if ([[segue identifier] isEqualToString:@"touringToInitialSearch"] ){
        
        initialSearchViewController *vc = [segue destinationViewController];
        vc.segmentIndex = 2;
        
        
        
    }
    
}

- (void)updateTextString{
    
    UITableViewCell *cell5 = [self.tableview dequeueReusableCellWithIdentifier:@"WhenCell"];
    UITableViewCell *cell6 = [self.tableview cellForRowAtIndexPath:self.appearanceCell];
    UITableViewCell *cell8 = [self.tableview cellForRowAtIndexPath:self.mouthfeelCell];
    UITableViewCell *cell9 = [self.tableview cellForRowAtIndexPath:self.finishCell];
    UITableViewCell *cell10 = [self.tableview cellForRowAtIndexPath:self.evaluationCell];
    UITableViewCell *cell11 = [self.tableview cellForRowAtIndexPath:self.mouthfeelCell2];
    UITableViewCell *cell12 = [self.tableview cellForRowAtIndexPath:self.ratingCell];
    
    
    UITableViewCell *aromas1 = [self.tableview dequeueReusableCellWithIdentifier:@"BerryCell"];
    UITableViewCell *aromas2 = [self.tableview dequeueReusableCellWithIdentifier:@"CaramelCell"];
    UITableViewCell *aromas3 = [self.tableview dequeueReusableCellWithIdentifier:@"FloralCell"];
    UITableViewCell *aromas4 = [self.tableview dequeueReusableCellWithIdentifier:@"FruityCell"];
    UITableViewCell *aromas5 = [self.tableview dequeueReusableCellWithIdentifier:@"HerbalCell"];
    UITableViewCell *aromas6 = [self.tableview dequeueReusableCellWithIdentifier:@"NuttyCell"];
    UITableViewCell *aromas7 = [self.tableview cellForRowAtIndexPath:self.spicyCell];
    UITableViewCell *aromas8 = [self.tableview cellForRowAtIndexPath:self.sweetCell];
    UITableViewCell *aromas9 = [self.tableview cellForRowAtIndexPath:self.veggieCell];
    UITableViewCell *aromas10 = [self.tableview cellForRowAtIndexPath:self.woodyCell];
    
    
    NSString *eventString = self.eventTextFieldView.text;
    NSString *cityString = self.cityTextFieldView.text;
    NSString *wineryString = self.wineryTextFieldView.text;
    NSString *typeString = self.typeTextFieldView.text;
    NSString *vintageString = self.vintageTextFieldView.text;
    NSString *whereString = self.whenTextFieldView.text;
    NSString *whenString = cell5.detailTextLabel.text;
    NSString *colorString = cell6.detailTextLabel.text;
    NSString *berryString = aromas1.detailTextLabel.text;
    NSString *caramelString = aromas2.detailTextLabel.text;
    NSString *floralString = aromas3.detailTextLabel.text;
    NSString *fruityString = aromas4.detailTextLabel.text;
    NSString *herbalString = aromas5.detailTextLabel.text;
    NSString *nuttyString = aromas6.detailTextLabel.text;
    NSString *spicyString = aromas7.detailTextLabel.text;
    NSString *sweetString = aromas8.detailTextLabel.text;
    NSString *veggieString = aromas9.detailTextLabel.text;
    NSString *woodyString = aromas10.detailTextLabel.text;
    NSString *mouthfeel1String = cell8.detailTextLabel.text;
    NSString *mouthfeel2String  = cell11.detailTextLabel.text;
    NSString *finishString = cell9.detailTextLabel.text;
    NSString *evaluationString = cell10.detailTextLabel.text;
    NSString *ratingString = cell12.detailTextLabel.text;
    
    
    NSString *bigString = @"Event: ";
    
    if (eventString.length >0) {
        
        bigString = [bigString stringByAppendingString:eventString];
        bigString = [bigString stringByAppendingString:@". "];
        
    }
    if (cityString.length>0){
        bigString = [bigString stringByAppendingString:@"City/Place: "];
        bigString = [bigString stringByAppendingString:cityString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    
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
    
    
    
    bigString = [bigString stringByAppendingString:wineryString];
    bigString = [bigString stringByAppendingString:@". "];

    
    bigString = [bigString stringByAppendingString:typeString];
    bigString = [bigString stringByAppendingString:@". "];
    
    bigString = [bigString stringByAppendingString:newClassString];
    bigString = [bigString stringByAppendingString:@". "];
    
    NSLog(@"this is the big string %@", bigString);
    
    if (whereString.length >0 ) {
        bigString = [bigString stringByAppendingString:@"This wine was tasted at "];
        bigString = [bigString stringByAppendingString:whereString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    
    if (vintageString.length >0 ) {
        bigString = [bigString stringByAppendingString:vintageString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    
    
    
    if (colorString.length >0) {
        bigString = [bigString stringByAppendingString:colorString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    
    NSInteger myIntegers[10];
    myIntegers[0] = berryString.length;
    myIntegers[1] = caramelString.length;
    myIntegers[2] = floralString.length;
    myIntegers[3] = fruityString.length;
    myIntegers[4] = herbalString.length;
    myIntegers[5] = nuttyString.length;
    myIntegers[6] = spicyString.length;
    myIntegers[7] = sweetString.length;
    myIntegers[8] = veggieString.length;
    myIntegers[9] = woodyString.length;
    
    
    
    NSInteger counter = 0;
    
    for (int i = 1; i < 10; i++) {
        // do something with object
        if (myIntegers[i] > 0) {
            counter += 1;
            
        }
        
    }
    NSLog(@"this is the counter %ld,", (long)counter);
    
    
    
    
    
    if (berryString.length > 0 || caramelString.length > 0 || floralString.length > 0 || fruityString.length > 0 || herbalString.length > 0 || nuttyString.length > 0 || spicyString.length > 0 || sweetString.length > 0 || veggieString.length > 0 || woodyString.length > 0 ){
        bigString = [bigString stringByAppendingString:@"Aromas and flavors have "];
        
        if (berryString.length > 0){
            NSArray* foo = [berryString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (caramelString.length > 0){
            NSArray* foo = [caramelString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (floralString.length > 0){
            NSArray* foo = [floralString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (fruityString.length > 0){
            NSArray* foo = [fruityString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (herbalString.length > 0){
            NSArray* foo = [herbalString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (nuttyString.length > 0){
            NSArray* foo = [nuttyString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (spicyString.length > 0){
            NSArray* foo = [spicyString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (sweetString.length > 0){
            NSArray* foo = [sweetString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (veggieString.length > 0){
            NSArray* foo = [veggieString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        if (woodyString.length > 0){
            NSArray* foo = [woodyString componentsSeparatedByString: @" "];
            NSString* forwardOrSubtle = [foo objectAtIndex: 2];
            if ([forwardOrSubtle isEqualToString:@"subtle"]){
                bigString = [bigString stringByAppendingString:@"subtle "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" tones"];
                
            }
            else{
                bigString = [bigString stringByAppendingString:@"forward "];
                bigString = [bigString stringByAppendingString:[foo objectAtIndex:0]];
                bigString = [bigString stringByAppendingString:@" impressions"];
            }
            counter -= 1;
            
            if (counter > 1) {
                bigString = [bigString stringByAppendingString:@", "];
                
            }
            else if(counter == 1){
                bigString = [bigString stringByAppendingString:@" and "];
            }
            else{
                bigString = [bigString stringByAppendingString:@". "];
                
            }
            
            
            
        }
        
    }
    
    
    if (mouthfeel1String.length >0) {
        bigString = [bigString stringByAppendingString:mouthfeel1String];
        
        if (mouthfeel2String.length > 0) {
            bigString = [bigString stringByAppendingString:@" and "];
            bigString = [bigString stringByAppendingString:mouthfeel2String];
            
        }
        else{
            bigString = [bigString stringByAppendingString:@". "];
        }
    }
    
    if (finishString.length > 0) {
        bigString = [bigString stringByAppendingString:finishString];
        if (finishString.length > 0) {
            bigString = [bigString stringByAppendingString:@". "];
        }
    }
    if (evaluationString.length > 0) {
        bigString = [bigString stringByAppendingString:evaluationString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    if (ratingString.length > 0) {
        
        bigString = [bigString stringByAppendingString:@"My overall rating of the wine is "];
        
        bigString = [bigString stringByAppendingString:ratingString];
        bigString = [bigString stringByAppendingString:@". "];
    }
    
    
    NSDate* now = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    bigString = [bigString stringByAppendingString:@" "];
    bigString = [bigString stringByAppendingString:[df stringFromDate:now]];
    
    
    
    
    self.editTextString = bigString;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)sliderValueChanged:(id)sender {
    UITableViewCell *cell   = [self.tableview cellForRowAtIndexPath:self.ratingCell];
    
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)self.ratingSlider.value];
    cell.detailTextLabel.text =  inStr;
    
    
    
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
        
        newCellaringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newCellaringNoteViewController"];
        [self.navigationController pushViewController:vc2 animated:NO];
    }
    else if (segment.selectedSegmentIndex == 2){
        newTouringNoteViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"newTouringNoteViewController"];
        
        [self.navigationController pushViewController:vc2 animated:NO];
    }
}



@end
