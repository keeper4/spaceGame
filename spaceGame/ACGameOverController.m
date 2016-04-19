//
//  ACGameOverController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACGameOverController.h"
#import <AVFoundation/AVFoundation.h>

@interface ACGameOverController ()

@end

@implementation ACGameOverController

AVAudioPlayer *audioPlayer;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scoreLable.text = [NSString stringWithFormat:@"%ld", (long)self.score];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gameOver3" ofType:@"mp3"]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    audioPlayer.volume = 1.0;
    
    [audioPlayer play];
    
}


- (BOOL)prefersStatusBarHidden {
    
    return YES;
}


@end
