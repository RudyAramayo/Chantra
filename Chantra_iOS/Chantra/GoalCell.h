//
//  GoalCell.h
//  Chantra
//
//  Created by Orbitus on 2/25/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalCell : UITableViewCell

@property (readwrite) IBOutlet UILabel *titleLabel;
@property (readwrite) IBOutlet UILabel *descriptionLabel;
@property (readwrite) IBOutlet UIImageView *goalImageView;
@property (readwrite) IBOutlet UIImageView *progressImageView;
@property (readwrite) IBOutlet UIImageView *progressCompletionView;
@property (readwrite) IBOutlet UIProgressView *daimokuProgressView;
@property (readwrite) IBOutlet UILabel *progressLabel;


@end
