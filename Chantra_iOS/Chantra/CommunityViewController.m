//
//  CommunityViewController.m
//  Chantra
//
//  Created by Orbitus on 2/22/15.
//  Copyright (c) 2015 SGI. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneAction:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){}];
}


#pragma mark - UITableViewDelegate/Datasource


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityCell"];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Daily Encouragement =)";
            break;
        case 1:
            cell.textLabel.text = @"SGI-USA";
            break;
        case 2:
            cell.textLabel.text = @"Soka Gakkai International";
            break;
        case 3:
            cell.textLabel.text = @"Words of Wisdom";
            break;
        case 4:
            cell.textLabel.text = @"SGI Quarterly";
            break;
        case 5:
            cell.textLabel.text = @"Tsunesaburo Makiguchi";
            break;
        case 6:
            cell.textLabel.text = @"Josei Toda";
            break;
        case 7:
            cell.textLabel.text = @"Daisaku Ikeda";
            break;
        case 8:
            cell.textLabel.text = @"Writings of Nichiren Daishonin";
            break;
        case 9:
            cell.textLabel.text = @"SGI YouTube Channel";
            break;
        case 10:
            cell.textLabel.text = @"SGI Buddhism Dictionary";
            break;
        case 11:
            cell.textLabel.text = @"Video for SGI Youth";
            break;
            
        default:
            break;
    }

    if( [indexPath row] % 2)
        [cell setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0]];
    else
        [cell setBackgroundColor:[UIColor whiteColor]];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            //cell.textLabel.text = @"Daily Encouragement =)";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DailyEncouragement" object:nil];
            break;
        case 1:
            //cell.textLabel.text = @"SGI-USA";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sgi-usa.org/"]];
            break;
        case 2:
            //cell.textLabel.text = @"Soka Gakkai International";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sgi.org/"]];
            break;
        case 3:
            //cell.textLabel.text = @"Words of Wisdom";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ikedaquotes.org/"]];
            break;
        case 4:
            //cell.textLabel.text = @"SGI Quarterly";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sgiquarterly.org/"]];
            break;
        case 5:
            //cell.textLabel.text = @"Tsunesaburo Makiguchi";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.tmakiguchi.org/"]];
            break;
        case 6:
            //cell.textLabel.text = @"Josei Toda";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.joseitoda.org/"]];
            break;
        case 7:
            //cell.textLabel.text = @"Daisaku Ikeda";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.daisakuikeda.org/"]];
            break;
        case 8:
            //cell.textLabel.text = @"Writings of Nichiren Daishonin";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nichirenlibrary.org/"]];
            break;
        case 9:
            //cell.textLabel.text = @"SGI YouTube Channel";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/user/SGIVideosOnline"]];
            break;
        case 10:
            //cell.textLabel.text = @"SGI Buddhism Dictionary";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nichirenlibrary.org/en/dic/toc/"]];
            break;
        case 11:
            //cell.textLabel.text = @"Video for SGI Youth";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/watch?v=3VEMHWnewuc"]];
            break;
            
            
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
