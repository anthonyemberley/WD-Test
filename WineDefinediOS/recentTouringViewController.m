//
//  recentTouringViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/2/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "recentTouringViewController.h"
#import "Parse/Parse.h"
#import "FinalEditViewController.h"

@interface recentTouringViewController ()

@property(strong, nonatomic) NSMutableArray *tastingObjectsArray;
@property PFObject *currentTastingObject;
@property NSDate *longestDate;

@end

@implementation recentTouringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self findRecentDates];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tastingObjectsArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    
    [self findQueryObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

-(void)findRecentDates{
    
    
    if ([self.timeString  isEqualToString:@"One Week"]) {
        
        //stuff
        NSDate *now  = [NSDate date];
        now = [now dateByAddingTimeInterval:-7.0*24*3600];
        self.longestDate = now;
        
        
    }
    else if ([self.timeString  isEqualToString:@"One Month"]) {
        NSDate *now  = [NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setMonth:-1];
        self.longestDate = [gregorian dateByAddingComponents:offsetComponents toDate:now options:0];
        
    }
    else if ([self.timeString  isEqualToString:@"One Year"]) {
        //stuff
        NSDate *now  = [NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setYear:-1];
        self.longestDate = [gregorian dateByAddingComponents:offsetComponents toDate:now options:0];
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"this many items. %lu", (unsigned long)self.tastingObjectsArray.count);
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredArray count];
    } else {
        return [self.tastingObjectsArray count];
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    self.currentTastingObject = [self.tastingObjectsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"touringToFinalEdit" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"touringToFinalEdit"] ){
        
        
         FinalEditViewController *vc = [segue destinationViewController];
        
        PFFile *theImage = [self.currentTastingObject objectForKey:@"leftImage"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        PFFile *theImage2 = [self.currentTastingObject objectForKey:@"leftImage"];
        NSData *imageData2 = [theImage2 getData];
        UIImage *image2 = [UIImage imageWithData:imageData2];
        vc.textString = self.currentTastingObject[@"noteString"];
        vc.rightImageImage = image;
        vc.leftImageImage = image2;
        vc.currentTastingObject = self.currentTastingObject;
        vc.classString = self.currentTastingObject[@"classString"];
        vc.typeString = self.currentTastingObject[@"typeString"];
        vc.wineryString = self.currentTastingObject[@"wineryString"];
        vc.checkInt = 1;
        vc.fromWhichView = 2;
        
        
        
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    PFObject *tastingObject = [PFObject objectWithClassName:@"WDTouring"];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tastingObject = [self.filteredArray objectAtIndex:indexPath.row];
    } else {
        tastingObject = [self.tastingObjectsArray objectAtIndex:indexPath.row];
    }
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        NSString *myString = tastingObject[@"eventName"];
        myString = [myString stringByAppendingString:@" - "];
        NSDate* date = tastingObject[@"myDate"];
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterMediumStyle];
        NSString* myString2 = [df stringFromDate:date];
        myString = [myString stringByAppendingString:myString2];
        cell.textLabel.text = myString;
        //Get left picture (front of bottle) to the picture view
        
        PFFile *theImage = [tastingObject objectForKey:@"leftImage"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.backgroundColor = [UIColor clearColor];
        cell.imageView.image = image;
        
        NSString  *myDetailString = tastingObject[@"wineryString"];
        myDetailString = [myDetailString stringByAppendingString:@", "];
        
        myDetailString = [myDetailString stringByAppendingString:tastingObject[@"typeString"]];
        
        myDetailString = [myDetailString stringByAppendingString:@", "];
        
        NSString *newClassString = tastingObject[@"classString"];
        
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
        
        myDetailString = [myDetailString stringByAppendingString:newClassString];
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.text = myDetailString;
        
    }
    
    
    
    
    
    
    
    
    return cell;
    
}

-(void)findQueryObjects{
    PFQuery *query = [PFQuery queryWithClassName:@"WDTouring"];
    PFUser *currentUser = [PFUser currentUser];
    //[query fromLocalDatastore];
    [query whereKey:@"userName" equalTo:currentUser.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [self.tastingObjectsArray addObject:object];
                //[object deleteInBackground];
                
            }
            //[PFObject pinAllInBackground:self.tastingObjectsArray];
            //[PFObject deleteAll:self.tastingObjectsArray];
            
            self.filteredArray = [NSMutableArray arrayWithCapacity:[self.tastingObjectsArray count]];
            NSMutableArray *newFilteredArray = [NSMutableArray arrayWithCapacity:[self.tastingObjectsArray count]];
            NSDate *test = self.longestDate;
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((myDate >= %@) OR (%@ == %@) OR (%@ ==%@))",self.longestDate, self.timeString, @"", self.timeString, @"All Touring Notes"];
            newFilteredArray = [NSMutableArray arrayWithArray:[self.tastingObjectsArray filteredArrayUsingPredicate:predicate]];
            self.tastingObjectsArray = newFilteredArray;
            
            
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"myDate"
                                                         ascending:NO];
            NSArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
            self.tastingObjectsArray  = [self.tastingObjectsArray sortedArrayUsingDescriptors:sortDescriptors];
            [self.tableview reloadData];
            NSLog(@"this many items. %lu", (unsigned long)self.tastingObjectsArray.count);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}



@end
