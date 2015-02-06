//
//  WineTasting.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/19/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "WineTasting.h"

@implementation WineTasting
@synthesize classs;
@synthesize winery;
@synthesize vintage;
@synthesize when;
@synthesize aromas;
@synthesize mouthfeel;
@synthesize finish;
@synthesize evaluation;
@synthesize type;
@synthesize color;



+ (id)tastingOfClass:(NSString*)classs type:(NSString*)type winery:(NSString*)winery vintage:(NSString*)vintage when:(NSString*)when color:(NSString*)color aromas:(NSString*)aromas mouthfeel:(NSString*)mouthfeel finish:(NSString*)finish evaluation:(NSString*)evaluation
{
    WineTasting *newWineTasting = [[self alloc] init];
    newWineTasting.classs = classs;
    newWineTasting.winery = winery;
    newWineTasting.type = type;
    newWineTasting.vintage = vintage;
    newWineTasting.when = when;
    newWineTasting.aromas = aromas;
    newWineTasting.mouthfeel = mouthfeel;
    newWineTasting.finish = finish;
    newWineTasting.evaluation = evaluation;
    newWineTasting.color = color;
    
    
    
    
    return newWineTasting;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:classs forKey:@"class"];
    [coder encodeObject:winery forKey:@"winery"];
    [coder encodeObject:type forKey:@"type"];
    [coder encodeObject:vintage forKey:@"vintage"];
    [coder encodeObject:when forKey:@"when"];
    [coder encodeObject:aromas forKey:@"aromas"];
    [coder encodeObject:mouthfeel forKey:@"mouthfeel"];
    [coder encodeObject:finish forKey:@"finish"];
    [coder encodeObject:evaluation forKey:@"evaluation"];
    [coder encodeObject:finish forKey:@"finish"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        classs = [coder decodeObjectForKey:@"classs"];
        winery = [coder decodeObjectForKey:@"winery"];
        type = [coder decodeObjectForKey:@"type"];
        vintage = [coder decodeObjectForKey:@"vintage"];
        when = [coder decodeObjectForKey:@"when"];
        aromas = [coder decodeObjectForKey:@"aromas"];
        mouthfeel = [coder decodeObjectForKey:@"mouthfeel"];
        finish = [coder decodeObjectForKey:@"finish"];
        evaluation = [coder decodeObjectForKey:@"evaluation"];
        color = [coder decodeObjectForKey:@"color"];
    }
    return self;
}


@end
