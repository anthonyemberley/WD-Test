//
//  recentNotesViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/2/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recentNotesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property (strong, nonatomic) NSString *classString;
@property (strong, nonatomic) NSString *typeString;
@property (strong, nonatomic) NSString *wineryString;
@property (strong, nonatomic) NSString *timeString;

@end
