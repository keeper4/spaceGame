//
//  ACRocket.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACRocket.h"

@implementation ACRocket

- (void)createRocketFromShip:(UIView *)ship withDuration:(NSTimeInterval)duration {
    
    CGFloat rocketWidth = 20;
    CGFloat rocketHeight = 30;
    
    self.frame = CGRectMake(CGRectGetMidX(ship.frame)-rocketWidth/2, CGRectGetMinY(ship.frame)-rocketHeight, rocketWidth, rocketHeight);
    
    self.backgroundColor = [UIColor redColor];
    
    
    [UIImageView animateWithDuration:duration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(CGRectGetMidX(ship.frame), - rocketHeight);
                              
                          } completion:^(BOOL finished) {
                              
                              [self createRocketFromShip:ship withDuration:duration];
                              
                          }];
    
}

@end
