//
//  recentCellaringViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/2/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "recentCellaringViewController.h"
#import "cellaringFinalEditViewController.h"
#import "Parse/Parse.h"

@interface recentCellaringViewController ()
@property(strong, nonatomic) NSMutableArray *tastingObjectsArray;
@property PFObject *currentTastingObject;
@property NSDate *longestDate;

@end

@implementation recentCellaringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    
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
    [self performSegueWithIdentifier:@"cellaringNotesToFinalEditSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"cellaringNotesToFinalEditSegue"] ){
        
        
        cellaringFinalEditViewController *vc = [segue destinationViewController];
        
        PFFile *theImage = [self.currentTastingObject objectForKey:@"leftImage"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        PFFile *theImage2 = [self.currentTastingObject objectForKey:@"leftImage"];
        NSData *imageData2 = [theImage2 getData];
        UIImage *image2 = [UIImage imageWithData:imageData2];
        vc.textString = self.currentTastingObject[@"noteString"];
        vc.rightImageImage = image;
        vc.leftImageImage = image2;
        vc.classString = self.currentTastingObject[@"classString"];
        vc.typeString = self.currentTastingObject[@"typeString"];
        vc.wineryString = self.currentTastingObject[@"wineryString"];
        vc.checkInt = 1;
        
        vc.evaluationIntString = self.currentTastingObject[@"evaluation"];
        vc.currentTastingObject = self.currentTastingObject;
        
        
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    PFObject *tastingObject = [PFObject objectWithClassName:@"WDCellaring"];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        tastingObject = [self.filteredArray objectAtIndex:indexPath.row];
    } else {
        tastingObject = [self.tastingObjectsArray objectAtIndex:indexPath.row];
    }
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        NSString *titleString = tastingObject[@"wineryString"];
        titleString = [titleString stringByAppendingString:@", "];
        titleString = [titleString stringByAppendingString:tastingObject[@"typeString"]];
        titleString = [titleString stringByAppendingString:@", "];
        titleString = [titleString stringByAppendingString:tastingObject[@"classString"]];
        
        
        //titleString = [titleString stringByAppendingString:tastingObject[@"myDate"]];
        
        cell.textLabel.text = titleString;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        
        cell.detailTextLabel.text = tastingObject[@"evaluationString"];
        //Get left picture (front of bottle) to the picture view
        
        PFFile *theImage = [tastingObject objectForKey:@"leftImage"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.backgroundColor = [UIColor clearColor];
        cell.imageView.image = image;
        
    }
//    NSDate* date = tastingObject.updatedAt;
//    NSDateFormatter* df = [[NSDateFormatter alloc] init];
//    [df setDateStyle:NSDateFormatterMediumStyle];
//    [df setTimeStyle:NSDateFormatterShortStyle];
//    NSString* myString = [df stringFromDate:date];
//    
//    cell.detailTextLabel.text = myString;
    
    
    
    
    
    
    return cell;
    
}

-(void)findQueryObjects{
    PFQuery *query = [PFQuery queryWithClassName:@"WDCellaring"];
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
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((classString contains[c] %@) OR (%@ == %@)) AND ((typeString contains[c] %@) OR (%@ == %@)) AND ((wineryString contains[c] %@) OR (%@ == %@)) AND ((evaluation == %@) OR (%@ == %@) OR (%@ ==%@))",self.classString, self.classString, @"", self.typeString, self.typeString, @"", self.wineryString, self.wineryString, @"", self.evaluationString, self.evaluationString, @"All", self.evaluationString, @""];
            newFilteredArray = [NSMutableArray arrayWithArray:[self.tastingObjectsArray filteredArrayUsingPredicate:predicate]];
            self.tastingObjectsArray = newFilteredArray;
            
            
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"wineryString"
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
