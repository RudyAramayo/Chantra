//
//  GoalsViewController.m
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import "GoalsViewController.h"
#import "GoalDetailViewController.h"
#import "GoalCell.h"


@interface GoalsViewController ()

@end

@implementation GoalsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:[NSArray array] forKey:@"MyGoals"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneAction:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){}];
}


- (IBAction)addGoalAction:(id)sender
{
    id myGoals = [[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] mutableCopy];
    [myGoals addObject:@{@"title": @"My Life Goal",
                         @"description": @"I want to be happy in life!",
                         @"daimokuGoal": @"10000",
                         @"daimokuAccumulated": @"0",
                         @"startDate": [NSDate date],
                         @"goalDate": [NSDate dateWithTimeIntervalSinceNow:60*60*24*30]}];
    [[NSUserDefaults standardUserDefaults] setValue:myGoals forKey:@"MyGoals"];
    [goalsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
- (void) evaluateProgress:(NSNotification *)notification
{
    int selectedProfileIndex = [[[notification userInfo] valueForKey:@"SelectedProfileIndex"] intValue];
    float progress = 0.5; //50%

    if (progress >= 1.0)
        completionFinishedOverlay.hidden = NO;
    else
        completionFinishedOverlay.hidden = YES;
        
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.33];
    
    completionPercentageLabel.text = [[NSString stringWithFormat:@"%.0f", progress*100] stringByAppendingString:@"%"];
    progressBarImage.frame = CGRectMake(progressBarImage.frame.origin.x, progressBarImage.frame.origin.y, 15 + progress*132, 14);
    
    [UIView commitAnimations];
    
}
*/


#pragma mark - UITableViewDelegate/Datasource Methods


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger) tableView:tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalCell"];
    
    id myGoals = [[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"];
    id targetGoal = [myGoals objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [[myGoals objectAtIndex:indexPath.row] valueForKey:@"title"];    
    cell.descriptionLabel.text = [[myGoals objectAtIndex:indexPath.row] valueForKey:@"description"];
    float daimokuAccumulated = [[targetGoal valueForKey:@"daimokuAccumulated"] floatValue];
    float targetGoalDaimoku = [[targetGoal valueForKey:@"daimokuGoal"] floatValue];
    
    if (targetGoalDaimoku != 0.0)
    {
        cell.daimokuProgressView.progress = daimokuAccumulated / targetGoalDaimoku;
        cell.progressLabel.text = [NSString stringWithFormat:@"%i%%", (int)((daimokuAccumulated/targetGoalDaimoku)*100)];
    }
    else
    {
        cell.daimokuProgressView.progress = 0.0;
        cell.progressLabel.text = @"0%";
    }
    
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoalDetailViewController *goalDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"GoalDetailViewController"];
    selectedIndexPath = indexPath;
    goalDetailViewController.selectedIndexPath = selectedIndexPath;
    [self.navigationController pushViewController:goalDetailViewController animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        id alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this goal?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
        
        deleteRowIndex = indexPath.row;
    }
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) //YES
    {
        id myGoals = [[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] mutableCopy];
        [myGoals removeObjectAtIndex:deleteRowIndex];
        [[NSUserDefaults standardUserDefaults] setValue:myGoals forKey:@"MyGoals"];
        [goalsTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:deleteRowIndex inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddGoal"])
    {
        GoalDetailViewController *destinationViewController = (GoalDetailViewController *)segue.destinationViewController;
        destinationViewController.selectedIndexPath = nil;
    }
}





@end
