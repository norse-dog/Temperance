//
//  NDCommand.h
//  Temperance
//
//  Created by Norse Dog on 6/2/12.
//  Copyright (c) 2012 Folkwang Enterprises. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NDCommand <NSObject>

-(BOOL)execute:(NSArray*)words;

@end


@interface NDCommanding : NSObject

@property (readonly, strong, nonatomic) NSDictionary *registeredCommands;

-(BOOL)execute:(NSString*)cmdString;

@end


@interface NDLogCommand : NSObject <NDCommand>

-(BOOL)execute:(NSArray*)words;

@end


@interface NDSysCommand : NSObject <NDCommand>

-(BOOL)execute:(NSArray*)words;

@end


@interface NDStatsCommand : NSObject <NDCommand>

-(BOOL)execute:(NSArray*)words;

@end


@interface NDHelpCommand : NSObject <NDCommand>

-(BOOL)execute:(NSArray*)words;

@end


@interface NDQuitCommand : NSObject <NDCommand>

-(BOOL)execute:(NSArray*)words;

@end
