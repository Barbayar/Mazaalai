//
//  BolorDictionary.h
//  Dictionary
//
//  Created by Dashzeveg Barbayar on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BolorDictionary : UIViewController
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityIndicatorView;
    
    NSString *theQuery;
}

- (void)search:(NSString *)query;
@end
