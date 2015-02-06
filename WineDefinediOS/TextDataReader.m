//
//  TextDataReader.m
//  WineDefined
//
//  Created by Bryce Pauken on 1/8/15.
//  Copyright (c) 2015 Bryce Pauken. All rights reserved.
//

#import "TextDataReader.h"

@implementation TextDataReader


#pragma mark - Public Methods

+ (NSArray *)types {
    static NSArray *types;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //read Types.txt into a variable
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Types" ofType:@"txt"]];
        if(data) {
            //get the data into a string and replace html entities
            NSString *rawString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            rawString = [self removeHTMLEntitiesInString:rawString];
            if(rawString) {
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                
                //get array of types (sections separated by at least two newlines)
                NSArray *sections = [rawString componentsSeparatedByString:@"\n\n"];
                for(NSString *section in sections) {
                    //get each piece of the section (separated by a newline)
                    NSMutableArray *piecesArray = [[section componentsSeparatedByString:@"\n"] mutableCopy];
                    for(int i=0;i<piecesArray.count;i++) {
                        //remove whitespace from edges of string
                        [piecesArray replaceObjectAtIndex:i withObject:[[piecesArray objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                        //if piece is now an empty string (i.e., was only whitespace before), remove it
                        if([[piecesArray objectAtIndex:i] isEqualToString:@""]) {
                            [piecesArray removeObjectAtIndex:i];
                            i--;
                        }
                    }
                    if(piecesArray.count >= 3) {
                        [tempArray addObject:[[NSArray alloc] initWithArray:piecesArray]];
                    }
                }
                
                //sort the temporary array and set it to our main types array
                types = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                    return [[[[((NSArray*)a) objectAtIndex:1] stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]] lowercaseString] compare:[[[((NSArray*)b) objectAtIndex:1] stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]] lowercaseString]];
                }];
            }
        }
    });
    
    return types;
}


+ (NSArray *)words {
    static NSArray *words;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //read Words.txt into a variable
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Words" ofType:@"txt"]];
        if(data) {
            //get the data into a string and replace html entities
            NSString *rawString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            rawString = [self removeHTMLEntitiesInString:rawString];
            if(rawString) {
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                
                //create an array with elements for each line, with empty lines removed
                NSArray *lines = [[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] componentsSeparatedByString:@"\n"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
                //add every two lines together to our return array
                for(int i=0;i<lines.count-1;i+=2) {
                    [tempArray addObject:@[[lines objectAtIndex:i], [lines objectAtIndex:i+1]]];
                }
                
                words = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                    return [[[[((NSArray*)a) objectAtIndex:0] stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]] lowercaseString] compare:[[[((NSArray*)b) objectAtIndex:0] stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]] lowercaseString]];
                }];
            }
        }
    });
    
    return words;
}





/* ********** ********** ********** ********** ********** */

#pragma mark - Private Methods

/*
    This method returns a string with html entities removed (e.g., &amp -> &).
    If the data file is changed and an uknown entity is found, it'll throw an exception, and you
    can add it to the dictionary near the beginning of the method.
 
    Otherwise, probably best to just leave it alone.
 */
+ (NSString *)removeHTMLEntitiesInString:(NSString *)string {
    //dictionary containing the actual symbols for html entities
    static NSDictionary *knownEntities;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        knownEntities = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"&",@"'",@"\"",@"<",@">",@"'",@"é",@"ë",@"è",@"ô",@"á",@"â",@"É",@"Ñ",@"í",@"è",@"“",@"”",@"Ä",@"ü",@"‘",@"’",@"—",@"Ç",@"î",@"ñ",@"Â",@"ä",@"È",@"Ü",nil] forKeys:[NSArray arrayWithObjects:@"&amp;",@"&apos;",@"&quot;",@"&lt;",@"&gt;",@"&rsquo;",@"&eacute;",@"&euml;",@"&egrave;",@"&ocirc;",@"&aacute;",@"&acirc;",@"&Eacute;",@"&Ntilde;",@"&iacute;",@"&eagrave",@"&ldquo;",@"&rdquo;",@"&Auml;",@"&uuml;",@"&lsquo;",@"&rsquo;",@"&mdash;",@"&ccedil;",@"&icirc;",@"&ntilde;",@"&Acirc;",@"&auml;",@"&Egrave;",@"&Uuml;",nil]];
    });
    
    if(!string) {
        return nil;
    }
    NSUInteger stringLength = [string length];
    NSUInteger ampIndex = [string rangeOfString:@"&" options:NSLiteralSearch].location;
    //no ampersand in string, nothing to decode; just return original
    if(ampIndex == NSNotFound) {
        return string;
    }
    NSMutableString *result = [NSMutableString stringWithCapacity:(stringLength * 1.25)];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCaseSensitive:YES];
    [scanner setCharactersToBeSkipped:nil];
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    //start scanning!
    do {
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];}
        if ([scanner isAtEnd]) {
            break;}
        bool entityFound = false;
        for(NSString *entity in knownEntities) {
            if ([scanner scanString:entity intoString:NULL]||([entity isEqualToString:[entity capitalizedString]]&&[scanner scanString:[entity uppercaseString] intoString:NULL])) {
                [result appendString:[knownEntities objectForKey:entity]];
                entityFound = true;
                break;
            }
        }
        if(!entityFound) {
            if ([scanner scanString:@"&#" intoString:NULL]) {
                BOOL gotNumber; unsigned charCode; NSString *xForHex = @"";
                if ([scanner scanString:@"x" intoString:&xForHex]) {
                    gotNumber = [scanner scanHexInt:&charCode];}
                else {
                    gotNumber = [scanner scanInt:(int*)&charCode];}
                if (gotNumber) {
                    unsigned short newChar = charCode;
                    [result appendFormat:@"%C", newChar];
                    [scanner scanString:@";" intoString:NULL];}
                else {
                    NSString *unknownEntity = @"";
                    [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                    [result appendFormat:@"&#%@%@", xForHex, unknownEntity];}}
            else {
                NSString *entity;
                if([scanner scanUpToString:@";" intoString:&entity]) {
                    //if the entity isn't in our `knownEntities` list
                    if([entity length]<=32) {
                        NSException *entityException = [NSException exceptionWithName:@"UnknownEntity" reason:[NSString stringWithFormat:@"The HTML entity \"%@;\" is not known. Add it to knownEntities in the removeHTMLEntitiesInString method.",entity] userInfo:nil];
                        @throw entityException;
                    }
                    else
                        [result appendString:entity];
                }
                else {
                    NSString *amp;
                    [scanner scanString:@"&" intoString:&amp];
                    if(amp!=nil)
                        [result appendString:amp];
                }
            }
        }
    }
    while (![scanner isAtEnd]);
    return [result stringByReplacingOccurrencesOfString:@"â" withString:@"'"];
}

@end
