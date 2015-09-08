//
//  ShareViewController.m
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>

@interface ShareViewController ()

@end

@implementation ShareViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated
{
    int originalTimeInSeconds = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ChantraTimerInSeconds"] intValue];
    daimokuDatePicker.countDownDuration = originalTimeInSeconds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneAction:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){}];
}


- (NSString *) generateDaimokuMessage
{
    int countdownInSeconds = daimokuDatePicker.countDownDuration;
    
    NSUInteger h = countdownInSeconds / 3600;
    NSUInteger m = (countdownInSeconds / 60) % 60;
    NSUInteger s = countdownInSeconds % 60;
    
    NSString *formattedTime = [NSString stringWithFormat:@"%u:%02u:%02u", h, m, s];
    
    return [NSString stringWithFormat:@"I'm sending you these Daimoku (time: %@) today.\n\nThis message composed by Chantra on iOS", formattedTime];
}


- (IBAction)messageAction:(id)sender
{
    //Share Daily Encouragement Message
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [self generateDaimokuMessage];
        //controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:^(){}];
    }

}


- (IBAction)emailAction:(id)sender
{
    MFMailComposeViewController* mc = [[MFMailComposeViewController alloc] init];
    //set delegate
    mc.mailComposeDelegate = self;
    
    //set message body
    [mc setMessageBody:[self generateDaimokuMessage] isHTML:NO];
    //set message subject
    [mc setSubject:@"Daimoku 4 U"];
        
    [self presentViewController:mc animated:YES completion:^(){}];

}


- (IBAction)facebookAction:(id)sender
{
    //if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[self generateDaimokuMessage]];
        //[controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
        //[controller addImage:[UIImage imageNamed:@"socialsharing-facebook-image.jpg"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
    //}
}


- (IBAction)twitterAction:(id)sender
{
    //if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    //{
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[self generateDaimokuMessage]];
        //[tweetSheet addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
        //[tweetSheet addImage:[UIImage imageNamed:@"socialsharing-facebook-image.jpg"]];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    //}
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)
{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

@end
