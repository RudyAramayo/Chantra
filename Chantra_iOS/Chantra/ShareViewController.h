//
//  ShareViewController.h
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ShareViewController : UIViewController <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
{
    IBOutlet UIDatePicker *daimokuDatePicker;
}

- (IBAction)messageAction:(id)sender;
- (IBAction)emailAction:(id)sender;
- (IBAction)facebookAction:(id)sender;
- (IBAction)twitterAction:(id)sender;

- (IBAction)doneAction:(id)sender;

@end
