//
//  AccessoriesWordsView.m
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "AccessoriesServiceView.h"

#import "AccessoriesCommon.h"
#import "AccessoriesExpandableCell.h"

@interface AccessoriesServiceView()

@property (nonatomic, strong) NSMutableDictionary *cellHeights;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) UITableView *tableView;

@end


@implementation AccessoriesServiceView

+ (void)initialize {
    [super initialize];
    
    [self sections];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _cellHeights = [[NSMutableDictionary alloc] init];
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [_tableView setBackgroundColor:[UIColor colorWithRed:(241/255.0f) green:(241/255.0f) blue:(244/255.0f) alpha:1]];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView registerClass:[AccessoriesExpandableCell class] forCellReuseIdentifier:@"AccessoriesWordsCell"];
        
        [self addSubview:_tableView];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[self class] sections] count];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccessoriesExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoriesWordsCell" forIndexPath:indexPath];
    if(!cell.initialized) {
        [cell initializeWithDefaultHeight:50];
    }
    
    [cell setAttributedTitle:[[[[[self class] sections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1] objectAtIndex:0]];
    [cell setAttributedDetails:[[[[[self class] sections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1] objectAtIndex:1]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView viewForHeaderInSection:section].frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *indexPathKey = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    if([self.selectedIndexPath isEqual:indexPath] && [self.cellHeights objectForKey:indexPathKey]) {
        return [[self.cellHeights objectForKey:indexPathKey] floatValue];
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[[self class] sections] objectAtIndex:section] count]-1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    [header setBackgroundColor:[UIColor colorWithRed:(241/255.0f) green:(241/255.0f) blue:(244/255.0f) alpha:1]];
    UILabel *headerLabel = [[UILabel alloc] init];
    [headerLabel setFont:[UIFont systemFontOfSize:20]];
    [headerLabel setNumberOfLines:0];
    [headerLabel setText:[[[[self class] sections] objectAtIndex:section] objectAtIndex:0]];
    [headerLabel setTextColor:[UIColor colorWithRed:(117/255.0f) green:(117/255.0f) blue:(123/255.0f) alpha:1]];
    [header addSubview:headerLabel];
    UIView *headerDivider = [[UIView alloc] initWithFrame:CGRectMake(0, header.frame.size.height-1, header.frame.size.width, 1)];
    [headerDivider setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
    [headerDivider setBackgroundColor:[UIColor colorWithWhite:0.85 alpha:1]];
    [header addSubview:headerDivider];
    if(section!=0) {
        UIView *topDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, header.frame.size.width, 1)];
        [topDivider setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [topDivider setBackgroundColor:[UIColor colorWithWhite:0.85 alpha:1]];
        [header addSubview:topDivider];
    }
    
    CGSize headerLabelSize = [AccessoriesCommon text:headerLabel.text sizeWithFont:headerLabel.font constrainedToWidth:self.tableView.bounds.size.width-20];
    [headerLabel setFrame:CGRectMake(10, 12, self.tableView.bounds.size.width-20, headerLabelSize.height)];
    [header setFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, headerLabelSize.height+24)];
    
    return header;
}

+ (NSArray *)sections {
    static NSArray *sections;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *mutableSections = [[NSMutableArray alloc] init];
        NSString *rawData = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataService" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        NSArray *allSections = [rawData componentsSeparatedByString:@"\n\n\n"];
        for(NSString *section in allSections) {
            NSArray *sectionComponents = [section componentsSeparatedByString:@"\n\n"];
            NSMutableArray *sectionContents = [[NSMutableArray alloc] init];
            for(int i=0;i<sectionComponents.count;i++) {
                NSString *sectionComponent = [sectionComponents objectAtIndex:i];
                if(i==0) {
                    [sectionContents addObject:sectionComponent];
                }
                else {
                    NSMutableArray *components = [[sectionComponent componentsSeparatedByString:@"\n"] mutableCopy];
                    for(int j=0;j<components.count;j++) {
                        [components replaceObjectAtIndex:j withObject:[[components objectAtIndex:j] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                        if([[components objectAtIndex:j] isEqualToString:@""]) {
                            [components removeObjectAtIndex:j];
                            j--;
                        }
                    }
                    if(components.count==2) {
                        [sectionContents addObject:@[[AccessoriesCommon attributedStringFromHTMLString:[NSString stringWithFormat:@"<b>%@</b>",[components objectAtIndex:0]] withFontSize:18],[AccessoriesCommon attributedStringFromHTMLString:[components objectAtIndex:1] withFontSize:16]]];
                    }
                }
            }
            [mutableSections addObject:sectionContents];
        }
        sections = mutableSections;
    });
    return sections;
}

@end
