//
//  MainViewController.m
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "BrainTuner3AppDelegate.h"


@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
		//int problemCount = 20;
		//[self loadBestTime:20];

	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	int index = [segmentedControl selectedSegmentIndex];
	int problemCount;
	if (index == 0)
		problemCount = 20;
	else
		problemCount = 100;
	[self loadBestTime:problemCount];
}


 - (void)viewDidLoad {
	 int index = [segmentedControl selectedSegmentIndex];
	 int problemCount;
	 if (index == 0)
		 problemCount = 20;
	 else
		 problemCount = 100;
	 [self loadBestTime:problemCount];
 }



- (IBAction)setProblemCount:(UISegmentedControl *)sender {
	int selected = [sender selectedSegmentIndex];
	NSLog(@"selected %d", selected);
	BrainTuner3AppDelegate *app = (BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate];
	//int problemCount;
	if (selected == 0)
		app.problemCount = 20;
	else
		app.problemCount = 100;
	//[[[app rootViewController] flipsideViewController] setProblemCount:problemCount];
	
	[self loadBestTime:app.problemCount];
}

- (void)loadBestTime:(int)numProblems {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	float fBestTime = [defaults floatForKey:[NSString stringWithFormat:@"BestTime%d", numProblems]];
	NSString *sBestTime;
	if (fBestTime == 0) {
		sBestTime = @"None Yet";
	} else {
		sBestTime = [NSString stringWithFormat:@"%f seconds", fBestTime];
	}
	bestTime.text = [NSString stringWithFormat:@"Best Time: %@", sBestTime];
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
	[super dealloc];
}


@end
