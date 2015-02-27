//
//  UITableViewCellFixed.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 2/11/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "UITableViewCellFixed.h"

@implementation UITableViewCellFixed

- (void) layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x,
                                      4.0,
                                      self.textLabel.frame.size.width,
                                      self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x,
                                            8.0 + self.textLabel.frame.size.height,
                                            self.detailTextLabel.frame.size.width,
                                            self.detailTextLabel.frame.size.height);
}

@end
