//
//  Dustbin.m
//  Dustbin
//
//  Created by Kevin Muldoon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dustpan.h"

@implementation Dustpan

@synthesize fileManager;
@synthesize contentsOfDesktopToMove;
@synthesize dustBinParentDirectory;
@synthesize dustBinTimeStampDirectory;

- (id)init {
	
    if ( self = [super init] ) 
    {
		
		NSLog(@"Dustbin Initializing....");
		
		self.fileManager = [[NSFileManager alloc] init]; 
		self.contentsOfDesktopToMove = [[NSMutableSet alloc] init];
		self.dustBinParentDirectory = [[NSString alloc] initWithString:[@"~/Dustbin/" stringByExpandingTildeInPath]];
    }
	
    return self;
}

- (void)getContentsOfDesktop 
{
	
	NSString *desktopDirectory = [@"~/Desktop/" stringByExpandingTildeInPath];
	NSError *error = nil;
	NSArray *desktopDirectoryContents = [[NSArray alloc] initWithArray: [self.fileManager contentsOfDirectoryAtPath:desktopDirectory error:&error]];
	
	if (error != nil) 
    {
		NSAlert *alertDialog = [NSAlert alertWithError:error];
		[alertDialog runModal];
	}
	
	NSMutableArray *contentsOfDesktopWithExpandedPath = [[NSMutableArray alloc] initWithCapacity:[desktopDirectoryContents count]];
	
	for(NSString *item in desktopDirectoryContents) 
    {
        NSLog(@"File: %@", item);
		[contentsOfDesktopWithExpandedPath addObject:[desktopDirectory stringByAppendingPathComponent:item]];
	}
	
	[self filterContentsOfDesktop:contentsOfDesktopWithExpandedPath];
}

// Do not move invisible files. The 'visible' attribute of a file
// is an HFS thing so we'll filter out the files that begin with '.'
- (void)filterContentsOfDesktop:(NSArray *)array 
{
	for(NSString *item in array) 
    {
		NSString *itemName = [item lastPathComponent];
		
		if (![itemName hasPrefix:@"."]) 
        {
			[self.contentsOfDesktopToMove addObject:item];
		}
	}
	
}

// Create timestamped directories and make directories.
- (void)createDustBinDirectory 
{
	// Name of directory in parent folder of DustBin. 
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyyMMdd"];
	
    // Name of directory within directory of parent folder DustBin.
    NSString *formattedDateYYYMMDD = [dateFormatter stringFromDate:today];
	[dateFormatter setDateFormat:@"HHmmss"];
	NSString *formattedDateHHMMSS = [dateFormatter stringFromDate:today];
    
    // Create String of all levels of DustBin Directory. It doesn't exist yet
    // But next line will create all the folders required.
	self.dustBinTimeStampDirectory = [[self.dustBinParentDirectory stringByAppendingPathComponent:formattedDateYYYMMDD] stringByAppendingPathComponent:formattedDateHHMMSS];
	
    // Create directory structure. There will be no errors since we are creating a unique path with timestamp.
	if(![self.fileManager createDirectoryAtPath:self.dustBinTimeStampDirectory withIntermediateDirectories:YES attributes:nil error:NULL]) {
		NSLog(@"handle this createDirectoryAtPath error...");
	}
	
}

// Iterate throgh contentsOfDesktopToMove and place them all
// in the Dustbin timestamp directory structure.
- (void)moveItemsToDustBin 
{
	NSError *error;
	
	for(NSString *item in self.contentsOfDesktopToMove) 
    {
		NSString *newPath = [dustBinTimeStampDirectory stringByAppendingPathComponent:[item lastPathComponent]];
		NSLog(@"Attempt to move %@  to %@", item, newPath );
		[self.fileManager moveItemAtPath:item toPath:newPath error:&error];
        // TO DO -- *error
	}

}

@end
