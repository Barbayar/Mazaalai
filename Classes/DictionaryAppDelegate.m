//
//  MazaalaiAppDelegate.m
//  Mazaalai
//
//  Created by Dashzeveg Barbayar on 10/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "DictionaryAppDelegate.h"
#import "Settings.h"

@implementation DictionaryAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (IBAction)showSettings
{    
	if(settingsWindow == nil)
	{
		settingsWindow = [[Settings alloc] initWithNibName:@"Settings" bundle:nil];
		settingsWindow.title = @"Үндсэн цэс";
	}
	
	[[self navigationController] pushViewController:settingsWindow animated:YES];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[navigationController release];
	[settingsWindow release];
	[window release];
	[super dealloc];
}


@end

