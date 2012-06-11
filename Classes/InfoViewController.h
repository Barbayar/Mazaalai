//
//  InfoViewController.h
//  Mazaalai
//
//  Created by Dashzeveg Barbayar on 10/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"

@interface InfoViewController : UIViewController
{
	IBOutlet UIWebView *webView;
    
	struct TDictionary *currentDictionary;
}

@property (readwrite, assign) struct TDictionary *currentDictionary;

- (IBAction)showPrevious;
- (IBAction)showRandom;
- (IBAction)showNext;

@end
