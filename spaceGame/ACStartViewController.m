//
//  ACStartViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 3/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACStartViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation ACStartViewController

    AVAudioPlayer *audioPlayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    UIImageView *startViewBackground = [[UIImageView alloc] initWithFrame:screen];
    
    startViewBackground.image = [UIImage imageNamed:@"background"];
    
    startViewBackground.layer.zPosition = -1;
    
    [self.view addSubview:startViewBackground];
    
    [self checkStateSwitchSound];
    
    
    [self createPlayer];
    
}

#pragma mark - privateMethod

- (void)createPlayer {
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SuperBonk_TwilightSpace" ofType:@"mp3"]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    audioPlayer.volume = 1.0;
    
    if (self.musicSwitch.isOn) {
        [audioPlayer play];
    }
}

- (void)checkStateSwitchSound {
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"switch"]isEqualToString:@"on"] && self.musicSwitch.isOn) {
        
        self.musicSwitch.on = YES;
        
    }
    else {
        self.musicSwitch.on = NO;
    }
}

#pragma mark - Action

- (IBAction)actionMusicSwitch:(UISwitch *)sender {
    
    if (sender.isOn) {
        
        [audioPlayer play];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"on" forKey:@"switch"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    } else {
        [audioPlayer pause];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"off" forKey:@"switch"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (IBAction)actionExitButton:(UIButton *)sender {

    exit(0);
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
