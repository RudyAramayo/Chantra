//
//  ViewController.m
//  Chantra
//
//  Created by Orbitus on 1/25/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import "ViewController.h"

#include <stdlib.h>


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initSound];
    
    // Show the current time label
    [self updateTimerLabel];
    [self initLiturgyWebView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dailyMessage) name:@"DailyEncouragement" object:nil];
    [self dailyMessage];
    
}


- (void) initSound
{
    
    //Init Audio Session Properties
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *activationError = nil;
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    
    BOOL success = [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    if (!success) { /* handle the error in activationError */ }
    
    
    
    //Init Sound Files
    
    
    
    NSString *tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"NamYo_Chant"
                                    ofType: @"m4a"];
    
    namYo_Chant_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Gongyo_Chant"
                                    ofType: @"m4a"];
    
    gongyo_Chant_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Bell1"
                                    ofType: @"m4a"];
    
    bell_1_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Bell1"
                                    ofType: @"m4a"];
    
    bell_2_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Bell1"
                                    ofType: @"m4a"];
    
    bell_3_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Bell1"
                                    ofType: @"m4a"];
    
    bell_4_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Bell1"
                                    ofType: @"m4a"];
    
    bell_5_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Bell1"
                                    ofType: @"m4a"];
    
    bell_Finish_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    tempFilePath =
    [[NSBundle mainBundle] pathForResource: @"Water"
                                    ofType: @"m4a"];
    water_URL = [[NSURL alloc] initFileURLWithPath: tempFilePath];
    
    
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: bell_1_URL
                                           error: nil];
    player1 = newPlayer;
    [player1 prepareToPlay];
    [player1 setDelegate: self];
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: bell_2_URL
                                           error: nil];
    player2 = newPlayer;
    [player2 prepareToPlay];
    [player2 setDelegate: self];
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: bell_3_URL
                                           error: nil];
    player3 = newPlayer;
    [player3 prepareToPlay];
    [player3 setDelegate: self];
    
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: bell_4_URL
                                           error: nil];
    player4 = newPlayer;
    [player4 prepareToPlay];
    [player4 setDelegate: self];
    
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: bell_5_URL
                                           error: nil];
    player5 = newPlayer;
    [player5 prepareToPlay];
    [player5 setDelegate: self];
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: bell_Finish_URL
                                           error: nil];
    playerFinish = newPlayer;
    [playerFinish prepareToPlay];
    [playerFinish setDelegate: self];
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: water_URL
                                           error: nil];
    playerWater = newPlayer;
    [playerWater prepareToPlay];
    [playerWater setDelegate: self];
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: namYo_Chant_URL
                                           error: nil];
    player_NamYo_Chant = newPlayer;
    [player_NamYo_Chant prepareToPlay];
    [player_NamYo_Chant setDelegate: self];
    
    newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: gongyo_Chant_URL
                                           error: nil];
    player_Gongyo_Chant = newPlayer;
    [player_Gongyo_Chant prepareToPlay];
    [player_Gongyo_Chant setDelegate: self];

}


- (void) dailyMessage
{
    NSString *dailyEncouragementURL = @"http://www.sgi.org/sgi-president/daily-encouragement/";
    
    NSString *urlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:dailyEncouragementURL] encoding:NSUTF8StringEncoding error:nil];

    NSString * message;
    
    @try {
        message = [[[[[[urlStr componentsSeparatedByString:@"<div class=\"enc_content\">"]
                                  objectAtIndex:1]
                                 componentsSeparatedByString:@"<p>"]
                                objectAtIndex:1]
                               componentsSeparatedByString:@"</p>"]
                              objectAtIndex:0];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
        
    }
    
    
    if ([message isEqualToString:@""])
    {
        @try {
            message = [[[[[[urlStr componentsSeparatedByString:@"<div class=\"dailyBlock\">"]
                           objectAtIndex:1]
                          componentsSeparatedByString:@"<p>"]
                         objectAtIndex:2]
                        componentsSeparatedByString:@"</p>"]
                       objectAtIndex:0];
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
        }
        @finally {
            
        }
        
    }
    //NSLog(@"message = %@", message);
    
    NSString * author;
    
    @try {
        author = [[[[[[urlStr componentsSeparatedByString:@"<div class=\"enc_content\">"]
                      objectAtIndex:1]
                     componentsSeparatedByString:@"<p><span>"]
                    objectAtIndex:1]
                   componentsSeparatedByString:@"</span></p>"]
                  objectAtIndex:0];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        author = @"Unknown";
    }
    @finally {
        
    }
    
    //NSLog(@"author = %@", author);
    
    message = [message stringByAppendingString:[NSString stringWithFormat:@"\n-%@", author]];
    
    
    if (message)
    {
        id alert = [[UIAlertView alloc] initWithTitle:@"Daily Encouragement" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Share", nil];
        [alert show];
        
        dailyMessage = message;
    }
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //Share Daily Encouragement Message
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = [dailyMessage stringByAppendingString:@"\n\n (Sent with Chantra for iOS)"];
            //controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:^(){}];
        }
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tripleBellAction:(id)sender
{
    [playerFinish play];
}


- (void) initLiturgyWebView
{
    //liturgyWebView.delegate = self;
    
    // we don't want interaction, full size
    liturgyWebView.scalesPageToFit = YES;
    liturgyWebView.userInteractionEnabled = YES;
    liturgyWebView.backgroundColor = [UIColor clearColor];
    
    //fileURL is an NSURL to a PDF file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"prayerbook_large" ofType:@"pdf"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    [liturgyWebView loadRequest:[NSURLRequest requestWithURL:fileURL]];
}


