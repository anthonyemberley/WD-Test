//
//  WineTasting.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 12/19/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineTasting : NSObject{
    NSString *classs;
    NSString *type;
    NSString *winery;
    NSString *vintage;
    NSString *when;
    NSString *color;
    NSString *aromas;
    NSString *mouthfeel;
    NSString *finish;
    NSString *evaluation;
    
    
}

@property (nonatomic, copy) NSString *classs;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *winery;
@property (nonatomic, copy) NSString *vintage;
@property (nonatomic, copy) NSString *when;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *aromas;
@property (nonatomic, copy) NSString *mouthfeel;
@property (nonatomic, copy) NSString *finish;
@property (nonatomic, copy) NSString *evaluation;


+ (id)tastingOfClass:(NSString*)classs type:(NSString*)type winery:(NSString*)winery vintage:(NSString*)vintage when:(NSString*)when color:(NSString*)color aromas:(NSString*)aromas mouthfeel:(NSString*)mouthfeel finish:(NSString*)finish evaluation:(NSString*)evaluation;

@end
