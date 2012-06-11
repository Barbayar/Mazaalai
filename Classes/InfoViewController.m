//
//  InfoViewController.m
//  Mazaalai
//
//  Created by Dashzeveg Barbayar on 10/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController
@synthesize currentDictionary;

- (NSString *)removeIMGTag:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO)
    {
        [theScanner scanUpToString:@"<img" intoString:NULL] ; 
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
    }
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO)
    {
        [theScanner scanUpToString:@"<IMG" intoString:NULL] ; 
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
    }
    
    return html;
}

-(void)reloadWebView
{
	NSString *HTML = @"";
	NSUserDefaults *configuration = [NSUserDefaults standardUserDefaults];
	int fontSize = [configuration integerForKey:@"fontSize"];
	BOOL showImage = [configuration integerForKey:@"showImage"];
	
	HTML = [HTML stringByAppendingFormat:@"<font face=\"verdana\" style=\"font-size:%d\"><b>%@</b></font><br>", fontSize, [NSString stringWithUTF8String:(*currentDictionary).words[(*currentDictionary).currentPosition].word]];
	HTML = [HTML stringByAppendingFormat:@"<br><font face=\"verdana\" style=\"font-size:%d\">%@</font>", fontSize, [NSString stringWithUTF8String:(*currentDictionary).words[(*currentDictionary).currentPosition].description]];
	
    if(!showImage)
        HTML = [self removeIMGTag:HTML];
    
    HTML = [HTML stringByAppendingFormat:@"<a href=\"http://barbayar.com/mazaalai/banner.php\"><img style=\"position:fixed; bottom:10px; left:10px; width:300px; height:50px\" src=\"http://barbayar.com/mazaalai/banner.png\"></a>"];
    
	[webView loadHTMLString:HTML baseURL:nil];
}

- (IBAction) showPrevious
{
	if((*currentDictionary).currentPosition > 0)
		(*currentDictionary).currentPosition--;
	else
		(*currentDictionary).currentPosition = (*currentDictionary).wordCount - 1;
	
	[self reloadWebView];
};

- (IBAction) showRandom
{
	(*currentDictionary).currentPosition = arc4random() % (*currentDictionary).wordCount;
	[self reloadWebView];
};

- (IBAction) showNext
{
	if((*currentDictionary).currentPosition < ((*currentDictionary).wordCount - 1))
		(*currentDictionary).currentPosition++;
	else
		(*currentDictionary).currentPosition = 0;
	
	[self reloadWebView];
};

- (void)viewDidAppear:(BOOL)animated
{
	[self reloadWebView];
    
	[super viewDidAppear:animated];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        
        return NO;
    }
    
    return YES;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [super dealloc];
}

@end
