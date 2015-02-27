//
//  AccessoriesWordsView.m
//  WineDefinediOS
//
//  Created by Bryce Pauken on 2/7/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import "AccessoriesCommon.h"

@implementation AccessoriesCommon

+ (NSAttributedString *)attributedStringFromHTMLString:(NSString *)string withFontSize:(CGFloat)size {
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"<br.*?>" options:0 error:NULL];
    string = [regEx stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    NSMutableAttributedString *returnText = [[NSMutableAttributedString alloc] initWithString:string];
    [returnText beginEditing];
    [returnText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, returnText.length)];
    [returnText endEditing];
    
    NSArray *tags = @[@[@"b", [UIFont boldSystemFontOfSize:size]], @[@"i", [UIFont italicSystemFontOfSize:size]]];
    for(int i=0; i<tags.count; i++) {
        while(true) {
            NSString *plainString = returnText.string;
            NSString *tag = [[tags objectAtIndex:i] objectAtIndex:0];
            NSString *fontName = [[tags objectAtIndex:i] objectAtIndex:1];
            NSString *openTag = [NSString stringWithFormat:@"<%@>", tag];
            NSString *closeTag = [NSString stringWithFormat:@"</%@>", tag];
            
            NSRange openTagRange = [plainString rangeOfString:openTag];
            if(openTagRange.location==NSNotFound) {
                break;
            }
            
            NSRange searchRange;
            searchRange.location = openTagRange.location+openTagRange.length;
            searchRange.length = plainString.length-searchRange.location;
            NSRange closeTagRange = [plainString rangeOfString:closeTag options:0 range:searchRange];
            
            if(closeTagRange.location==NSNotFound) {
                break;
            }
            
            NSRange effectedRange;
            effectedRange.location = openTagRange.location+openTagRange.length;
            effectedRange.length = closeTagRange.location - effectedRange.location;
            
            [returnText beginEditing];
            [returnText addAttribute:NSFontAttributeName value:fontName range:effectedRange];
            [returnText deleteCharactersInRange:closeTagRange];
            [returnText deleteCharactersInRange:openTagRange];
            [returnText endEditing];
        }
    }
    
    return returnText;
}

+ (CGSize)attributedText:(NSAttributedString *)text constrainedToWidth:(CGFloat)width singleLine:(BOOL)singleLine {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, singleLine?0.0:CGFLOAT_MAX) options:((singleLine?NSStringDrawingTruncatesLastVisibleLine:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)) context:nil];
    return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}

+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}

@end
