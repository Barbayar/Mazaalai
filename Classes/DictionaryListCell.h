//
//  DictionaryListCell.h
//  Dictionary
//
//  Created by Dashzeveg Barbayar on 5/29/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DictionaryListCell : UITableViewCell
{
	UILabel *textLabel1;
	UILabel *detailTextLabel1;
	UIImageView *imageView1;
}

@property (readwrite, assign) UILabel *textLabel1;
@property (readwrite, assign) UILabel *detailTextLabel1;
@property (readwrite, assign) UIImageView *imageView1;

@end
