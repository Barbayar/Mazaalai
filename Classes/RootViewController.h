//
//  RootViewController.h
//  Mazaalai
//
//  Created by Dashzeveg Barbayar on 10/4/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Structures.h"
#import "InfoViewController.h"
#import "DictionaryList.h"
#import "BolorDictionary.h"

@interface RootViewController : UIViewController {
@private
	IBOutlet UISearchBar *theSearchBar;
	IBOutlet UITableView *listBox;
    IBOutlet UIButton *bolorButton;
	InfoViewController *infoViewController;
	DictionaryList *dictionaryListWindow;
    BolorDictionary *bolorDictionary;

	NSArray *dictionaryList;
	struct TDictionary currentDictionary;
}

- (IBAction)showDictionaryList;
- (IBAction)searchFromBolorDictionary:(id)sender;
@end
