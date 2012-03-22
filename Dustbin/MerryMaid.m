//
//  MerryMaid.m
//  M
//
//  Created by Kevin Muldoon on 7/26/11.
//  Copyright 2011 TrueBlueDot, Inc.. All rights reserved.
//

#import "MerryMaid.h"


@implementation MerryMaid

@synthesize fileManager;
@synthesize setOfItemsToMove;
@synthesize dustBinParentDirectory;
@synthesize dustBinTimeStampDirectory;

- (id)init {
	
    if ( self = [super init] ) {
		
		NSLog(@"MerryMaid Initializing....");
		
		self.fileManager = [[NSFileManager alloc] init]; 
		self.setOfItemsToMove = [[NSMutableSet alloc] init];
		self.dustBinParentDirectory = [[NSString alloc] initWithString:[@"~/Dustbin/" stringByExpandingTildeInPath]];

    }
	
    return self;
}

- (void)populateSetOfItemsToMoveWithContentsOfDesktop {
	
	NSString *desktopDirectory = [@"~/Desktop/" stringByExpandingTildeInPath];
	NSError *error = nil;
	NSArray *desktopDirectoryContents = [[NSArray alloc] initWithArray: [self.fileManager contentsOfDirectoryAtPath:desktopDirectory error:&error]];
	
	if (error != nil) {
		NSAlert *alertDialog = [NSAlert alertWithError:error];
		[alertDialog runModal];
	}
	
	NSMutableArray *desktopDirectoryContentsExpandedPath = [[NSMutableArray alloc] initWithCapacity:[desktopDirectoryContents count]];
	
	for(NSString *item in desktopDirectoryContents) {
		[desktopDirectoryContentsExpandedPath addObject:[desktopDirectory stringByAppendingPathComponent:item]];
	}
	
	
	[self populateSetOfItemsToMove:desktopDirectoryContentsExpandedPath];
	
	[desktopDirectoryContentsExpandedPath release];
	[desktopDirectoryContents release];
	[error release];
}

- (void)populateSetOfItemsToMove:(NSArray *)array {
	
	for(NSString *item in array) {
		
		NSString *itemName = [item lastPathComponent];
		
		if (![itemName hasPrefix:@"."]) {
			[self.setOfItemsToMove addObject:item];
		}
	}
	
}

- (void)createDustBinDirectory {
	
	NSDate *today = [[NSDate date] retain];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyyMMdd"];
	NSString *formattedDateYYYMMDD = [[dateFormatter stringFromDate:today] retain];
	[dateFormatter setDateFormat:@"HHmmss"];
	NSString *formattedDateHHMMSS = [[dateFormatter stringFromDate:today] retain];

	self.dustBinTimeStampDirectory = [[self.dustBinParentDirectory stringByAppendingPathComponent:formattedDateYYYMMDD] stringByAppendingPathComponent:formattedDateHHMMSS];
	
	if(![self.fileManager createDirectoryAtPath:self.dustBinTimeStampDirectory withIntermediateDirectories:YES attributes:nil error:NULL]) {
		NSLog(@"handle this createDirectoryAtPath error...");
	}
			
	[dateFormatter release];
	[today release];
	[formattedDateYYYMMDD release];
	[formattedDateHHMMSS release];
	
}

- (void)moveItemsToDustBin {
	/*
	
	 NSString * name  = @"About Xcode Tools.pdf";
	NSArray  * files = [NSArray arrayWithObject: name];
	 
	NSWorkspace * workspace = [NSWorkspace sharedWorkspace];
	
	[workspace performFileOperation: NSWorkspaceMoveOperation
					  source: @"/Developer/"
				 destination: @"/Users/scott/Desktop/"
					   files: files
						 tag: 0];
	 */
	

	NSError *error;
	
	for(NSString *item in self.setOfItemsToMove) {
		
		NSString *newPath = [dustBinTimeStampDirectory stringByAppendingPathComponent:[item lastPathComponent]];
		NSLog(@"Attempt to move %@  to %@", item, newPath );
		[self.fileManager moveItemAtPath:item toPath:newPath error:&error];
		

		
		
	}


	
}

- (void)dealloc {
	[self.fileManager release];
	[self.setOfItemsToMove release];
	[self.dustBinParentDirectory release];
	[self.dustBinTimeStampDirectory release];
	[super dealloc];
}

@end