- (IBAction)bellAction:(id)sender
{
    
    int r = arc4random_uniform(5);
    switch (r) {
        case 0:
            NSLog(@"1");
            if (player1.playing) {
                [player1 pause];
            }
            player1.currentTime = 0;
            [player1 play];
            break;
        case 1:
            NSLog(@"2");
            if (player2.playing) {
                [player2 pause];
            }
            player2.currentTime = 0;
            [player2 play];
            break;
        case 2:
            NSLog(@"3");
            if (player3.playing) {
                [player3 pause];
            }
            player3.currentTime = 0;
            [player3 play];
            break;
        case 3:
            NSLog(@"4");
            if (player4.playing) {
                [player4 pause];
            }
            player4.currentTime = 0;
            [player4 play];
            break;
        case 4:
            NSLog(@"5");
            if (player5.playing) {
                [player5 pause];
            }
            player5.currentTime = 0;
            [player5 play];
            break;
        default:
            break;
    }
}


- (IBAction)waterAudioAction:(UISwitch *)sender
{
    if (sender.isOn)
    {
        if (playerWater.playing) {
            [playerWater pause];
        }
        playerWater.currentTime = 0;
        
        [playerWater play];
    }
    else
    {
        [playerWater pause];
    }
}


- (IBAction)gongyoAudioAction:(UISwitch *)sender
{
    if (sender.isOn)
    {
        if (player_Gongyo_Chant.playing) {
            [player_Gongyo_Chant pause];
        }
        player_Gongyo_Chant.currentTime = 0;
        
        [player_Gongyo_Chant play];
        [player_NamYo_Chant pause];
        [namYoSwitch setOn:NO animated:YES];
    }
    else
    {
        [player_Gongyo_Chant pause];
    }
}


- (IBAction)chantAudioAction:(UISwitch *)sender
{
    if (sender.isOn)
    {
        if (player_NamYo_Chant.playing) {
            [player_NamYo_Chant pause];
        }
        player_NamYo_Chant.currentTime = 0;
        
        [player_NamYo_Chant play];
        [player_Gongyo_Chant pause];
        [gongyoSwitch setOn:NO animated:YES];
    }
    else
    {
        [player_NamYo_Chant pause];
    }
}


- (IBAction)timerAction:(id)sender
{
    if (!timerIsRunning)
    {
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"ChantraTimerInSeconds"])
        {
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:0] forKey:@"ChantraTimerInSeconds"];
        }
        timerIsRunning = YES;
        timerStartDate = [NSDate date];
        meditationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
        return;  //Don't go into the next if statement
    }
    if (timerIsRunning)
    {
        [meditationTimer invalidate];
        meditationTimer = nil;
        timerIsRunning = NO;

        
        // Store Final Time Values in User Defaults Dictionary
        int newTimeInSeconds = [[NSDate date] timeIntervalSinceDate:timerStartDate];
        int originalTimeInSeconds = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ChantraTimerInSeconds"] intValue];

        //apply the time into your goals directly
        id myGoals =  [[[NSUserDefaults standardUserDefaults] valueForKey:@"MyGoals"] mutableCopy];

        int i=0;
        for (id goal in [myGoals mutableCopy])
        {
            id newgoal = [goal mutableCopy];
            
            NSInteger daimokuAccumulated = [[goal valueForKey:@"daimokuAccumulated"] integerValue];
            
            daimokuAccumulated += newTimeInSeconds;
            
            [newgoal setValue:[NSString stringWithFormat:@"%li", (long)daimokuAccumulated] forKey:@"daimokuAccumulated"];
            
            NSLog(@"Goal: %@ - %@ -> %@", [goal valueForKey:@"title"], [goal valueForKey:@"daimokuAccumulated"], [newgoal valueForKey:@"daimokuAccumulated"]);
            
            [myGoals replaceObjectAtIndex:i withObject:newgoal];
            i++;
        }
        
        
        [[NSUserDefaults standardUserDefaults] setValue:myGoals forKey:@"MyGoals"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:originalTimeInSeconds + newTimeInSeconds] forKey:@"ChantraTimerInSeconds"];
    }
}


- (IBAction)changeLiturgyAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        liturgyWebView.hidden = NO;
        silentPrayersTextView.hidden = YES;
    }
    if (sender.selectedSegmentIndex == 1)
    {
        liturgyWebView.hidden = YES;
        silentPrayersTextView.hidden = NO;
    }
}


- (IBAction)settingsAction:(id)sender
{
    if (liturgyView.hidden)
    {
        liturgyView.hidden = NO;
    }
    else
    {
        liturgyView.hidden = YES;
    }
}


- (IBAction)resetTimerAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:0] forKey:@"ChantraTimerInSeconds"];
    timerStartDate = nil;
    [self updateTimerLabel];
}


- (void) updateTimerLabel
{
    int newTimeInSeconds = [[NSDate date] timeIntervalSinceDate:timerStartDate];

    if (!timerStartDate)
        newTimeInSeconds = 0;

    int originalTimeInSeconds = [[[NSUserDefaults standardUserDefaults] valueForKey:@"ChantraTimerInSeconds"] intValue];
    
    int elapsedSeconds = originalTimeInSeconds + newTimeInSeconds;
    
    NSUInteger h = elapsedSeconds / 3600;
    NSUInteger m = (elapsedSeconds / 60) % 60;
    NSUInteger s = elapsedSeconds % 60;
    
    NSString *formattedTime = [NSString stringWithFormat:@"%u:%02u:%02u", h, m, s];
    timerLabel.text = formattedTime;
    
}


#pragma mark - AVAudioPlayerDelegate


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    if (player == playerWater ||
        player == player_Gongyo_Chant ||
        player == player_NamYo_Chant )
    {
        [player play];
    }
}


@end
