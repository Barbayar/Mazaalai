//
//  MazaalaiAppDelegate.h
//  Mazaalai
//
//  Created by Dashzeveg Barbayar on 10/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

@class Settings;

@interface DictionaryAppDelegate : NSObject <UIApplicationDelegate>
{    
    UIWindow *window;
    UINavigationController *navigationController;
	Settings *settingsWindow;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)showSettings;
@end

