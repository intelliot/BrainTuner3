//
//  BrainTuner3AppDelegate.m
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "BrainTuner3AppDelegate.h"
#import "RootViewController.h"

@implementation BrainTuner3AppDelegate


@synthesize window;
@synthesize rootViewController;
@synthesize problemCount;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	[window addSubview:[rootViewController view]];
	[window makeKeyAndVisible];
}


- (void)dealloc {
	[rootViewController release];
	[window release];
	[super dealloc];
}

@end
