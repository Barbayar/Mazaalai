/*
 *  Structures.h
 *  Mazaalai
 *
 *  Created by Dashzeveg Barbayar on 10/21/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */
#define MAX_WORD 75000

struct TWord
{
	char *word;
	char *description;
};

struct TDictionary
{
	char *data;
	int wordCount, currentPosition, dictionaryIndex, selectedDictionaryIndex, sectionIndex, selectedSectionIndex;
	struct TWord words[MAX_WORD];
};
