//
//  AccessoriesWordsView.h
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccessoriesCommon : NSObject

+ (NSAttributedString *)attributedStringFromHTMLString:(NSString *)string withFontSize:(CGFloat)size;
+ (CGSize)attributedText:(NSAttributedString *)text constrainedToWidth:(CGFloat)width singleLine:(BOOL)singleLine;
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

@end
