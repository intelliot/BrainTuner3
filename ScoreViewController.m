//
//  ScoreViewController.m
//  BrainTuner3
//
//  Created by Elliot Lee on 8/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ScoreViewController.h"
#import "RootViewController.h"
#import "BrainTuner3AppDelegate.h"

#import "FlipsideViewController.h"

@implementation ScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated  {
	//NSLog(@"scoreViewController will appear");
	webView.detectsPhoneNumbers = NO;
	
	int problemCount = [(FlipsideViewController *)[(RootViewController *)[(BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] flipsideViewController] problemCount];
	NSString *deviceuid = [[UIDevice currentDevice] uniqueIdentifier];
	
	NSString *toHash = [NSString stringWithFormat:@"%lf%d%@%@%@", finalTime, problemCount, deviceuid, @"1", @"6uphEGev"];
	NSString *hash = [toHash md5sum];
	
	NSMutableArray *problemArray = [(FlipsideViewController *)[(RootViewController *)[(BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] flipsideViewController] problemArray];
	
	NSString *urlString = [NSString stringWithFormat:
						   @"http://gengarstudios.com/scores/submitscore.php?score=%lf&problems=%d&deviceuid=%@&hash=%@&version=1&problemarray=%@",
						   finalTime, problemCount, deviceuid, hash, [problemArray componentsJoinedByString:@","]];
	NSLog(@"%@", urlString);
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:
	 urlString]]];
}

- (void)setFinalTime:(double)score {
	finalTime = score;
}

- (IBAction)tapDone:(id)sender {
	[(RootViewController *)[(BrainTuner3AppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] toggleView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	//NSLog(@"request:%@ navigationType:%d", request, navigationType);
	
	/**
	 * navigationType ==
	 *  1 for form submit (executes twice)
	 *  4 for refresh
	 *  5 for initial page load and custom links
	 */
	
	NSString* path=[[request URL] relativePath];
	BOOL shouldContinue=YES;
	
	//confirm("Email (optional) is blank. Press OK to continue, or Cancel to enter an email address.")
	if ([path isEqualToString:@"/_confirm_blank_email"])
	{
		shouldContinue=NO;
		
		// let's show this worked by displaying an alert
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Email Entered" 
														message:@"Email is optional." 
													   delegate:self 
											  cancelButtonTitle:@"Enter Email" otherButtonTitles:@"No Email", nil];
		
		[alert show];	
		[alert release];
	} else if ([path isEqualToString:@"/_alert_invalid_email"]) {
		shouldContinue=NO;
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email"
														message:@"Email is optional, but what you entered is invalid. Correct it, or make the box blank."
													   delegate:self
											  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else if ([[[request URL] absoluteString] isEqualToString:@"http://www.gengarstudios.com/"]) {
		//NSLog([[request URL] absoluteString]);
		shouldContinue=NO;
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gengarstudios.com"]];
	}

	return shouldContinue;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"%@ %d", alertView.title, buttonIndex);
	
	if (buttonIndex == 0) {
		[webView stringByEvaluatingJavaScriptFromString:@"document.frmInfo.email.focus()"];
	} else {
		[webView stringByEvaluatingJavaScriptFromString:@"document.frmInfo.submit()"];
	}
}

/*
- (void) webView: (UIWebView*)webView runJavaScriptAlertPanelWithMessage: (NSString*) message initiatedByFrame: (WebFrame*) frame {
	NSLog(@"runJavaScriptAlertPanelWithMessage");
}
*/

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */


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

#include <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)
- (NSString *)md5sum {
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self UTF8String], [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	return [[ms copy] autorelease];
}
@end