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
    
    CGFloat widthShip = 80;
    CGFloat heigthShip = 80;
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.frame = CGRectMake(CGRectGetMidX(screen) - widthShip/2,
                            CGRectGetMaxY(screen) - widthShip,
                            widthShip,
                            heigthShip);
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.zPosition = 1;
    
    self.image = [UIImage imageNamed:@"spaceShip.png"];
    
}

- (void)makeShootOnView:(UIView *)mainView {
    
    ACRocket *rocket = [[ACRocket alloc] initWithShipView:self];
    
    [rocket createRocketFromMidX:CGRectGetMidX(self.frame) minY:CGRectGetMinY(self.frame) withDuration:0.1];
    
    [mainView addSubview:rocket];
}

@end
