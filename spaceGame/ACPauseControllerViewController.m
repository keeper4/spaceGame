//
//  ACPauseControllerViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACPauseControllerViewController.h"

@interface ACPauseControllerViewController ()

@end

@implementation ACPauseControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    UIImageView *pauseViewBackground = [[UIImageView alloc] initWithFrame:screen];
    
    pauseViewBackground.image = [UIImage imageNamed:@"background"];
    
    pauseViewBackground.layer.zPosition = -1;
    
    [self.view addSubview:pauseViewBackground];
    
    
    
}



- (IBAction)actionResumeButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)actionRestartButton:(UIButton *)sender {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACSceneViewController"];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
    
    

    
    
}
- (IBAction)actionMainButton:(UIButton *)sender {
    
}
@end
