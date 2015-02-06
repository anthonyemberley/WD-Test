//
//  recentNotesViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/2/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "recentNotesViewController.h"
#import "Parse/Parse.h"
#import "FinalEditViewController.h"

@interface recentNotesViewController ()
@property(strong, nonatomic) NSMutableArray *tastingObjectsArray;
@property PFObject *currentTastingObject;
@property NSDate *longestDate;


@end

@implementation recentNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findRecentDates];
    
    self.tableview.tableHeaderView = self.searchBar;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tastingObjectsArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    
    [self findQueryObjects];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGPoint contentOffset = self.tableview.contentOffset;
    contentOffset.y += CGRectGetHeight(self.searchBar.frame);
    self.tableview.contentOffset = contentOffset;
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
    else if ([self.timeString  isEqualToString:@"6 Months"]) {
        //stuff
        NSDate *now  = [NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setMonth:-6];
        self.longestDate = [gregorian dateByAddingComponents:offsetComponents toDate:now options:0];
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath


{
    
    self.currentTastingObject = [self.tastingObjectsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"recentNotesToFinalEditSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"recentNotesToFinalEditSegue"] ){
        
    
        FinalEditViewController *vc = [segue destinationViewController];
        
        PFFile *theImage = [self.currentTastingObject objectForKey:@"leftImage"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        PFFile *theImage2 = [self.currentTastingObject objectForKey:@"leftImage"];
        NSData *imageData2 = [theImage2 getData];
        UIImage *image2 = [UIImage imageWithData:imageData2];
        vc.textString = self.currentTastingObject[@"noteString"];
        vc.currentTastingObject = self.currentTastingObject;
        vc.rightImageImage = image;
        vc.fromWhichView = 1;
        vc.leftImageImage = image2;
        vc.classString = self.currentTastingObject[@"classString"];
        vc.typeString = self.currentTastingObject[@"typeString"];
        vc.wineryString = self.currentTastingObject[@"wineryString"];
        vc.checkInt = 1;
        
        
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    PFObject *tastingObject = [PFObject objectWithClassName:@"WDTasting"];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tastingObject = [self.filteredArray objectAtIndex:indexPath.row];
    } else {
        tastingObject = [self.tastingObjectsArray objectAtIndex:indexPath.row];
    }
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];\
        
        NSString *titleString = tastingObject[@"wineryString"];
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
        
        
        titleString = [titleString stringByAppendingString:@", "];
        titleString = [titleString stringByAppendingString:tastingObject[@"typeString"]];
        titleString = [titleString stringByAppendingString:@", "];
        titleString = [titleString stringByAppendingString:newClassString];
        cell.textLabel.text = titleString;
        
        //Get left picture (front of bottle) to the picture view
        
        PFFile *theImage = [tastingObject objectForKey:@"leftImage"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.backgroundColor = [UIColor clearColor];
        cell.imageView.image = image;
        
    }
    NSDate* date = tastingObject.updatedAt;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    
    NSString* detailString = [df stringFromDate:date];
    cell.detailTextLabel.text = detailString;
    
    
    
    
    
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"this many items. %lu", (unsigned long)self.tastingObjectsArray.count);
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredArray count];
    } else {
        return [self.tastingObjectsArray count];
    }
    
}
-(void)findQueryObjects{
    PFQuery *query = [PFQuery queryWithClassName:@"WDTasting"];
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
//                [object deleteInBackground];
                
            }
            //[PFObject pinAllInBackground:self.tastingObjectsArray];
            
            self.filteredArray = [NSMutableArray arrayWithCapacity:[self.tastingObjectsArray count]];
            NSMutableArray *newFilteredArray = [NSMutableArray arrayWithCapacity:[self.tastingObjectsArray count]];
            NSComparisonResult comparison = [[NSDate date] compare:self.longestDate];
            NSLog(@"here is the comparison %ld", comparison);
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((classString contains[c] %@) OR (%@ == %@)) AND ((typeString contains[c] %@) OR (%@ == %@)) AND ((wineryString contains[c] %@) OR (%@ == %@)) AND ((myDate >= %@) OR (%@ == %@) OR (%@ ==%@))",self.classString, self.classString, @"", self.typeString, self.typeString, @"", self.wineryString, self.wineryString, @"", self.longestDate, self.timeString, @"All Notes", self.timeString, @""];
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

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"noteString contains[c] %@",searchText];
    _filteredArray = [NSMutableArray arrayWithArray:[self.tastingObjectsArray filteredArrayUsingPredicate:predicate]];
}
#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
