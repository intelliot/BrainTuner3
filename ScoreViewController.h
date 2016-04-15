//
//  ScoreViewController.h
//  BrainTuner3
//
//  Created by Elliot Lee on 8/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreViewController : UIViewController {
    IBOutlet UIWebView *webView;
	IBOutlet UIButton *doneButton;
	double finalTime;
}

- (IBAction)tapDone:(id)sender;

@end
