//
//  AppDelegate.m
//  Dustbin
//
//  Created by Kevin Muldoon on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    Dustpan *dustpan = [[Dustpan alloc] init];
    [dustpan getContentsOfDesktop];
    if ([dustpan.contentsOfDesktopToMove count] > 0 )
    {
        [dustpan createDustBinDirectory];
        [dustpan moveItemsToDustBin];
        [[NSWorkspace sharedWorkspace] openFile:dustpan.dustBinTimeStampDirectory];
    } else {
        NSLog(@"No items on desktop to move. Program will quit.");
    }
	exit(0);
}

@end
