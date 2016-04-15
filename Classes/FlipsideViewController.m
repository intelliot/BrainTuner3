//
//  FlipsideViewController.m
//  BrainTuner3
//
//  Created by Elliot Lee on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Problem.h"
#import "BrainTuner3AppDelegate.h"
//#import "MyTableViewCell.h"

#define RANDOM_SEED() srandom(time(NULL))
#define LABEL_TAG 1
#define IMAGE_TAG 2
//#define CELL_IDENTIFIER @"MainCell";

@implementation FlipsideViewController

@synthesize problemCount;

- (void)viewDidLoad {
	//self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
}


- (void)viewWillAppear:(BOOL)animated {
	RANDOM_SEED();
	
	currentProblem = 0;
	
	BrainTuner3AppDelegate *app = (BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate];
	problemCount = app.problemCount;
	
	if (problemCount != 20 && problemCount != 100)
		problemCount = 20;
	
	if (problemArray == nil) {
		problemArray = [[NSMutableArray arrayWithCapacity:problemCount] retain]; //[[NSArray arrayWithObjects:[Problem randomProblem] count:10] retain];
	} else {
		[problemArray removeAllObjects];
	}
	
	for (int i = 0; i < problemCount; i++) {
		[problemArray addObject:[Problem randomProblem]];
	}
	
	[problemTable reloadData];
	
	//problemArray = [[NSArray alloc] init];
	//[problemArray
	NSLog(@"%@", problemArray);
	//currentProblem = 0;
	//tableArray = [[NSArray arrayWithObjects:@"First", @"Second", @"Third", nil] retain];
	
	//[problemTable selectRowAtIndexPath:(NSIndexPath *)currentProblem animated:NO scrollPosition:UITableViewScrollPositionMiddle];
	
	// select row
	NSIndexPath *rowPath = [NSIndexPath indexPathForRow:currentProblem
											  inSection:0];
	[problemTable selectRowAtIndexPath:rowPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	// scroll to the row
	[problemTable scrollToRowAtIndexPath:rowPath
						atScrollPosition:UITableViewScrollPositionMiddle
								animated:YES];
	
	start = [[NSDate date] retain];
}

/*
- (void)setProblemCount:(int)newCount {
	problemCount = newCount;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [problemArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *identity = @"MainCell";

	UILabel *label;
	UIImageView *imageView;
	
	//MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identity];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];//CELL_IDENTIFIER
	
	if (cell == nil) {
	
		//cell = (MyTableViewCell *)[self cellFromNibNamed:@"MyTableViewCell"];
		CGRect frame = CGRectMake(0, 0, 320, 68);
		//cell = [[[MyTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 200, 200) reuseIdentifier:identity] autorelease];
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:identity] autorelease];//CELL_IDENTIFIER
		
		label = [[[UILabel alloc] initWithFrame:CGRectMake(12.0, 0.0, 252.0, 68.0)] autorelease];
		label.tag = LABEL_TAG;
		//label.font = [label.font fontWithSize:32.0];
		label.font = [UIFont boldSystemFontOfSize:32.0];
		[cell.contentView addSubview:label];
		
		imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(248.0, 12.0, 48.0, 48.0)] autorelease];
		imageView.tag = IMAGE_TAG;
		[cell.contentView addSubview:imageView];
	} else {
		label = (UILabel *)[cell.contentView viewWithTag:LABEL_TAG];
		imageView = (UIImageView *)[cell.contentView viewWithTag:IMAGE_TAG];
	}
	
	label.text = [[problemArray objectAtIndex:indexPath.row] text];
	//cell.text = [[problemArray objectAtIndex:indexPath.row] text];
	//[cell setCellText:[[problemArray objectAtIndex:indexPath.row] text]]; 
	//[cell setCellText:[[problemArray objectAtIndex:indexPath.row] text]];
	
	//cell.font = [cell.font fontWithSize:32.0];
	//[cell setCellFont:[cell.font fontWithSize:32.0]];
	
	//if ([[problemArray objectAtIndex:indexPath.row] image] != nil) {
		
	
	imageView.image = [[problemArray objectAtIndex:indexPath.row] image];
	
		//cell.image = [[problemArray objectAtIndex:indexPath.row] image];
		//[cell setCellImage:[[problemArray objectAtIndex:indexPath.row] image]];
		//[cell setCellImage:[[problemArray objectAtIndex:indexPath.row] image]];
	/*	
	} else {
		imageView.image = nil;
	}
	 */
	return cell;
}

/*
- (UITableViewCell *)cellFromNibNamed:(NSString *)nibName {
	// laod the xib file into memory
	NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName 
												   owner:self 
												 options:nil];		
	// get the note view cell
	UITableViewCell *cell = [array objectAtIndex:1];
	
	// get the content view items
	UIView *childView = [array objectAtIndex:2]; //1
	CGRect frame = [childView frame];
	
	// finetune the position
	const int pos = 7;
	frame.origin.x += pos;
	frame.size.width -= pos;
	frame.size.height -= 1;
	[childView setFrame:frame];
	
	// get the content view child
	[cell.contentView addSubview:childView];
	
	return cell;
}
*/

