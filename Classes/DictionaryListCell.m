//
//  DictionaryListCell.m
//  Dictionary
//
//  Created by Dashzeveg Barbayar on 5/29/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "DictionaryListCell.h"

@implementation DictionaryListCell

@synthesize textLabel1, detailTextLabel1, imageView1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
        textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 230, 20)];
		textLabel1.font = [UIFont boldSystemFontOfSize:20];
        textLabel1.backgroundColor = [UIColor clearColor];
		textLabel1.textAlignment = UITextAlignmentRight;
		detailTextLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 280, 0)];
		detailTextLabel1.font = [UIFont systemFontOfSize:13];
        detailTextLabel1.backgroundColor = [UIColor clearColor];
		detailTextLabel1.textAlignment = UITextAlignmentCenter;
		detailTextLabel1.numberOfLines = 0;
		imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
		
		[self.contentView addSubview:textLabel1];
		[self.contentView addSubview:detailTextLabel1];
		[self.contentView addSubview:imageView1];
		
		[textLabel1 release];
		[detailTextLabel1 release];
		[imageView1 release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
