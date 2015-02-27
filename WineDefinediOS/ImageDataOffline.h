//
//  ImageDataOffline.h
//  WineDefinediOS
//
//  Created by Kai Aichholz on 2/27/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageDataOffline : NSManagedObject

@property (nonatomic, retain) NSData * leftImageIconData;
@property (nonatomic, retain) NSData * rightImageIconData;
@property (nonatomic, retain) NSString * objectId;

@end
