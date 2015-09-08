//
//  GoalsViewController.h
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *goalsTableView;
    int deleteRowIndex;
    NSIndexPath *selectedIndexPath;
}

- (IBAction)doneAction:(id)sender;
- (IBAction)addGoalAction:(id)sender;


@end
