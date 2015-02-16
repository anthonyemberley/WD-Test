//
//  AccessoriesExpandableCell.m
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/8/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "AccessoriesExpandableCell.h"

#import "AccessoriesCommon.h"

@interface AccessoriesExpandableCell()

@property (nonatomic) CGFloat defaultHeight;
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleLabelExpanded;

@end


@implementation AccessoriesExpandableCell

- (void)initializeWithDefaultHeight:(CGFloat)defaultHeight {
    _initialized = YES;
    
    _defaultHeight = defaultHeight;
    
    _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [_selectedView setAlpha:0];
    [_selectedView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [_selectedView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:0 blue:18/255.0 alpha:1]];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabelExpanded = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabelExpanded setAlpha:0];
    [_titleLabelExpanded setNumberOfLines:0];
    _detailsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_detailsLabel setAlpha:0];
    [_detailsLabel setNumberOfLines:0];
    
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self setClipsToBounds:YES];
    [self setOpaque:YES];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self addSubview:_selectedView];
    [self addSubview:_icon];
    [self addSubview:_detailsLabel];
    [self addSubview:_subtitleLabel];
    [self addSubview:_titleLabel];
    [self addSubview:_titleLabelExpanded];
}

- (CGFloat)internalHeight {
    [self layoutSubviews];
    return self.detailsLabel.frame.origin.y+self.detailsLabel.frame.size.height+12;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    static CGFloat iconSize = 44;
    CGFloat iconOffset = self.icon.image?iconSize+16:0;
    BOOL subtitle = self.subtitleLabel.attributedText.length;
    
    CGSize titleSize = [AccessoriesCommon attributedText:self.titleLabelExpanded.attributedText constrainedToWidth:self.bounds.size.width-32-iconOffset singleLine:YES];
    [self.titleLabel setFrame:CGRectMake(16+iconOffset, (self.defaultHeight-titleSize.height)/2, self.bounds.size.width-32-iconOffset, titleSize.height)];
    CGSize titleExpandedSize = [AccessoriesCommon attributedText:self.titleLabelExpanded.attributedText constrainedToWidth:self.bounds.size.width-32-iconOffset singleLine:subtitle];
    [self.titleLabelExpanded setFrame:CGRectMake(16+iconOffset, self.titleLabel.frame.origin.y, self.bounds.size.width-32-iconOffset, titleExpandedSize.height)];
    if(subtitle) {
        CGSize subtitleSize = [AccessoriesCommon attributedText:self.subtitleLabel.attributedText constrainedToWidth:self.bounds.size.width-32-iconOffset singleLine:YES];
        CGFloat labelMargins = (self.defaultHeight-titleSize.height-subtitleSize.height)/5;
        [self.titleLabel setFrame:CGRectMake(self.titleLabel.frame.origin.x, labelMargins*2, titleSize.width, titleSize.height)];
        [self.subtitleLabel setFrame:CGRectMake(self.titleLabel.frame.origin.x, labelMargins*3+titleSize.height, subtitleSize.width, subtitleSize.height)];
    }
    CGSize detailsSize = [AccessoriesCommon attributedText:self.detailsLabel.attributedText constrainedToWidth:self.bounds.size.width-32-iconOffset singleLine:NO];
    [self.detailsLabel setFrame:CGRectMake(16+iconOffset, self.titleLabelExpanded.frame.origin.y+self.titleLabelExpanded.frame.size.height+(subtitle?-6:12), self.bounds.size.width-32-iconOffset, detailsSize.height)];
    if(self.icon.image) {
        [self.icon setFrame:CGRectMake(16, (self.defaultHeight-iconSize)/2, iconSize, iconSize)];
    }
    
    if(self.bounds.size.height == self.defaultHeight) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.detailsLabel setAlpha:0];
            if(!subtitle) {
                [self.titleLabel setAlpha:1];
                [self.titleLabelExpanded setAlpha:0];
            }
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.detailsLabel setAlpha:1];
            if(!subtitle) {
                [self.titleLabel setAlpha:0];
                [self.titleLabelExpanded setAlpha:1];
            }
        }];
    }
}

- (void)setAttributedDetails:(NSAttributedString *)details {
    [self.detailsLabel setAttributedText:details];
}

- (void)setAttributedSubtitle:(NSAttributedString *)subtitle {
    [self.subtitleLabel setAttributedText:subtitle];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)title {
    [self.titleLabel setAttributedText:title];
    [self.titleLabelExpanded setAttributedText:title];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    [self.selectedView setAlpha:(highlighted?0.2:0)];
}

- (void)setIconImage:(UIImage *)iconImage {
    [self.icon setImage:iconImage];
    [self setNeedsLayout];
}

@end
