//
//  FlipsideViewController.h
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController {
	IBOutlet UILabel *countdown;
	
	IBOutlet UITableView *problemTable;
	IBOutlet UIButton *rightButton;
	IBOutlet UIButton *wrongButton;
	//NSArray *tableArray;
	NSMutableArray *problemArray;
	int currentProblem;
	//	BrainTuner3AppDelegate *app = (BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate];
	int problemCount;
	NSDate *start;
	
	double finalTime;
}

//- (UITableViewCell *)cellFromNibNamed:(NSString *)nibName;

- (IBAction)clickRight:(id)sender;
- (IBAction)clickWrong:(id)sender;

- (void)alertStatsAndReset;
- (void)setProblemCount:(int)newCount;

- (void)playSound:(const char *)inFileName;

@property (nonatomic) int problemCount;
@property (nonatomic, retain) NSMutableArray *problemArray;

@end
