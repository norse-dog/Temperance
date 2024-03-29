//
//  NDAppDelegate.h
//  Temperance
//
//  Created by Norse Dog on 5/30/12.
//  Copyright (c) 2012 Folkwang Enterprises. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NDCommand.h"

@interface NDAppDelegate : NSObject <NSApplicationDelegate>

// UX elements for this app
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *cmdText;
@property (assign) IBOutlet NSTextView *logView;
@property (assign) IBOutlet NSTextView *systemView;
@property (assign) IBOutlet NSTabView *tabView;

// Autogenerated members
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// State
@property (readonly, strong, nonatomic) NDCommanding *commanding;

// Singleton
+(NDAppDelegate*)instance;

// Methods
- (void)log:(NSString*)msg withHeader:(NSString*)header;
- (void)log:(NSString*)msg file:(char*)file line:(int)line method:(char*)method;

// Actions
- (IBAction)saveAction:(id)sender;
- (IBAction)executeCmdAction:(id)sender;

@end
