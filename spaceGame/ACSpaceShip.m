//
//  ACSpaceShip.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACSpaceShip.h"
#import "ACRocket.h"

@interface ACSpaceShip()

@property (assign,nonatomic) CGFloat widthShip;
@property (assign,nonatomic) CGFloat heigthShip;

@end

@implementation ACSpaceShip

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.widthShip = 80;
        self.heigthShip = 80;
        [self makeShip];
    }
    return self;
}

- (void) makeShip {
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.frame = CGRectMake(CGRectGetMidX(screen)-self.widthShip/2,
                            CGRectGetMaxY(screen)-self.widthShip,
                            self.widthShip,
                            self.heigthShip);
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.zPosition = 1;
    
    self.image = [UIImage imageNamed:@"spaceShip.png"];
  
}

- (void)makeShootOnView:(UIView *)mainView {

    ACRocket *rocket = [[ACRocket alloc]init];
    
    [rocket createRocketShipMidX:CGRectGetMidX(self.frame) shipMinY:CGRectGetMinY(self.frame)];
    
    [mainView addSubview:rocket];
}

@end
