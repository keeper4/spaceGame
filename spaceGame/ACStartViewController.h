//
//  ACStartViewController.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 3/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACStartViewController : UIViewController

- (IBAction)actionMusicSwitch:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *musicSwitch;

@end