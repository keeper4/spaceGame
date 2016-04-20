//
//  ACGameOverController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACGameOverController.h"
#import <AVFoundation/AVFoundation.h>
#import "ACStartViewController.h"

@interface ACGameOverController ()

@end

@implementation ACGameOverController

AVAudioPlayer *audioPlayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    
    if (highScore < self.score) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"HighScore"];
    }
    
    self.mineBestScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)highScore];
    
    
    
    
    self.scoreLable.text = [NSString stringWithFormat:@"%ld", (long)self.score];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameOver3" ofType:@"mp3"]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    audioPlayer.volume = 1.0;
    
    [audioPlayer play];
}


- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (IBAction)actionTryAgainButton:(UIButton *)sender {
    
    UIViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ACSceneViewController"];
    
    if ([ACStartViewController audioPlayer].playing) {
        [ACStartViewController audioPlayer].volume = 1.0;
    }
    
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
}

- (IBAction)actionExitButton:(UIButton *)sender {
    exit(0);
}
@end
