//
//  GoalDetailViewController.h
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalDetailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UITextField *titleTextField;
    IBOutlet UITextField *daimokuTextField;
    IBOutlet UITextField *goalDateTextField;

    IBOutlet UITextView *descriptionTextView;
    IBOutlet UITextView *ikedaQuoteTextView;
    
    
    CGPoint originalCenter;
    NSDate *goalDate;
}
@property (readwrite) NSIndexPath *selectedIndexPath;
@property (readwrite) IBOutlet UIProgressView *daimokuProgressView;
@property (readwrite) IBOutlet UILabel *progressLabel;

- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)photoAction:(id)sender;


@end
