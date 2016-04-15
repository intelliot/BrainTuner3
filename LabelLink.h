//
//  LabelLink.h
//  BrainTuner3
//
//  Created by Elliot Lee on 8/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LabelLink : UILabel {

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