- (IBAction)clickRight:(id)sender {
	
	if ([[problemArray objectAtIndex:currentProblem] isRight] == YES) {
		[[problemArray objectAtIndex:currentProblem] setImage:[UIImage imageNamed:@"right.png"]];
	} else {
		[[problemArray objectAtIndex:currentProblem] setImage:[UIImage imageNamed:@"wrong.png"]];
	}
	[problemTable reloadData];
	
	
	NSLog(@"clickRight");
	if (currentProblem < problemCount-1) {
		currentProblem++;
		NSLog(@"%d", currentProblem);
		// path of the 'to be' selected row
		NSIndexPath *rowPath = [NSIndexPath indexPathForRow:currentProblem
											  inSection:0];
		[problemTable selectRowAtIndexPath:rowPath animated:NO scrollPosition:UITableViewScrollPositionNone];
		// scroll to the row
		[problemTable scrollToRowAtIndexPath:rowPath
			   atScrollPosition:UITableViewScrollPositionMiddle
					   animated:YES];
	} else {
		[self alertStatsAndReset];
	}
}


- (IBAction)clickWrong:(id)sender {
	
	if ([[problemArray objectAtIndex:currentProblem] isRight] == NO) {
		[[problemArray objectAtIndex:currentProblem] setImage:[UIImage imageNamed:@"right.png"]];
	} else {
		[[problemArray objectAtIndex:currentProblem] setImage:[UIImage imageNamed:@"wrong.png"]];
	}
	[problemTable reloadData];
	
	NSLog(@"clickWrong");
	
	if (currentProblem < problemCount-1) {
		currentProblem++;
		NSIndexPath *rowPath = [NSIndexPath indexPathForRow:currentProblem
											  inSection:0];
		[problemTable selectRowAtIndexPath:rowPath animated:NO scrollPosition:UITableViewScrollPositionNone];
		// scroll to the row
		[problemTable scrollToRowAtIndexPath:rowPath
						atScrollPosition:UITableViewScrollPositionMiddle
								animated:YES];
	} else {
		[self alertStatsAndReset];
	}
}

- (void)alertStatsAndReset {
	double time = -[start timeIntervalSinceNow];
	
	int correct = 0, incorrect = 0;
	Problem *p;
	for (int i = 0; i < problemCount; i++) {
		p = [problemArray objectAtIndex:i];
		if (p.image == [UIImage imageNamed:@"right.png"]) {
			correct++;
		} else {
			incorrect++;
		}
	}
	int accuracy = (100 * correct) / problemCount;
	int penalty = 5 * incorrect;
	double finalTime = time + penalty;
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	float fBestTime = [defaults floatForKey:[NSString stringWithFormat:@"BestTime%d", problemCount]];
	NSString *newRecord = nil;
	
	if (finalTime < fBestTime || fBestTime == 0) {
		[defaults setFloat:finalTime forKey:[NSString stringWithFormat:@"BestTime%d", problemCount]];
		newRecord = @"(New Record!)";
	}
	
	NSString *title;
	NSString *message;
	if (finalTime >= 2.5 * problemCount) {
		title = [NSString stringWithString:@"Not Very Good"];
		message = [NSString stringWithString:@"Get your brain in-tune\nby trying again!"];
	} else if (finalTime >= 2 * problemCount) {
		title = [NSString stringWithString:@"Try Harder"];
		message = [NSString stringWithString:@"You'll get better with practice.\nTry again!"];
	} else if (finalTime >= 1.5 * problemCount) {
		title = [NSString stringWithString:@"Good Job"];
		message = [NSString stringWithString:@"That's a good time! Keep improving."];
	} else if (finalTime >= problemCount) {
		title = [NSString stringWithString:@"Great Speed"];
		message = [NSString stringWithString:@"Nice job. Keep playing and beat your old time!"];
	} else if (finalTime >= 0.5 * problemCount) {
		title = [NSString stringWithString:@"Congratulations!"];
		message = [NSString stringWithString:@"You're amazing! Play every day to keep your brain in-tune."];
	} else {
		title = [NSString stringWithString:@"Expert"];
		message = [NSString stringWithString:@"Send me feedback for future Brain Tuner games!"];
	}
	
	if (newRecord != nil) {
		message = [NSString stringWithFormat:@"%@\n%@", newRecord, message];
	}
	
	// open an alert with just an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
							message:[NSString stringWithFormat:@"%d%% Accuracy.\n%f sec. + %d penalty =\n%f seconds.\n%@", accuracy, time, penalty, finalTime, message]
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[(RootViewController *)[(BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] toggleView];

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
