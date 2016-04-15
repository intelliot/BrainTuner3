//
//  RootViewController.h
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class FlipsideViewController;

@class ScoreViewController;

@interface RootViewController : UIViewController {	
	// Start button
	IBOutlet UIButton *startButton;
	
	MainViewController *mainViewController;
	FlipsideViewController *flipsideViewController;
	UINavigationBar *flipsideNavigationBar;
	
	ScoreViewController *scoreViewController;
}

// Start button
@property (nonatomic, retain) UIButton *startButton;

@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) UINavigationBar *flipsideNavigationBar;
@property (nonatomic, retain) FlipsideViewController *flipsideViewController;

@property (nonatomic, retain) ScoreViewController *scoreViewController;

- (void)playSound:(const char *)inFilePath;
- (IBAction)toggleView;
- (IBAction)showScoreView:(double)score;

@end
