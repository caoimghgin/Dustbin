//
//  MerryMaid.h
//  M
//
//  Created by Kevin Muldoon on 7/26/11.
//  Copyright 2011 TrueBlueDot, Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MerryMaid : NSObject {
	NSFileManager *fileManager;
	NSMutableSet *setOfItemsToMove;
	NSString *dustBinParentDirectory;
	NSString *dustBinTimeStampDirectory;
}

@property (retain) NSFileManager *fileManager; 
@property (retain) NSMutableSet *setOfItemsToMove;
@property (retain) NSString *dustBinParentDirectory;
@property (retain) NSString *dustBinTimeStampDirectory;

- (id)init;
- (void)populateSetOfItemsToMoveWithContentsOfDesktop;
- (void)populateSetOfItemsToMove:(NSArray *)array;
- (void)createDustBinDirectory;
- (void)moveItemsToDustBin;
- (void)dealloc;

@end
