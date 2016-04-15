//
//  Problem.m
//  BrainTuner3
//
//  Created by Elliot Lee on 7/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Problem.h"

// a random number between min and max inclusive [min, max]
#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__))) 


@implementation Problem

@synthesize text, isRight, image;

+ (id)randomProblem {
	Problem *instance = [[self alloc] init];

	int a = RANDOM_INT(1, 10);
	int b = RANDOM_INT(1, 10);
	int c;
	int op = RANDOM_INT(1, 3); // 1 +, 2 -, 3 x
	NSString *strOp;
	if (op == 1) {
		strOp = @"+"; //[NSString stringWithString:@"+"];
		c = a + b;
	} else if (op == 2) {
		strOp = @"-";
		c = a - b;
	} else {
		strOp = @"x";
		c = a * b;
	}

	int makeRight = RANDOM_INT(0, 1);
	
	if (makeRight == 1) {
		instance.isRight = YES;
	} else {
		int offset = RANDOM_INT(1, 10);
		if (offset <= 5) {
			c -= offset;
		} else {
			c += offset-5;
		}
		instance.isRight = NO;
	}
		
	instance.text = [NSString stringWithFormat:@"%d %@ %d = %d", a, strOp, b, c];
	//instance.isRight = YES;
	NSLog(@"%d and %d", a, b);
	return instance;
}

- (NSString *)description {
	return [NSString stringWithFormat: @"%@ %@", text, [NSNumber numberWithBool:isRight]];
}

@end
