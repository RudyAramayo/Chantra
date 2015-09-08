//
//  ProgressBarImageView.m
//  MyMeds
//
//  Created by Rodolfo Aramayo on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ProgressBarImageView.h"

@implementation ProgressBarImageView

- (void) awakeFromNib
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.image = [[UIImage imageNamed:@"progress-indicator@2x.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:4];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        self.image = [[UIImage imageNamed:@"progress-indicator.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:6];
    }
}

@end
