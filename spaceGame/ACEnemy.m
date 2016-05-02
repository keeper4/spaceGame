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

@property (strong, nonatomic) NSMutableArray *arrayY;
@end

@implementation ACEnemy

static NSUInteger flyStep = 5;
static CGFloat widthShip = 40;
static CGFloat heigthShip = 50;

#define screenHeight    CGRectGetHeight([[UIScreen mainScreen] bounds])
#define screenWidth     CGRectGetWidth([[UIScreen mainScreen] bounds])

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self makeShip];
    }
    return self;
}

- (void)arrayEnemyX {
    
    self.arrayY = [NSMutableArray array];
    
    for (NSInteger i = widthShip; i <= screenWidth; i += 30) {
        
        NSNumber *anumber = [NSNumber numberWithInteger:i];
        
        [self.arrayY addObject:anumber];
    }
}

- (void) makeShip {
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    [self arrayEnemyX];
    
    NSNumber *randX = [self.arrayY objectAtIndex:arc4random_uniform(9)];
    
    self.frame = CGRectMake([randX floatValue] - widthShip/2,
                            CGRectGetMinY(screen) + 20,
                            widthShip,
                            heigthShip);
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.zPosition = 1;
    
    self.image = [UIImage imageNamed:@"enemy"];
    
    self.lifeQuantity = 1;
    
}

- (void)moveShipWithDuration:(NSTimeInterval)duration {
    
    [UIImageView animateWithDuration:duration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + flyStep);
                              
                          } completion:^(BOOL finished) {
                              
                              NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                              
                              if (self.isPaused) {
                              
                                  return;
                              
                              } else if (!self.isHit && CGRectGetMinY(self.frame) < screenHeight) {
                                  
                                  [self moveShipWithDuration:duration];
                                  
                              } else if (!self.isHit && CGRectGetMinY(self.frame) >= screenHeight) {
                                  
                                  [center postNotificationName:enemyShipFinishedFlyNotification object:nil];
                                  
                              }
                              
                          }];
    
}


@end
