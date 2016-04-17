//
//  ACPauseControllerViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACPauseControllerViewController.h"
#import "ACStartViewController.h"
#import "AppDelegate.h"

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

    
}
- (IBAction)actionMainButton:(UIButton *)sender {

    [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
}
@end
