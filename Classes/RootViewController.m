//
//  RootViewController.m
//  Mazaalai
//
//  Created by Dashzeveg Barbayar on 10/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "RootViewController.h"
#include <stdio.h>

@implementation RootViewController

- (IBAction)showDictionaryList
{    
	if(dictionaryListWindow == nil)
	{
		dictionaryListWindow = [[DictionaryList alloc] initWithNibName:@"DictionaryList" bundle:nil];
		dictionaryListWindow.dictionaryList = dictionaryList;
		dictionaryListWindow.currentDictionary = &currentDictionary;
	}
	
	dictionaryListWindow.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[[self navigationController] presentModalViewController:dictionaryListWindow animated:YES];
}

- (IBAction)searchFromBolorDictionary:(id)sender
{
	if(bolorDictionary == nil)
		bolorDictionary = [[BolorDictionary alloc] initWithNibName:@"BolorDictionary" bundle:nil];
    
    [[self navigationController] pushViewController:bolorDictionary animated:YES];
    [bolorDictionary search:theSearchBar.text];
}

- (void)loadDictionaryList
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];
	NSArray *tempSections = [NSArray arrayWithContentsOfFile:path];
	NSMutableArray *tempMutableSections = [NSMutableArray arrayWithCapacity:[tempSections count]];

	for(NSArray *temp1 in tempSections)
	{
		NSMutableArray *tempMutableSection = [NSMutableArray arrayWithCapacity:[temp1 count]];
		
		for(NSObject *temp2 in temp1)
			[tempMutableSection addObject:temp2];
		
		[tempMutableSections addObject:[[NSArray alloc] initWithArray:tempMutableSection]];
	}
	
	dictionaryList = [[NSArray alloc] initWithArray:tempMutableSections];
}

- (void)loadDictionary
{
	NSString *dataName = (NSString *)[(NSDictionary *)[(NSArray *)[dictionaryList objectAtIndex:currentDictionary.selectedSectionIndex] objectAtIndex:currentDictionary.selectedDictionaryIndex + 1] valueForKey:@"data"];
	NSString *fileName = [[NSBundle mainBundle] pathForResource:dataName ofType:@""];
	FILE *dataFile;
	int fileSize, i1;
	char *temp;
	int addedColumn = 1;
	
	currentDictionary.wordCount = 0;
	currentDictionary.currentPosition = 0;
	currentDictionary.dictionaryIndex = currentDictionary.selectedDictionaryIndex;
	currentDictionary.sectionIndex = currentDictionary.selectedSectionIndex;
	
	dataFile = fopen([fileName cStringUsingEncoding:NSASCIIStringEncoding], "rb");
	
	if(dataFile == NULL)
		return;

	fseek(dataFile, 0, SEEK_END);
	fileSize = ftell(dataFile);
	if(currentDictionary.data != nil)
		free(currentDictionary.data);
	currentDictionary.data = malloc(fileSize);
	
	if(currentDictionary.data == NULL)
		return;
	
	fseek(dataFile, 0, SEEK_SET);
	fread(currentDictionary.data, fileSize, 1, dataFile);
	fclose(dataFile);
	
	temp = currentDictionary.words[0].word = currentDictionary.data;
	
	for(i1 = 0; i1 < fileSize; i1++)
	{
		if(*temp == 0)
		{
			if(addedColumn == 2)
			{
				currentDictionary.words[currentDictionary.wordCount].word = temp + 1;
				addedColumn = 1;
			} else
			{
				currentDictionary.words[currentDictionary.wordCount].description = temp + 1;
				currentDictionary.wordCount++;
				addedColumn = 2;
			}
		}
		
		temp++;
	}
}

- (void)searchWord:(NSString *)aWord startPostion:(int)startPostion endPosition:(int)endPosition
{
	int middlePosition = (startPostion + endPosition) / 2;
	NSString *middleWord = [NSString stringWithUTF8String:currentDictionary.words[middlePosition].word];
	
	if((endPosition - startPostion) == 1)
	{
		NSString *startWord = [NSString stringWithUTF8String:currentDictionary.words[startPostion].word];
		
		if([startWord localizedCaseInsensitiveCompare:aWord] == NSOrderedAscending)
			currentDictionary.currentPosition = endPosition;
		else
			currentDictionary.currentPosition = startPostion;
		
		return;
	}
	
	if([aWord localizedCaseInsensitiveCompare:middleWord] == NSOrderedAscending)
		[self searchWord:aWord startPostion:startPostion endPosition:middlePosition];
	else if([aWord localizedCaseInsensitiveCompare:middleWord] == NSOrderedDescending)
		[self searchWord:aWord startPostion:middlePosition endPosition:endPosition];
	else
		currentDictionary.currentPosition = middlePosition;
	
	return;
};

