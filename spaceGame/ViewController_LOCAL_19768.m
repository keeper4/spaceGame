//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak,nonatomic) UIView *leftBlock;
@property (weak,nonatomic) UIView *rightBlock;
@property (weak,nonatomic) UIView *spaceShipBlock;
//@property (nonatomic,strong) UILongPressGestureRecognizer *lpgr;
@property (assign,nonatomic) CGFloat widthShip;
@property (assign,nonatomic) CGFloat heigthShip;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//spaceShip Create
    
    self.widthShip = 80;
    self.heigthShip = 80;
    
    UIImageView *spaceShip = [[UIImageView alloc]initWithFrame:
                         CGRectMake(CGRectGetMidX(self.view.bounds)-self.widthShip/2,
                                    CGRectGetMaxY(self.view.bounds)-self.heigthShip,
                                                                    self.widthShip,
                                                                    self.heigthShip)];
    
    spaceShip.backgroundColor = [UIColor clearColor];
    
    self.spaceShipBlock = spaceShip;
    self.spaceShipBlock.layer.zPosition = 1;
    [self.view addSubview:spaceShip];
    
    UIImage *imageSpaceShip = [UIImage imageNamed:@"spaceShip.png"];
    spaceShip.image = imageSpaceShip;
    

//left Tap View
    
    UIView *leftView = [[UIView alloc]initWithFrame:
                        CGRectMake(0, 0, CGRectGetMidX(self.view.bounds)-10, CGRectGetHeight(self.view.bounds))];
    
    leftView.backgroundColor = [UIColor clearColor];
    leftView.tag = 1;
    [self.view addSubview:leftView];
    self.leftBlock = leftView;
    
 //right Tap View
    
    UIView *rightView = [[UIView alloc]initWithFrame:
                         CGRectMake(CGRectGetMidX(self.view.bounds)+10, 0, CGRectGetMidX(self.view.bounds), CGRectGetHeight(self.view.bounds))];

    rightView.backgroundColor = [UIColor clearColor];
    rightView.tag = 2;
    [self.view addSubview:rightView];
    self.rightBlock = rightView;
    
/// longTap
    
  /*  self.lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
    self.lpgr.minimumPressDuration = 1.0f;
    self.lpgr.allowableMovement = 100.0f;
    
    [self.view addGestureRecognizer:self.lpgr];
*/
}

#pragma mark - Methods
/*
- (void)handleLongPressGestures:(UILongPressGestureRecognizer *)sender
{
    if ([sender isEqual:self.lpgr]) {
        if (sender.state == UIGestureRecognizerStateBegan)
        {
            NSLog(@"handleLongPressGestures");
        }
    }
} */

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat delta = 20.f;
    CGFloat oldX = CGRectGetMidX(self.spaceShipBlock.frame);
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointLeft = [touch locationInView:self.leftBlock];
    CGPoint pointRight = [touch locationInView:self.rightBlock];
    
    if ([self.leftBlock pointInside:pointLeft withEvent:event]) {
        
        CGFloat newX = oldX-delta;
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.spaceShipBlock.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.widthShip/2);
                         }
                         completion:^(BOOL finished) {
                         }];
        
    }
    if ([self.rightBlock pointInside:pointRight withEvent:event]) {
        

        CGFloat newX = oldX+delta;
        
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.spaceShipBlock.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.widthShip/2);
                         }
                         completion:^(BOOL finished) {
                         }];


    }
 
    
}



@end
