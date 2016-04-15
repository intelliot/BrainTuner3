//
//  RootViewController.m
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "FlipsideViewController.h"

//#import "AudioServices.h"
#include <AudioToolbox/AudioToolbox.h>
#include <CoreFoundation/CFURL.h>

@implementation RootViewController

// synthesize Start button
@synthesize startButton;

@synthesize flipsideNavigationBar;
@synthesize mainViewController;
@synthesize flipsideViewController;


- (void)viewDidLoad {
	
	MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = viewController;
	[viewController release];
	
	//[self.view insertSubview:mainViewController.view belowSubview:infoButton];
	[self.view insertSubview:mainViewController.view belowSubview:startButton];

	// Start button
	//[self.view insertSubview:startButton aboveSubview:mainViewController.view];
}


- (void)loadFlipsideViewController {
	
	FlipsideViewController *viewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	self.flipsideViewController = viewController;
	[viewController release];
	
	// Set up the navigation bar
	UINavigationBar *aNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	aNavigationBar.barStyle = UIBarStyleBlackOpaque;
	self.flipsideNavigationBar = aNavigationBar;
	[aNavigationBar release];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toggleView)];
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Brain Tuner Lite"];
	navigationItem.rightBarButtonItem = buttonItem;
	[flipsideNavigationBar pushNavigationItem:navigationItem animated:NO];
	[navigationItem release];
	[buttonItem release];
}


- (void)playSound:(const char *)inFileName {
	SystemSoundID mySSID; // maybe reuse this?
	
	CFStringRef fileName = CFStringCreateWithCString(kCFAllocatorDefault, inFileName, kCFStringEncodingUTF8);
	CFStringRef fileType = CFStringCreateWithCString(kCFAllocatorDefault, "wav", kCFStringEncodingUTF8);
	
	CFBundleRef mainBundle = CFBundleGetMainBundle();
	CFURLRef myURLRef = CFBundleCopyResourceURL(mainBundle, fileName, fileType, NULL);
	
	AudioServicesCreateSystemSoundID (myURLRef, &mySSID); // maybe delete this to save memory?
	AudioServicesPlaySystemSound (mySSID);
}


- (IBAction)toggleView {	
	/*
	 This method is called when the info or Done button is pressed.
	 It flips the displayed view from the main view to the flipside view and vice-versa.
	 */
	
	[self playSound:"TECHNOLOGY MULTIMEDIA MENU SCREEN BLIP 01"];
	
	if (flipsideViewController == nil) {
		[self loadFlipsideViewController];
	}
	
	UIView *mainView = mainViewController.view;
	UIView *flipsideView = flipsideViewController.view;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	if ([mainView superview] != nil) {
		[flipsideViewController viewWillAppear:YES];
		[mainViewController viewWillDisappear:YES];
		[mainView removeFromSuperview];

		// Start button
		[startButton removeFromSuperview];
		
		[self.view addSubview:flipsideView];
		[self.view insertSubview:flipsideNavigationBar aboveSubview:flipsideView];
		[mainViewController viewDidDisappear:YES];
		[flipsideViewController viewDidAppear:YES];

	} else {
		[mainViewController viewWillAppear:YES];
		[flipsideViewController viewWillDisappear:YES];
		[flipsideView removeFromSuperview];
		[flipsideNavigationBar removeFromSuperview];
		[self.view addSubview:mainView];
		
		// Start button
		[self.view insertSubview:startButton aboveSubview:mainViewController.view];
		
		[flipsideViewController viewDidDisappear:YES];
		[mainViewController viewDidAppear:YES];
	}
	[UIView commitAnimations];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	
	// Start button
	[startButton release];
	
	[flipsideNavigationBar release];
	[mainViewController release];
	[flipsideViewController release];
	[super dealloc];
}


@end
