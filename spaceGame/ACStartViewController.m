//
//  ACStartViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 3/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACStartViewController.h"

@implementation ACStartViewController

+ (AVAudioPlayer *)audioPlayer {
    
    static AVAudioPlayer *audioPlayer = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SuperBonk_TwilightSpace" ofType:@"mp3"]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        audioPlayer.volume = 1.0;
    });
    
    return audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkStateSwitchSound];
    
    [self startPlayer];
}

#pragma mark - privateMethod

- (void)startPlayer {

    if (self.musicSwitch.isOn) {
        [[ACStartViewController audioPlayer] play];
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
        
      [[ACStartViewController audioPlayer] play];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"on" forKey:@"switch"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    } else {
     [[ACStartViewController audioPlayer] pause];
        
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
