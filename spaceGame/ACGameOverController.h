//
//  ACGameOverController.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACGameOverController : UIViewController

@property (assign, nonatomic) NSInteger score;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *mineBestScoreLabel;

@end
