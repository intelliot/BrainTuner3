//
//  MainViewController.h
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
	IBOutlet UISegmentedControl *segmentedControl;
	IBOutlet UILabel *bestTime;
	//IBOutlet UILabel *myURL;
}

- (IBAction)setProblemCount:(UISegmentedControl *)sender;
- (void)loadBestTime:(int)numProblems;

- (IBAction)clickLink:(id)sender;

@end
