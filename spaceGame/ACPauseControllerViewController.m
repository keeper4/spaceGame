//
//  ACPauseControllerViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACPauseControllerViewController.h"
#import "ACStartViewController.h"

@interface ACPauseControllerViewController ()

@end

@implementation ACPauseControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)actionResumeButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)actionRestartButton:(UIButton *)sender {
    
  //  [[ACStartViewController audioPlayer]play];
    
    UIViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ACSceneViewController"];
    
    [monitorMenuViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:monitorMenuViewController animated:YES completion:nil];
    
}
- (IBAction)actionMainButton:(UIButton *)sender {

    [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
}


- (BOOL)prefersStatusBarHidden {
    
    return YES;
}
@end