- (void)awakeFromNib
{
	NSUserDefaults *configuration = [NSUserDefaults standardUserDefaults];
	int fontSize = [configuration integerForKey:@"fontSize"];

	if(fontSize < 12 || fontSize > 24)
	{
		[configuration setInteger:16 forKey:@"fontSize"];
		[configuration setBool:TRUE forKey:@"showImage"];
		[configuration synchronize];
	}
	
	[self loadDictionaryList];
	currentDictionary.data = nil;
	currentDictionary.selectedDictionaryIndex = 0;
	currentDictionary.selectedSectionIndex = 0;
	[self loadDictionary];
}

- (void)viewDidLoad
{
	// Configure the add button.
    UIBarButtonItem *organizeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showDictionaryList)];
    self.navigationItem.rightBarButtonItem = organizeButton;
    [organizeButton release];

	[super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
	if((currentDictionary.dictionaryIndex != currentDictionary.selectedDictionaryIndex) || (currentDictionary.sectionIndex != currentDictionary.selectedSectionIndex))
		[self loadDictionary];
	
	[listBox reloadData];
	[listBox scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentDictionary.currentPosition inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	[super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return currentDictionary.wordCount;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		cell.textLabel.font = [UIFont systemFontOfSize:20];
    }
    
	// Configure the cell.
	cell.textLabel.text = [NSString stringWithUTF8String:currentDictionary.words[[indexPath row]].word];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	currentDictionary.currentPosition = [indexPath row];
	
	if(infoViewController == nil)
	{
		infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
		infoViewController.currentDictionary = &currentDictionary;
	}
	
	infoViewController.title = (NSString *)[[(NSArray *)[dictionaryList objectAtIndex:currentDictionary.sectionIndex] objectAtIndex:currentDictionary.dictionaryIndex + 1] valueForKey:@"name"];
	[[self navigationController] pushViewController:infoViewController animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = TRUE;
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = FALSE;
	return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
    listBox.frame = CGRectMake(0, 44, 320, 372);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[self searchWord:searchBar.text startPostion:0 endPosition:(currentDictionary.wordCount - 1)];
	[listBox scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentDictionary.currentPosition inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [bolorButton setTitle:[NSString stringWithFormat:@"Болор Толиос \"%@\"-ыг хайх", searchText] forState:UIControlStateNormal];
    [bolorButton setTitle:[NSString stringWithFormat:@"Болор Толиос \"%@\"-ыг хайх", searchText] forState:UIControlStateHighlighted];
    [bolorButton setTitle:[NSString stringWithFormat:@"Болор Толиос \"%@\"-ыг хайх", searchText] forState:UIControlStateSelected];
    
    if([searchText compare:@""] != NSOrderedSame)
        listBox.frame = CGRectMake(0, 84, 320, 332); else
        listBox.frame = CGRectMake(0, 44, 320, 372);

    if([searchText rangeOfString:@"О'"].location != NSNotFound)
        searchBar.text = [searchText stringByReplacingOccurrencesOfString:@"О'" withString:@"Ө"];
    if([searchText rangeOfString:@"о'"].location != NSNotFound)
        searchBar.text = [searchText stringByReplacingOccurrencesOfString:@"о'" withString:@"ө"];
    if([searchText rangeOfString:@"У'"].location != NSNotFound)
        searchBar.text = [searchText stringByReplacingOccurrencesOfString:@"У'" withString:@"Ү"];
    if([searchText rangeOfString:@"у'"].location != NSNotFound)
        searchBar.text = [searchText stringByReplacingOccurrencesOfString:@"у'" withString:@"ү"];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
    listBox.frame = CGRectMake(0, 44, 320, 372);
}

/*
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}
*/


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc
{
	free(currentDictionary.data);
	[infoViewController release];
	[dictionaryList release];
    [super dealloc];
}


@end

