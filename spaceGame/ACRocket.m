//
//  ACRocket.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACRocket.h"

@implementation ACRocket

- (void)createRocketShipMidX:(CGFloat)shipMidX shipMinY:(CGFloat)shipMinY {
    
    CGFloat rocketWidth = 20;
    CGFloat rocketHeight = 30;
    
    self.frame = CGRectMake(shipMidX, shipMinY, rocketWidth, rocketHeight);
    
    self.backgroundColor = [UIColor redColor];
    
    
    [UIImageView animateWithDuration:2.f
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(shipMidX, -rocketHeight);
                              
                          } completion:^(BOOL finished) {
                              
                              
                          }];
    
}

- (void)createRocketFromShip:(UIView *)ship withDuration:(NSTimeInterval)duration {
    
    CGFloat rocketWidth = 20;
    CGFloat rocketHeight = 30;
    
    self.frame = CGRectMake(CGRectGetMidX(ship.frame), CGRectGetMinY(ship.frame), rocketWidth, rocketHeight);
    
    self.backgroundColor = [UIColor redColor];
    
    
    [UIImageView animateWithDuration:duration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(CGRectGetMidX(ship.frame), -rocketHeight);
                              
                          } completion:^(BOOL finished) {
                              
                              [self createRocketFromShip:ship withDuration:duration];
                              
                          }];
    
}

@end
