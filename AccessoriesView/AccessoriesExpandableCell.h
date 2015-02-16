//
//  AccessoriesExpandableCell.h
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/8/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccessoriesExpandableCell : UITableViewCell

@property (nonatomic) BOOL initialized;

- (void)initializeWithDefaultHeight:(CGFloat)defaultHeight;
- (CGFloat)internalHeight;
- (void)setAttributedDetails:(NSAttributedString *)details;
- (void)setAttributedSubtitle:(NSAttributedString *)subtitle;
- (void)setAttributedTitle:(NSAttributedString *)title;
- (void)setIconImage:(UIImage *)iconImage;

@end
