//
//  AccessoriesWordsView.m
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "AccessoriesWordsView.h"

#import "AccessoriesCommon.h"
#import "AccessoriesExpandableCell.h"

@interface AccessoriesWordsView()

@property (nonatomic, strong) NSMutableDictionary *cellHeights;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic) CGFloat selectedIndexPathHeight;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableViewHeader;
@property (nonatomic, strong) UILabel *tableViewHeaderLabel;

@end


@implementation AccessoriesWordsView

+ (void)initialize {
    [super initialize];
    
    [self words];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _cellHeights = [[NSMutableDictionary alloc] init];
        
        NSAttributedString *headerLabel = [[NSAttributedString alloc] initWithString:@"Definitions of words frequently used by the wine trade." attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
        
        _tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_tableViewHeader setBackgroundColor:[UIColor colorWithRed:(241/255.0f) green:(241/255.0f) blue:(244/255.0f) alpha:1]];
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

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccessoriesExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoriesWordsCell" forIndexPath:indexPath];
    if(!cell.initialized) {
        [cell initializeWithDefaultHeight:50];
    }
    
    [cell setAttributedTitle:[[[[self class] words] objectAtIndex:indexPath.row] objectAtIndex:0]];
    [cell setAttributedDetails:[[[[self class] words] objectAtIndex:indexPath.row] objectAtIndex:1]];
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self class] words].count;
}

+ (NSArray *)words {
    static NSArray *words;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableArray *mutableWords = [[NSMutableArray alloc] init];
        NSString *rawData = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataWords" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        NSArray *allWords = [rawData componentsSeparatedByString:@"\n\n"];
        for(NSString *word in allWords) {
            NSMutableArray *components = [[word componentsSeparatedByString:@"\n"] mutableCopy];
            for(int i=0;i<components.count;i++) {
                [components replaceObjectAtIndex:i withObject:[[components objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                if([[components objectAtIndex:i] isEqualToString:@""]) {
                    [components removeObjectAtIndex:i];
                    i--;
                }
            }
            if(components.count==2) {
                [mutableWords addObject:@[[AccessoriesCommon attributedStringFromHTMLString:[components objectAtIndex:0] withFontSize:18],[AccessoriesCommon attributedStringFromHTMLString:[components objectAtIndex:1] withFontSize:16]]];
            }
        }
        words = mutableWords;
    });
    return words;
}

@end
