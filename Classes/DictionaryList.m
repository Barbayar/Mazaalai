//
//  DictionaryList.m
//  Dictionary
//
//  Created by Dashzeveg Barbayar on 5/28/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "DictionaryList.h"
#import "DictionaryListCell.h"

@implementation DictionaryList
@synthesize dictionaryList, currentDictionary;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
- (void)viewDidLoad
{
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dictionaryList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return (NSString *)[(NSArray *)[dictionaryList objectAtIndex:section] objectAtIndex:0];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [(NSArray *)[dictionaryList objectAtIndex:section] count] - 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *dictionaryDescription = (NSString *)[(NSDictionary *)[(NSArray *)[dictionaryList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row] + 1] valueForKey:@"description"];
	CGSize suggestedSize = [dictionaryDescription sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(280, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	return suggestedSize.height + 70;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DictionaryListCell *cell = (DictionaryListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	NSString *iconPath = (NSString *)[(NSDictionary *)[(NSArray *)[dictionaryList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row] + 1] valueForKey:@"icon"];
	iconPath = [[NSBundle mainBundle] pathForResource:iconPath ofType:@""];
	CGRect tempRect;
	
    if (cell == nil)
	{
        cell = [[[DictionaryListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.imageView1.image = [UIImage imageWithContentsOfFile:iconPath];
	cell.textLabel1.text = (NSString *)[(NSDictionary *)[(NSArray *)[dictionaryList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row] + 1] valueForKey:@"name"];
	cell.detailTextLabel1.text = (NSString *)[(NSDictionary *)[(NSArray *)[dictionaryList objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row] + 1] valueForKey:@"description"];
	[cell.detailTextLabel1 sizeToFit];
	tempRect = cell.detailTextLabel1.frame;
	tempRect.size.width = 280;
	cell.detailTextLabel1.frame = tempRect;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	(*currentDictionary).selectedSectionIndex = [indexPath section];
	(*currentDictionary).selectedDictionaryIndex = [indexPath row];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    [super dealloc];
}


@end
