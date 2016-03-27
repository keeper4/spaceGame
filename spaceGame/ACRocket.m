//
//  ACRocket.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACRocket.h"

@implementation ACRocket

static NSUInteger flyStep = 10;

#define screenHeight  ([[UIScreen mainScreen] bounds].size.height)


- (instancetype)initWithShipView:(UIView *)shipView
{
    self = [super init];
    if (self) {
        
        self.height = 30;
        self.width = 20;
        
        self.frame = CGRectMake(CGRectGetMidX(shipView.frame), CGRectGetMinY(shipView.frame) - self.height, self.width, self.height);
        
        self.backgroundColor = [UIColor redColor];
        
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
                                  
                                  if (CGRectGetMaxY(self.frame) > 0) {
                                      
                                      [self createRocketFromMidX:midX minY:CGRectGetMinY(self.frame) withDuration:duration];
                                      
                                  } else {
                                      
                                      
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
                                  
                                  if (CGRectGetMinY(self.frame) < screenHeight ) {
                                      
                                      [self createRocketFromMidX:midX maxY:CGRectGetMaxY(self.frame) withDuration:duration];
                                      
                                  } else {
                                      
                                      
                                  }
                                  
                                  
                              }];
        
    });
    
}


@end
