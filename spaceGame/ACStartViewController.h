//
//  ACStartViewController.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 3/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ACStartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *musicSwitch;

- (IBAction)actionMusicSwitch:(UISwitch *)sender;
- (IBAction)actionExitButton:(UIButton *)sender;

+ (AVAudioPlayer *)audioPlayer;
@end
