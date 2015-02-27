//
//  AppDelegate.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 10/15/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Core Data
@property (nonatomic, retain, readwrite) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, retain, readwrite) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

- (BOOL)resetDatastore;

@end

