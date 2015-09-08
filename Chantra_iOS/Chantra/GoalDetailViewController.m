//
//  GoalDetailViewController.m
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import "GoalDetailViewController.h"

#include <stdlib.h> //for arc4rand function

@interface GoalDetailViewController ()

@end

@implementation GoalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    originalCenter = self.view.center;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    daimokuTextField.inputAccessoryView = numberToolbar;
    
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [goalDateTextField setInputView:datePicker];
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelGoalDatePicker)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneWithGoalDatePicker)],
                           nil];
    [numberToolbar sizeToFit];
    goalDateTextField.inputAccessoryView = numberToolbar;
    
}


- (void) viewWillAppear:(BOOL)animated
{
    ikedaQuoteTextView.text = [self success_quote];
    [ikedaQuoteTextView scrollRangeToVisible:NSMakeRange(0, 1)];

    /*
     id myGoals = [[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] mutableCopy];
     
     [myGoals addObject:@{
            @"title": @"My Life Goal",
            @"description": @"I want to be happy in life!",
            @"daimokuGoal": @"10000",
            @"daimokuAccumulated": @"0",
            @"startDate": [NSDate date],
            @"goalDate": [NSDate dateWithTimeIntervalSinceNow:60*60*24*30]}];
     
     [[NSUserDefaults standardUserDefaults] setValue:myGoals forKey:@"MyGoals"];
     */
    
    id myGoals =  [[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"];
    
    if (self.selectedIndexPath)
    {
        id selectedGoal = [myGoals objectAtIndex:self.selectedIndexPath.row];
    
    
        titleTextField.text = [selectedGoal valueForKey:@"title"];
        daimokuTextField.text = [selectedGoal valueForKey:@"daimokuGoal"];
        descriptionTextView.text = [selectedGoal valueForKey:@"description"];
        daimokuTextField.text = [selectedGoal valueForKey:@"daimokuGoal"];
    
        
        float daimokuAccumulated = [[selectedGoal valueForKey:@"daimokuAccumulated"] floatValue];
        float targetGoalDaimoku = [[selectedGoal valueForKey:@"daimokuGoal"] floatValue];
        if (targetGoalDaimoku != 0.0)
        {
            self.progressLabel.text = [NSString stringWithFormat:@"%i%%", (int)((daimokuAccumulated/targetGoalDaimoku)*100)];
            self.daimokuProgressView.progress = daimokuAccumulated/targetGoalDaimoku;
        }
        else{
            self.progressLabel.text = @"0%";
            self.daimokuProgressView.progress = 0.0;
        }
    }
    else{
        self.progressLabel.text = @"0%";
        self.daimokuProgressView.progress = 0.0;
    }
    
    
    
}


- (NSString *)success_quote
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Success_quotes" ofType:@"txt"];
    
    NSArray *quotes = [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n\n"];

    int r = arc4random_uniform(quotes.count);
    
    return [[quotes objectAtIndex:r] stringByAppendingString:@"\n-Daisaku Ikeda"];
}


- (void) photoAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Choose Existing Photo", nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if (buttonIndex == 0)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    if (buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:picker animated:YES completion:^(){}];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //[picker dismissViewControllerAnimated:YES completion:^(){}];
    //imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)goalDateTextField.inputView;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    goalDateTextField.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:picker.date]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)cancelNumberPad
{
    [daimokuTextField resignFirstResponder];
    daimokuTextField.text = @"";

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    self.view.center = originalCenter;

    [UIView commitAnimations];
}


-(void)doneWithNumberPad
{
    [daimokuTextField resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    self.view.center = originalCenter;
    
    [UIView commitAnimations];
}


-(void)cancelGoalDatePicker
{
    [goalDateTextField resignFirstResponder];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.view.center = originalCenter;
    
    [UIView commitAnimations];
}


-(void)doneWithGoalDatePicker
{
    [goalDateTextField resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.view.center = originalCenter;
    
    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)cancelAction:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:^(){}];
}


- (IBAction)saveAction:(id)sender
{

    if (!self.selectedIndexPath)
    {
        NSLog(@"Create New Mode");
        //if we are in create new mode:
        id myGoals = [[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] mutableCopy];
        [myGoals addObject:@{@"title": titleTextField.text,
                             @"description": descriptionTextView.text,
                             @"daimokuAccumulated": @0,
                             @"daimokuGoal": daimokuTextField.text,
                             @"goalDate": [NSDate dateWithTimeIntervalSinceNow:60*60*24*30]}];
        [[NSUserDefaults standardUserDefaults] setValue:myGoals forKey:@"MyGoals"];
    }
    else
    {
        NSLog(@"Edit Mode");
        //if we are in edit mode:
        id myGoals = [[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] mutableCopy];
        id goal = [[myGoals objectAtIndex:self.selectedIndexPath.row] mutableCopy];
        
        [goal setValue:titleTextField.text forKey:@"title" ];
        [goal setValue:descriptionTextView.text forKey:@"description"];
        [goal setValue:daimokuTextField.text forKey:@"daimokuGoal"];
        [goal setValue:goalDateTextField.text forKey:@"goalDate"];
        
        [myGoals replaceObjectAtIndex:self.selectedIndexPath.row withObject:goal];

        [[NSUserDefaults standardUserDefaults] setValue:myGoals forKey:@"MyGoals"];
    }
    
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:^(){}];

}


#pragma mark - UITextFieldDelegate


- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == goalDateTextField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)
            self.view.center = CGPointMake(originalCenter.x, 20);
        
        [UIView commitAnimations];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == daimokuTextField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
     
        if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)
            self.view.center = CGPointMake(originalCenter.x, 80);
        
        [UIView commitAnimations];
    }
    if (textField == goalDateTextField)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)
            self.view.center = CGPointMake(originalCenter.x, 20);
        
        [UIView commitAnimations];
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == titleTextField)
    {
        [titleTextField resignFirstResponder];
    }

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.view.center = originalCenter;
    
    [UIView commitAnimations];

    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.view.center = originalCenter;
    
    [UIView commitAnimations];
    return YES;
}


#pragma mark - UITextViewDelegate


- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}


- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

@end
