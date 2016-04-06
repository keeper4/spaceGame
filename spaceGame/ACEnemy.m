//
//  ACEnemy.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 20/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACEnemy.h"


@interface ACEnemy()

@end

@implementation ACEnemy

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
    
    self.frame = CGRectMake(CGRectGetMidX(screen)-widthShip/2,
                            CGRectGetMinY(screen),
                            widthShip,
                            heigthShip);
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.zPosition = 1;
    
    self.image = [UIImage imageNamed:@"enemy"];
    
    self.lifeQuantity = 1;
}

@end
