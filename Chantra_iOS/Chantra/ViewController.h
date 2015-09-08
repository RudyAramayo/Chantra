//
//  ViewController.h
//  Chantra
//
//  Created by Orbitus on 1/25/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>


@interface ViewController : UIViewController <AVAudioPlayerDelegate, MFMessageComposeViewControllerDelegate>
{
    
    NSURL *bell_1_URL;
    NSURL *bell_2_URL;
    NSURL *bell_3_URL;
    NSURL *bell_4_URL;
    NSURL *bell_5_URL;
    NSURL *bell_Finish_URL;
    NSURL *water_URL;
    NSURL *namYo_Chant_URL;
    NSURL *gongyo_Chant_URL;

    AVAudioPlayer *player_NamYo_Chant;
    AVAudioPlayer *player_Gongyo_Chant;
    
    IBOutlet UISwitch *gongyoSwitch;
    IBOutlet UISwitch *waterSwitch;
    IBOutlet UISwitch *namYoSwitch;
    
    AVAudioPlayer *player1;
    AVAudioPlayer *player2;
    AVAudioPlayer *player3;
    AVAudioPlayer *player4;
    AVAudioPlayer *player5;
    AVAudioPlayer *playerFinish;
    AVAudioPlayer *playerWater;
    
    NSDate *timerStartDate;
    NSTimer *meditationTimer;
    BOOL timerIsRunning;
    IBOutlet UILabel *timerLabel;
    
    
    IBOutlet UIView *liturgyView;
    
    IBOutlet UITextView *silentPrayersTextView;
    IBOutlet UIWebView *liturgyWebView;
    NSString *dailyMessage;
    
    
}

- (IBAction)bellAction:(id)sender;
- (IBAction)settingsAction:(id)sender;
- (IBAction)waterAudioAction:(id)sender;
- (IBAction)gongyoAudioAction:(id)sender;
- (IBAction)chantAudioAction:(id)sender;

- (IBAction)timerAction:(id)sender;
- (IBAction)changeLiturgyAction:(id)sender;
@end

