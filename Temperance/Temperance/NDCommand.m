//
//  NDCommand.m
//  Temperance
//
//  Created by Norse Dog on 6/2/12.
//  Copyright (c) 2012 Folkwang Enterprises. All rights reserved.
//

#import "NDCommand.h"
#import "NDAppDelegate.h"
#import "Utils.h"

@implementation NDCommanding : NSObject

@synthesize registeredCommands = __registeredCommands;

-(NSDictionary*)getRegisteredCommands
{
    if (__registeredCommands == nil)
    {
        __registeredCommands = 
            [NSDictionary dictionaryWithObjectsAndKeys:
             @"NDLogCommand", @"log",
             @"NDSysCommand", @"sys",
             @"NDSysCommand", @"system",
             @"NDCommandCommand", @"stats",
             nil];
    }
    
    return __registeredCommands;
}

-(BOOL)execute:(NSString*)cmdString
{    
    NSArray *words = [cmdString componentsSeparatedByString: @" "];
    
    if ([words count] < 1)
    {
        NDLog(@"Empty command string");
        return false;
    }
    
    NSString *cmd = [[words objectAtIndex:0] lowercaseString];
    NSDictionary* registeredCommands = [self getRegisteredCommands];
    
    if (registeredCommands == nil)
    {
        NDLog(@"out of memory");
        return false;
    }
    
    NSString *registeredCommand = [registeredCommands objectForKey: cmd];
    
    if (registeredCommand == nil)
    {
        NDLog(@"unknown command %@", cmd);
        return false;
    }
    
    id<NDCommand> cmdObject = [[NSClassFromString(registeredCommand) alloc] init];
    
    BOOL result = [cmdObject execute: words];
    
    return result;    
}

@end // NDCommanding


// Log command
@implementation NDLogCommand : NSObject

-(BOOL)execute:(NSArray*)words
{
    NDLog(@"Log command called: %@", [words componentsJoinedByString:@" "]);
    
    NDAppDelegate *app = [NDAppDelegate instance];
    [app.tabView selectLastTabViewItem:nil];
    [app.window makeFirstResponder:app.cmdText];
    return true;
}

@end


// Sys command
@implementation NDSysCommand : NSObject

-(BOOL)execute:(NSArray*)words
{
    NDLog(@"Sys command called");

    NDAppDelegate *app = [NDAppDelegate instance];
    [app.tabView selectFirstTabViewItem:nil];
    [app.window makeFirstResponder:app.cmdText];
    return true;
}

@end



// Stats command
#include <mach/mach.h>
#include <mach/task.h>

@implementation NDCommandCommand : NSObject

-(BOOL)execute:(NSArray*)words
{
    NDLog(@"Stats command called");

    struct task_basic_info t_info;
    mach_msg_type_number_t t_info_count = TASK_BASIC_INFO_COUNT;

    if (KERN_SUCCESS != task_info(mach_task_self(),
                                  TASK_BASIC_INFO, (task_info_t)&t_info, &t_info_count))
    {
        return false;
    }

    static vm_size_t last_virtual_size = 0;
    static vm_size_t last_resident_size = 0;

    NDLog(@"Memory: %llu virtual, %llu resident. Deltas: %lld, %lld",
           t_info.virtual_size, t_info.resident_size,
           t_info.virtual_size - last_virtual_size, t_info.resident_size - last_resident_size);

    last_virtual_size = t_info.virtual_size;
    last_resident_size = t_info.resident_size;

    return true;
}

@end
