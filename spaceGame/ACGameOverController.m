//
//  ACGameOverController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 17/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACGameOverController.h"

@interface ACGameOverController ()

@end

@implementation ACGameOverController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.scoreLable.text = [NSString stringWithFormat:@"%ld", (long)self.score];
    
}





@end
