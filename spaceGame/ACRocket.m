//
//  ACRocket.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACRocket.h"

NSString * const shipRocketFinishedFlyNotification = @"shipRocketFinishedFlyNotification";
NSString * const enemyRocketFinishedFlyNotification = @"enemyRocketFinishedFlyNotification";

NSString * const rocketCurrentPositionNotification = @"rocketCurrentPositionNotification";

@implementation ACRocket

static NSUInteger flyStep = 10;
static NSUInteger height = 15;
static NSUInteger width = 10;
static CGFloat shotDuration = 0.03f;
static CGFloat shotEnemyDuration = 0.04f;

#define screenHeight    CGRectGetHeight([[UIScreen mainScreen] bounds])


- (instancetype)initWithShipView:(UIView *)shipView {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(CGRectGetMidX(shipView.frame) - width/2, CGRectGetMinY(shipView.frame) - height, width, height);
        
        self.image = [UIImage imageNamed:@"redRocket"];
        
        self.owner = ACRocketOwnerSpaceShip;
        
        [self moveRocket];
    }
    return self;
}

- (instancetype)initWithEnemyView:(UIView *)enemyView {
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(CGRectGetMidX(enemyView.frame) - width/2, CGRectGetMaxY(enemyView.frame), width, height);
        
        self.image = [UIImage imageNamed:@"seaRocket"];
        
        self.owner = ACRocketOwnerEnemy;
        
        [self moveRocket];
    }
    return self;
}

#pragma mark - Setter Methods

- (void)setIsPaused:(BOOL)isPaused {
    
    _isPaused = isPaused;
    
    if (!isPaused) {
        
        [self moveRocket];
    }
}

#pragma mark - Help Methods

- (void)moveRocket {
    
    if (self.owner == ACRocketOwnerSpaceShip) {
        
        [self moveRocketWithUpDirectionAndDuration:shotDuration];
        
    } else {
        
        [self moveRocketWithDownDirectionAndDuration:shotEnemyDuration];
        
    }
}

#pragma mark - Private Methods

- (void)moveRocketWithDownDirectionAndDuration:(NSTimeInterval)duration {
    
    [UIImageView animateWithDuration:duration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + flyStep);
                              
                          } completion:^(BOOL finished) {
                              
                              NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                              
                              if (self.isPaused) {
                                  
                                  return;
                              
                              } else if (!self.isHit && CGRectGetMinY(self.frame) <= screenHeight) {
                                  
                                  [center postNotificationName:rocketCurrentPositionNotification object:self];
                                  
                                  [self moveRocketWithDownDirectionAndDuration:duration];
                                  
                              } else {
                                  
                                  [center postNotificationName:enemyRocketFinishedFlyNotification object:nil];
                              }
                              
                          }];
}

- (void)moveRocketWithUpDirectionAndDuration:(NSTimeInterval)duration {
    
    [UIImageView animateWithDuration:duration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              self.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - flyStep);
                              
                          } completion:^(BOOL finished) {
                              
                              NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                              
                              if (self.isPaused) {
                                  
                                  return;
                                  
                              } else if (!self.isHit && CGRectGetMaxY(self.frame) > 0) {
                                  
                                  [center postNotificationName:rocketCurrentPositionNotification object:self];
                                  
                                  [self moveRocketWithUpDirectionAndDuration:duration];
                                  
                              } else {
                                  
                                  [center postNotificationName:shipRocketFinishedFlyNotification object:nil];
                              }
                              
                          }];
}

@end
