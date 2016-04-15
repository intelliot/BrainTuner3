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
#import "ScoreViewController.h"

//#import "AudioServices.h"
#include <AudioToolbox/AudioToolbox.h>
#include <CoreFoundation/CFURL.h>

@implementation RootViewController

// synthesize Start button
@synthesize startButton;

@synthesize flipsideNavigationBar;
@synthesize mainViewController;
@synthesize flipsideViewController;

@synthesize scoreViewController;

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


- (void)loadScoreViewController {
	ScoreViewController *viewController = [[ScoreViewController alloc] initWithNibName:@"ScoreView" bundle:nil];
	self.scoreViewController = viewController;
	[viewController release];
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
	 This method is called when the Start Game, Done, or OK is pressed.
	 It flips the displayed view from the main view to the flipside view and vice-versa.
	 */
	
	//[self playSound:"TECHNOLOGY MULTIMEDIA MENU SCREEN BLIP 01"];
	
	// if the flipsideViewController isn't loaded
	if (flipsideViewController == nil) {
		[self loadFlipsideViewController];
	}
	
	// get a pointer to the 2 views we're working with
	UIView *mainView = mainViewController.view;
	UIView *flipsideView = flipsideViewController.view;

	UIView *scoreView;
	if (scoreViewController != nil) {
		scoreView = scoreViewController.view;
	}
	
	// start animating (be sure to commitAnimations later!)
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	// on mainView
	if ([mainView superview] != nil) {
		[flipsideViewController viewWillAppear:YES];
		[mainViewController viewWillDisappear:YES];
		[mainView removeFromSuperview];

		// Start button
		[startButton removeFromSuperview];
		
		[self.view addSubview:flipsideView];
		[self.view insertSubview:flipsideNavigationBar aboveSubview:flipsideView];
		
		[UIView commitAnimations];
		
		[mainViewController viewDidDisappear:YES];
		[flipsideViewController viewDidAppear:YES];

	//  on flipsideView
	//} else if([flipsideView superview] != nil) {

	// on flipsideView or scoreView
	} else {
		[mainViewController viewWillAppear:YES];
		
		// switching from flipsideView
		if ([flipsideView superview] != nil) {
			[flipsideViewController viewWillDisappear:YES];
			[flipsideView removeFromSuperview];
			[flipsideNavigationBar removeFromSuperview];
		
		// switching from scoreView
		} else {
			[scoreViewController viewWillDisappear:YES];
			[scoreView removeFromSuperview];		
		}
		
		[self.view addSubview:mainView];
		
		// Start button
		[self.view insertSubview:startButton aboveSubview:mainViewController.view];
		
		[UIView commitAnimations];
		
		if ([flipsideView superview] != nil) {
			[flipsideViewController viewDidDisappear:YES];
		} else {
			[scoreViewController viewDidDisappear:YES];
		}
		
		[mainViewController viewDidAppear:YES];
	}
	
}


- (IBAction)showScoreView:(double)score {
	
	if (scoreViewController == nil) {
		[self loadScoreViewController];
	}
	
	UIView *mainView = mainViewController.view;
	UIView *flipsideView = flipsideViewController.view;
	UIView *scoreView = scoreViewController.view;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	[scoreViewController setFinalTime:score];
	[scoreViewController viewWillAppear:YES];
	[flipsideViewController viewWillDisappear:YES];
	[flipsideView removeFromSuperview];
	[flipsideNavigationBar removeFromSuperview];
	
	[self.view addSubview:scoreView];
	[flipsideViewController viewDidDisappear:YES];
	[scoreViewController viewDidAppear:YES];
	
	// this is important
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
