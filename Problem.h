//
//  Problem.h
//  BrainTuner3
//
//  Created by Elliot Lee on 7/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Problem : NSObject {
	//int a, b;
	//char op;
	NSString *text;
	BOOL isRight;
	UIImage *image;
	
	//NSString *minimal;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic) BOOL isRight;
@property (nonatomic, retain) UIImage *image;

//@property (nonatomic, retain) NSString *minimal;

+ (id)randomProblem;

@end
