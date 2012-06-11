#import "Settings.h"
#import "Structures.h"

@implementation Settings

- (IBAction)onFontSizeSliderChange
{
	NSUserDefaults *configuration = [NSUserDefaults standardUserDefaults];
	[configuration setInteger:(NSInteger)fontSizeSlider.value forKey:@"fontSize"];
	[configuration synchronize];
	
	example1.font = [UIFont systemFontOfSize:(NSInteger)fontSizeSlider.value];
	example2.font = [UIFont boldSystemFontOfSize:(NSInteger)fontSizeSlider.value];
}

- (IBAction)onShowImageSwitchChange
{
	NSUserDefaults *configuration = [NSUserDefaults standardUserDefaults];
	[configuration setBool:showImageSwitch.on forKey:@"showImage"];
	[configuration synchronize];
}

- (void)viewDidLoad
{
	NSUserDefaults *configuration = [NSUserDefaults standardUserDefaults];
	int fontSize = [configuration integerForKey:@"fontSize"];
	BOOL showImage = [configuration boolForKey:@"showImage"];
	
	fontSizeSlider.value = fontSize;
	example1.font = [UIFont systemFontOfSize:(NSInteger)fontSizeSlider.value];
	example2.font = [UIFont boldSystemFontOfSize:(NSInteger)fontSizeSlider.value];
	showImageSwitch.on = showImage;
	
	[super viewDidLoad];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	tableView.allowsSelection = NO;
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return @"Тохиргоо";
	if(section == 1)
		return @"Танилцуулга";
	
	return nil;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
		return 3;
	if(section == 1)
		return 1;
	
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([indexPath section] == 0 && [indexPath row] == 0)
		return fontSettings.frame.size.height;
	if([indexPath section] == 0 && [indexPath row] == 1)
		return imageSettings.frame.size.height;
	if([indexPath section] == 0 && [indexPath row] == 2)
		return inputExplain.frame.size.height;
	if([indexPath section] == 1 && [indexPath row] == 0)
		return aboutPage.frame.size.height;
	
	return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([indexPath section] == 0 && [indexPath row] == 0)
		return fontSettings;
	if([indexPath section] == 0 && [indexPath row] == 1)
		return imageSettings;
	if([indexPath section] == 0 && [indexPath row] == 2)
		return inputExplain;
	if([indexPath section] == 1 && [indexPath row] == 0)
		return aboutPage;
	
	return nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
