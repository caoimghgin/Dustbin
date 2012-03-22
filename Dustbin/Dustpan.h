//
//  Dustbin.h
//  Dustbin
//
//  Created by Kevin Muldoon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dustpan : NSObject

@property (nonatomic, retain) NSFileManager *fileManager; 
@property (nonatomic, retain) NSMutableSet *contentsOfDesktopToMove;
@property (nonatomic, retain) NSString *dustBinParentDirectory;
@property (nonatomic, retain) NSString *dustBinTimeStampDirectory;

- (void)filterContentsOfDesktop:(NSArray *)array;
- (void)getContentsOfDesktop;
- (void)createDustBinDirectory;
- (void)moveItemsToDustBin;

@end
