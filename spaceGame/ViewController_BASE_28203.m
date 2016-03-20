//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ViewController.h"
#import "ACSpaceShip.h"

@interface ViewController ()

@property (weak,nonatomic) UIImageView *spaceShipBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//spaceShip Create
    
    ACSpaceShip *spaceShip = [[ACSpaceShip alloc]init];

    [self.view addSubview:spaceShip];
    
    self.spaceShipBlock = spaceShip;
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat delta = 20.f;
    CGFloat oldX = CGRectGetMidX(self.spaceShipBlock.frame);
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointTouch = [touch locationInView:self.view];

    if (pointTouch.x <= CGRectGetMidX(self.view.frame) &&
        CGRectGetMinX(self.view.frame) <= CGRectGetMinX(self.spaceShipBlock.frame)-delta) {
        
        CGFloat newX = oldX-delta;
        
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.spaceShipBlock.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.spaceShipBlock.frame.size.width/2);
                         }
                         completion:^(BOOL finished) {
                         }];
        
    } else  if(pointTouch.x > CGRectGetMidX(self.view.frame) &&
               CGRectGetMaxX(self.view.frame) >= CGRectGetMaxX(self.spaceShipBlock.frame)+delta) {
        
        CGFloat newX = oldX+delta;
        
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.spaceShipBlock.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.spaceShipBlock.frame.size.width/2);
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}
@end
