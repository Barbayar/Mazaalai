//
//  BolorDictionary.m
//  Dictionary
//
//  Created by Dashzeveg Barbayar on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BolorDictionary.h"

@implementation BolorDictionary

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Болор Толь";
    }
    return self;
}

- (void)startSearch
{
    [activityIndicatorView startAnimating];
    [webView loadHTMLString:@"" baseURL:nil];
}

- (void)endSearch:(NSString *)downloadedData
{
    [activityIndicatorView stopAnimating];
    
    if(downloadedData == nil)
    {
        [webView loadHTMLString:@"Интернетийн холболтонд алдаа гарлаа." baseURL:nil];
        
        return;
    }
    
    NSRange tempRange = [downloadedData rangeOfString:@"</table><br><div></div>"];
    
    if(tempRange.location == NSNotFound)
    {
        [webView loadHTMLString:[NSString stringWithFormat:@"<font face=\"verdana\">\"%@\" гэсэн үг олдсонгүй.</font>", theQuery] baseURL:nil];
        
        return;
    }

    downloadedData = [downloadedData substringFromIndex:tempRange.location + tempRange.length];
    
    tempRange = [downloadedData rangeOfString:@"<br></div>"];
    
    if(tempRange.location == NSNotFound)
    {
        [webView loadHTMLString:[NSString stringWithFormat:@"<font face=\"verdana\">\"%@\" гэсэн үг олдсонгүй.</font>", theQuery] baseURL:nil];
        
        return;
    }
    
    downloadedData = [downloadedData substringToIndex:tempRange.location];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"<td><img src=\"http://www.bolor-toli.com/images/help16.png\" align=\"middle\" border=\"0\" onmouseover=\"showWMTT('checkbox_tooltip')\" onmouseout=\"hideWMTT()\"/></td>" withString:@""];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"src=\"http://www.bolor-toli.com/pix/info.gif\"" withString:@""];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"src=\"http://www.bolor-toli.com/images/true.png\" border=\"0\" height=\"16\" width=\"16\" align=\"middle\" title=\"Please click on it, if this result meets your requirements!\" alt=\"Please click on it, if this result meets your requirements!\"" withString:@""];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"src=\"http://www.bolor-toli.com/images/false.png\" border=\"0\" height=\"16\" width=\"16\" align=\"middle\" title=\"Please click on it, if this result does not meet your requirements!\" alt=\"Please click on it, if this result does not meet your requirements!\"" withString:@""];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"href" withString:@"href_"];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"<td colspan=\"2\" width=\"50%\"> <span class=\"greenBoldFont\"></span></td>" withString:@""];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"<td align=\"center\">" withString:@"<td colspan=\"4\" align=\"center\">"];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"<td colspan=\"2\" width=\"50%\"> </td>" withString:@""];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"<td colspan=\"2\" align=\"center\">" withString:@"<td colspan=\"4\" align=\"center\">"];
    downloadedData = [downloadedData stringByReplacingOccurrencesOfString:@"<tr><td colspan=\"4\" align=\"center\"><b>Examples / Composite entries</b></td></tr>" withString:@""];
    
	downloadedData = [NSString stringWithFormat:@"<font face=\"verdana\">%@</font>", downloadedData];
    
    downloadedData = [downloadedData stringByAppendingFormat:@"<a href=\"http://barbayar.com/mazaalai/banner.php\"><img style=\"position:fixed; bottom:10px; left:10px; width:300px; height:50px\" src=\"http://barbayar.com/mazaalai/banner.png\"></a>"];
    
    [webView loadHTMLString:downloadedData baseURL:nil];
}

- (void)searchThread:(NSString *)query
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [self performSelectorOnMainThread:@selector(startSearch) withObject:nil waitUntilDone:NO];
    
    NSString *downloadedData = [NSString stringWithContentsOfURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://bolor-toli.com/index.php?pageId=10&direction=mn-en&search=%@", query] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding error:nil];
    
    [self performSelectorOnMainThread:@selector(endSearch:) withObject:downloadedData waitUntilDone:NO];
    
    [pool release];
}

- (void)search:(NSString *)query
{
    [theQuery release];
    theQuery = [[NSString alloc] initWithString:query];
    
    [NSThread detachNewThreadSelector:@selector(searchThread:) toTarget:self withObject:query];
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
