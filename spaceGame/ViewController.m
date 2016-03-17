//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(weak,nonatomic) UIView *leftBlock;
@property(weak,nonatomic) UIView *rightBlock;
@property(weak,nonatomic) UIView *spaceShipBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *spaceShip = [[UIView alloc]initWithFrame:
                         CGRectMake(CGRectGetMidX(self.view.bounds)-10,
                                    CGRectGetMaxY(self.view.bounds)-20,
                                                                    20,
                                                                    20)];
    
    spaceShip.backgroundColor = [UIColor grayColor];
    
    self.spaceShipBlock = spaceShip;
    self.spaceShipBlock.layer.zPosition = 1;
    [self.view addSubview:spaceShip];

    
    UIView *leftView = [[UIView alloc]initWithFrame:
                        CGRectMake(0, 0, CGRectGetMidX(self.view.bounds)-10, CGRectGetHeight(self.view.bounds))];
    
    leftView.backgroundColor = [UIColor clearColor];
    leftView.tag = 1;
    [self.view addSubview:leftView];
    self.leftBlock = leftView;
    
    UIView *rightView = [[UIView alloc]initWithFrame:
                         CGRectMake(CGRectGetMidX(self.view.bounds)+10, 0, CGRectGetMidX(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    rightView.backgroundColor = [UIColor clearColor];
    rightView.tag = 2;
    [self.view addSubview:rightView];
    self.rightBlock = rightView;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat delta = 20.f;
    CGFloat oldX = CGRectGetMidX(self.spaceShipBlock.frame);
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointLeft = [touch locationInView:self.leftBlock];
    CGPoint pointRight = [touch locationInView:self.rightBlock];
    
    if ([self.leftBlock pointInside:pointLeft withEvent:event]) {
        
        CGFloat newX = oldX-delta;
        self.spaceShipBlock.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-10);
        NSLog(@"left block - %f",newX);
    }
    if ([self.rightBlock pointInside:pointRight withEvent:event]) {
        

        CGFloat newX = oldX+delta;
        self.spaceShipBlock.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-10);
        NSLog(@"right block - %f",newX);
    }
   
    
    
}



@end
