//
//  AccessoriesWordsView.m
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "AccessoriesTypesView.h"

#import "AccessoriesCommon.h"
#import "AccessoriesExpandableCell.h"
#import "AppDelegate.h"

@interface AccessoriesTypesView()

@property (nonatomic, strong) NSMutableDictionary *cellHeights;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableViewHeader;
@property (nonatomic, strong) UILabel *tableViewHeaderLabel;

@end


@implementation AccessoriesTypesView

+ (void)initialize {
    [super initialize];
    
    [self types];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _cellHeights = [[NSMutableDictionary alloc] init];
        
        NSMutableAttributedString *headerLabel = [[NSMutableAttributedString alloc] initWithString:@"In recent decades International wine marketing has changed.\n\nTap for more information.\n\nTap the name of the wine or appellation name for additional information." attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
        [headerLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:4] range:NSMakeRange(60, 1)];
        [headerLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(61, 25)];
        [headerLabel addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange(61, 25)];
        
        _tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_tableViewHeader setBackgroundColor:[UIColor colorWithRed:(241/255.0f) green:(241/255.0f) blue:(244/255.0f) alpha:1]];
        UITapGestureRecognizer *headerTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapped)];
        [_tableViewHeader addGestureRecognizer:headerTapped];
        _tableViewHeaderLabel = [[UILabel alloc] init];
        [_tableViewHeaderLabel setAttributedText:headerLabel];
        [_tableViewHeaderLabel setNumberOfLines:0];
        [_tableViewHeaderLabel setTextColor:[UIColor colorWithRed:(117/255.0f) green:(117/255.0f) blue:(123/255.0f) alpha:1]];
        [_tableViewHeader addSubview:_tableViewHeaderLabel];
        UIView *headerDivider = [[UIView alloc] initWithFrame:CGRectMake(0, _tableViewHeader.frame.size.height-1, _tableViewHeader.frame.size.width, 1)];
        [headerDivider setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
        [headerDivider setBackgroundColor:[UIColor colorWithWhite:0.85 alpha:1]];
        [_tableViewHeader addSubview:headerDivider];
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [_tableView setBackgroundColor:_tableViewHeader.backgroundColor];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setTableHeaderView:_tableViewHeader];
        [_tableView registerClass:[AccessoriesExpandableCell class] forCellReuseIdentifier:@"AccessoriesWordsCell"];
        
        [self addSubview:_tableView];
    }
    return self;
}

- (void)headerTapped {
    NSString *alertText = @"A majority of the world’s wines are no longer marketed under the name of an appellation or grape growing district. Instead, they are now widely marketed under the name of the primary grape used in the wine’s production.\n\nIn the WineDefined TYPES INDEX, the names of WINEGRAPES are spelled out in ALL CAPITAL LETTERS. Wines that are specifically marketed under an appellation (i.e. wine producing district — such as Chianti, Bordeaux, Bourgogne or Rioja) or are a traditional type of wine (such as Port or Sherry) are identified in upper and lower case letters.\n\nSYMBOLS: In each case, we indicate through three different glass shapes whether the wine is a table wine, sparkling wine, or an aperitif/dessert wine and then show the expected color (red, rosé, light straw, golden or deep red) of each wine. Touch the name of the entry and you will find additional information regarding (1) the kinds of foods with which the wine is usually served, (2) a sentence or two in bold print that provides a succinct definition of the wine, and (3) further text providing expanded commentary regarding each wine. In some cases, a wine grape is traditionally known in various regions under different names and prominent ‘also-known-as’ (aka) synonyms are also identified. In addition, fairly lengthy descriptions are provided for Sherry, Port and Sparkling Wines.";
    if([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Wine Marketing" message:alertText preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.frame = [[UIScreen mainScreen] applicationFrame];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        id viewController = [self nextResponder];
        while(![viewController isKindOfClass:[UIViewController class]]) {
            viewController = [viewController nextResponder];
        }
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wine Marketing" message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize headerLabelSize = [AccessoriesCommon attributedText:self.tableViewHeaderLabel.attributedText constrainedToWidth:self.tableView.bounds.size.width-20 singleLine:NO];
    [self.tableViewHeaderLabel setFrame:CGRectMake(10, 20, self.tableView.bounds.size.width-20, headerLabelSize.height)];
    [self.tableViewHeader setFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, headerLabelSize.height+40)];
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccessoriesExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoriesWordsCell" forIndexPath:indexPath];
    if(!cell.initialized) {
        [cell initializeWithDefaultHeight:70];
    }
    
    [cell setAttributedTitle:[[[[self class] types] objectAtIndex:indexPath.row] objectAtIndex:1]];
    [cell setAttributedSubtitle:[[[[self class] types] objectAtIndex:indexPath.row] objectAtIndex:2]];
    [cell setAttributedDetails:[[[[self class] types] objectAtIndex:indexPath.row] objectAtIndex:3]];
    [cell setIconImage:[UIImage imageNamed:[NSString stringWithFormat:@"Icon%@",[[[[self class] types] objectAtIndex:indexPath.row] objectAtIndex:0]]]];
    [self.cellHeights setObject:@([cell internalHeight]) forKey:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if([self.selectedIndexPath isEqual:indexPath]) {
        self.selectedIndexPath = nil;
    }
    else {
        self.selectedIndexPath = indexPath;
    }
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *indexPathKey = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    if([self.selectedIndexPath isEqual:indexPath] && [self.cellHeights objectForKey:indexPathKey]) {
        return [[self.cellHeights objectForKey:indexPathKey] floatValue];
    }
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self class] types].count;
}

+ (NSArray *)types {
    static NSArray *types;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *mutableTypes = [[NSMutableArray alloc] init];
        NSString *rawData = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataTypes" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        NSArray *allTypes = [rawData componentsSeparatedByString:@"\n\n"];
        for(NSString *word in allTypes) {
            NSMutableArray *components = [[word componentsSeparatedByString:@"\n"] mutableCopy];
            for(int i=0;i<components.count;i++) {
                [components replaceObjectAtIndex:i withObject:[[components objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                if([[components objectAtIndex:i] isEqualToString:@""]) {
                    [components removeObjectAtIndex:i];
                    i--;
                }
            }
            if(components.count>2) {
                NSMutableString *details = [[NSMutableString alloc] init];
                for(int i=3;i<components.count;i++) {
                    [details appendFormat:@"%@%@",(i==2?@"":@"\n\n"),[components objectAtIndex:i]];
                }
                
                [mutableTypes addObject:@[[components objectAtIndex:0], [AccessoriesCommon attributedStringFromHTMLString:[NSString stringWithFormat:@"<b>%@</b>",[components objectAtIndex:1]] withFontSize:18], [AccessoriesCommon attributedStringFromHTMLString:[components objectAtIndex:2] withFontSize:16], [AccessoriesCommon attributedStringFromHTMLString:details withFontSize:16]]];
            }
        }
        types = mutableTypes;
    });
    return types;
}

@end
