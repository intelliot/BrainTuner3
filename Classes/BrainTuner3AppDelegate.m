//
//  BrainTuner3AppDelegate.m
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "BrainTuner3AppDelegate.h"
#import "RootViewController.h"

#import "ScoreViewController.h"

@implementation BrainTuner3AppDelegate


@synthesize window;
@synthesize rootViewController;
@synthesize problemCount;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	[window addSubview:[rootViewController view]];
	[window makeKeyAndVisible];
}

/*
- (void)applicationWillTerminate:(UIApplication *)application {
	ScoreViewController *scoreViewController = [rootViewController scoreViewController];
	if (scoreViewController != nil && [[scoreViewController view] superview] != nil) {
		NSLog(@"Saving state");
		
		
		NSLog(@"%@", [scoreViewController webView]); //[[[ request] URL] absoluteString]
	}
}
*/

- (void)dealloc {
	[rootViewController release];
	[window release];
	[super dealloc];
}

@end
