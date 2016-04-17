//
//  ACEnemy.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 20/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACEnemy.h"

NSString * const enemyShipFinishedFlyNotification = @"enemyShipFinishedFlyNotification";

@interface ACEnemy()

@end

@implementation ACEnemy

static NSUInteger flyStep = 5;

#define screenHeight  ([[UIScreen mainScreen] bounds].size.height)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self makeShip];
    }
    return self;
}

- (void) makeShip {
    
    CGFloat widthShip = 50;
    CGFloat heigthShip = 70;
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.frame = CGRectMake(CGRectGetMidX(screen) - widthShip/2,
                            CGRectGetMinY(screen) + 20,
                            widthShip,
                            heigthShip);
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.zPosition = 1;
    
    self.image = [UIImage imageNamed:@"enemy"];
    
    self.lifeQuantity = 1;
    
    [self moveShipWithDuration:0.04f];
}

- (void)moveShipWithDuration:(NSTimeInterval)duration {
    
    [UIImageView animateWithDuration:duration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + flyStep);
                              
                          } completion:^(BOOL finished) {
                              
                              NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                              
                              if (!self.isHit && CGRectGetMinY(self.frame) < screenHeight) {
                                  
                                  [self moveShipWithDuration:duration];
                                  
                              } else if (!self.isHit && CGRectGetMinY(self.frame) >= screenHeight) {
                                  
                                  [center postNotificationName:enemyShipFinishedFlyNotification object:nil];
                                  
                              }
                              
                          }];
    
}


@end
