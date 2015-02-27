//
//  AppDelegate.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 10/15/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import <CoreData/CoreData.h>

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;

@synthesize managedObjectModel = _managedObjectModel;

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    
    [Parse setApplicationId:@"kd5ZKHtHwPCiEm4vuDTOhZhpMX4Jlw5ts4MMTsjL"
                  clientKey:@"BcYmVFZDpJKehbX53iNKbG8qmmcUDwpXrnospJwN"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // ...
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[UITabBarItem  appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }
                                              forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:233/255.0 green:0 blue:18/255.0 alpha:1];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    PFUser *currentUser = [PFUser currentUser];
    if (NO) {
        // do stuff with the user
        UIViewController *viewController =  [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
        
        return YES;
        
    } else {
        // show the signup or login screen
        UIViewController *viewController =  [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
        
        return YES;
    }
    
    
    
    
    
    
}

#pragma mark - Core Data
//http://www.codigator.com/tutorials/ios-core-data-tutorial-with-example/

// 1
- (NSManagedObjectContext *) managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

//2
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]stringByAppendingPathComponent: @"ZWLocalDB.sqlite"]];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error])
    {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//Modified from
//http://stackoverflow.com/questions/3266084/how-to-remove-all-objects-from-core-data
- (BOOL)resetDatastore
{
    [[self managedObjectContext] lock];
    [[self managedObjectContext] reset];
    NSPersistentStore *store = [[[self persistentStoreCoordinator] persistentStores] lastObject];
    BOOL resetOk = NO;
    
    if (store)
    {
        NSURL *storeUrl = store.URL;
        NSError *error;
        
        if ([[self persistentStoreCoordinator] removePersistentStore:store error:&error])
        {
            _persistentStoreCoordinator = nil;
            
            _managedObjectContext = nil;
            
            if (![[NSFileManager defaultManager] removeItemAtPath:storeUrl.path error:&error])
            {
                NSLog(@"\nresetDatastore. Error removing file of persistent store: %@",
                      [error localizedDescription]);
                resetOk = NO;
            }
            else
            {
                //now recreate persistent store
                [self persistentStoreCoordinator];
                [[self managedObjectContext] unlock];
                resetOk = YES;
            }
        }
        else
        {
            NSLog(@"\nresetDatastore. Error removing persistent store: %@",
                  [error localizedDescription]);
            resetOk = NO;
        }
        return resetOk;
    }
    else
    {
        NSLog(@"\nresetDatastore. Could not find the persistent store");
        return resetOk;
    }
}

@end
