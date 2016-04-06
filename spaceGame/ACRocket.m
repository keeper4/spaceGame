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

static NSUInteger flyStep = 1;

#define screenHeight  ([[UIScreen mainScreen] bounds].size.height)


- (instancetype)initWithShipView:(UIView *)shipView {
    self = [super init];
    if (self) {
        
        self.height = 30;
        self.width = 20;
        
        self.frame = CGRectMake(CGRectGetMidX(shipView.frame) - self.width/2, CGRectGetMinY(shipView.frame), self.width, self.height);
        
        //self.backgroundColor = [UIColor redColor];
        self.image = [UIImage imageNamed:@"redRocket"];
    }
    return self;
}

- (instancetype)initWithEnemyView:(UIView *)enemyView {
    self = [super init];
    if (self) {
        
        self.height = 30;
        self.width = 20;
        
        self.frame = CGRectMake(CGRectGetMidX(enemyView.frame) - self.width/2, CGRectGetMaxY(enemyView.frame), self.width, self.height);
        
        //self.backgroundColor = [UIColor redColor];
        self.image = [UIImage imageNamed:@"seaRocket"];
    }
    return self;
}

- (void)createRocketFromMidX:(CGFloat)midX minY:(CGFloat)minY withDuration:(NSTimeInterval)duration {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIImageView animateWithDuration:duration
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear
                              animations:^{
                                  
                                  self.center = CGPointMake(midX, minY - flyStep);
                                  
                              } completion:^(BOOL finished) {
                                  
                                  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                                  
                                  if (!self.isHit && CGRectGetMaxY(self.frame) > 0) {
                                      
                                      [center postNotificationName:rocketCurrentPositionNotification object:self];
                                      
                                      [self createRocketFromMidX:midX minY:CGRectGetMinY(self.frame) withDuration:duration];
                                      
                                  } else {
                                      
                                      [center postNotificationName:shipRocketFinishedFlyNotification object:nil];
                                  }
                                  
                              }];
        
    });
    
}

- (void)createRocketFromMidX:(CGFloat)midX maxY:(CGFloat)maxY withDuration:(NSTimeInterval)duration {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIImageView animateWithDuration:duration
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear
                              animations:^{
                                  
                                  self.center = CGPointMake(midX, maxY + flyStep);
                                  
                              } completion:^(BOOL finished) {
                                  
                                  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                                  
                                  if (!self.isHit && CGRectGetMinY(self.frame) <= screenHeight) {
                                      
                                      [center postNotificationName:rocketCurrentPositionNotification object:self];
                                      
                                      [self createRocketFromMidX:midX maxY:CGRectGetMaxY(self.frame) withDuration:duration];
                                      
                                  } else {

                                      [center postNotificationName:enemyRocketFinishedFlyNotification object:nil];
                                  }
                                  
                              }];
        
    });
    
}


@end
