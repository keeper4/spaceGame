//
//  ACSpaceShip.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACSpaceShip.h"

@interface ACSpaceShip()


@end

@implementation ACSpaceShip

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
    CGFloat heigthShip = 50;
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.frame = CGRectMake(CGRectGetMidX(screen) - widthShip/2,
                            CGRectGetMaxY(screen) - widthShip,
                            widthShip,
                            heigthShip);
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.zPosition = 1;
    
    self.image = [UIImage imageNamed:@"spaceShip.png"];
    
    self.lifeQuantity = 3;
}

@end
