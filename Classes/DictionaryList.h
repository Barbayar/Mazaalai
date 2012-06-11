//
//  DictionaryList.h
//  Dictionary
//
//  Created by Dashzeveg Barbayar on 5/28/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"

@interface DictionaryList : UIViewController
{
	NSArray *dictionaryList;
	struct TDictionary *currentDictionary;
}

@property (readwrite, assign) NSArray *dictionaryList;
@property (readwrite, assign) struct TDictionary *currentDictionary;

@end
