//
//  AccessoriesView.m
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "AccessoriesView.h"

#import "AccessoriesServiceView.h"
#import "AccessoriesTypesView.h"
#import "AccessoriesWordsView.h"

@interface AccessoriesView()

@property (nonatomic, strong) NSArray *pages;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end


@implementation AccessoriesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Words", @"Types", @"Service"]];
        [_segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
        [_segmentedControl setSelectedSegmentIndex:0];
        [_segmentedControl setTintColor:[UIColor whiteColor]];
        
        _pages = @[[AccessoriesWordsView new], [AccessoriesTypesView new], [AccessoriesServiceView new]];
        for(int i=0;i<_pages.count;i++) {
            UIView *page = [_pages objectAtIndex:i];
            [page setHidden:i!=0];
            [self addSubview:page];
        }
        
        [self setBackgroundColor:[UIColor colorWithRed:233/255.0 green:0 blue:18/255.0 alpha:1]];
        [self addSubview:_segmentedControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.segmentedControl setFrame:CGRectMake(20, 3, self.bounds.size.width-40, 29)];
    CGRect pageFrame = CGRectMake(0, 35, self.bounds.size.width, self.bounds.size.height-35);
    for(UIView *page in self.pages) {
        [page setFrame:pageFrame];
    }
}

- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl {
    for(int i=0;i<_pages.count;i++) {
        [[_pages objectAtIndex:i] setHidden:i!=segmentedControl.selectedSegmentIndex];
    }
}

@end
