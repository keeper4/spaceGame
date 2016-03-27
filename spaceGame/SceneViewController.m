//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "SceneViewController.h"
#import "ACSpaceShip.h"
#import "ACEnemy.h"


@interface SceneViewController ()

@property (strong, nonatomic) ACSpaceShip *spaceShip;
@property (strong, nonatomic) ACEnemy *enemyShip;

@end

@implementation SceneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackgroundImageViews];
    
    //spaceShip Create
    
    self.spaceShip = [[ACSpaceShip alloc] init];
    
    [self.view addSubview:self.spaceShip];
    
    //enemyShip Create
    
    self.enemyShip = [[ACEnemy alloc] init];
    
    [self.view addSubview:self.enemyShip];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(shipRocketFinishedFlyAction) name:shipRocketFinishedFlyNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(enemyRocketFinishedFlyAction) name:enemyRocketFinishedFlyNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(checkForRocketHits:) name:rocketCurrentPositionNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self makeShootFromView:self.spaceShip];
    
    [self makeShootFromView:self.enemyShip];
}

#pragma mark - Private Methods

- (void)makeShootFromView:(UIView *)view {
    
    ACRocket *rocket;
    
    if ([view isKindOfClass:[ACSpaceShip class]]) {
        
        rocket = [[ACRocket alloc] initWithShipView:view];
        
        [rocket createRocketFromMidX:CGRectGetMidX(view.frame) minY:CGRectGetMinY(view.frame) withDuration:0.1];
        
    } else if ([view isKindOfClass:[ACEnemy class]]) {
        
        rocket = [[ACRocket alloc] initWithEnemyView:view];
        
        [rocket createRocketFromMidX:CGRectGetMidX(view.frame) maxY:CGRectGetMaxY(view.frame) withDuration:0.1];
    }
    
    [self.view addSubview:rocket];
    
}


//TODO: - Find Why lifeQuantity works wrong. Where second life for enemy?

#pragma mark - rocketCurrentPositionNotification

- (void)checkForRocketHits:(NSNotification *)notification {
    
    if ([notification.object isKindOfClass: [ACRocket class]]) {
        
        ACRocket *rocket = notification.object;
        
        if (CGRectContainsRect(self.enemyShip.frame, rocket.frame)) {
            
            self.enemyShip.lifeQuantity -= 1;
            
            [rocket removeFromSuperview];
            
            if (self.enemyShip.lifeQuantity > 0) {
                
                [UIImageView animateWithDuration:0.3
                                           delay:0
                                         options:UIViewAnimationOptionCurveLinear
                                      animations:^{
                                          
                                          self.enemyShip.alpha = 0.2f;
                                          
                                      } completion:^(BOOL finished) {
                                          
                                          [UIImageView animateWithDuration:0.3
                                                                     delay:0
                                                                   options:UIViewAnimationOptionCurveLinear
                                                                animations:^{
                                                                    
                                                                    self.enemyShip.alpha = 1.f;
                                                                    
                                                                } completion:nil];
                                          
                                      }];
                
            } else {
                
                [UIImageView animateWithDuration:0.3
                                           delay:0
                                         options:UIViewAnimationOptionCurveLinear
                                      animations:^{
                                          
                                          self.enemyShip.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
                                          
                                      } completion:^(BOOL finished) {
                                          
                                          [self.enemyShip removeFromSuperview];
                                          
                                          self.enemyShip = [[ACEnemy alloc] init];
                                          
                                          [self.view addSubview:self.enemyShip];
                                          
                                      }];
            }
            
        } else if (CGRectContainsRect(self.spaceShip.frame, rocket.frame)) {
            
            self.spaceShip.lifeQuantity -= 1;
            
            [rocket removeFromSuperview];
            
            if (self.spaceShip.lifeQuantity > 0) {
                
                [UIImageView animateWithDuration:0.3
                                           delay:0
                                         options:UIViewAnimationOptionCurveLinear
                                      animations:^{
                                          
                                          self.spaceShip.alpha = 0.2f;
                                          
                                      } completion:^(BOOL finished) {
                                          
                                          [UIImageView animateWithDuration:0.3
                                                                     delay:0
                                                                   options:UIViewAnimationOptionCurveLinear
                                                                animations:^{
                                                                    
                                                                    self.spaceShip.alpha = 1.f;
                                                                    
                                                                } completion:nil];
                                      }];
            } else {
                
                [UIImageView animateWithDuration:0.3
                                           delay:0
                                         options:UIViewAnimationOptionCurveLinear
                                      animations:^{
                                          
                                          self.spaceShip.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
                                          
                                      } completion:^(BOOL finished) {
                                          
                                          [self.spaceShip removeFromSuperview];
                                          
                                          self.spaceShip = [[ACSpaceShip alloc] init];
                                          
                                          [self.view addSubview:self.spaceShip];
                                          
                                      }];
                
            }
            
        }
        
    }
    
}

#pragma mark - shipRocketFinishedFlyNotification

- (void)shipRocketFinishedFlyAction {
    
    [self makeShootFromView:self.spaceShip];
}

#pragma mark - enemyRocketFinishedFlyNotification

- (void)enemyRocketFinishedFlyAction {
    
    [self makeShootFromView:self.enemyShip];
}

#pragma mark - Setup Animation Background

- (void)setupBackgroundImageViews {
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *backgroundViewFirst = [[UIImageView alloc] initWithImage:backgroundImage];
    
    CGRect viewRect = self.view.frame;
    
    backgroundViewFirst.frame = viewRect;
    
    UIImageView *backgroundViewSecond = [[UIImageView alloc] initWithImage:backgroundImage];
    
    backgroundViewSecond.frame = CGRectMake(CGRectGetMinX(viewRect),
                                            -CGRectGetHeight(viewRect),
                                            CGRectGetWidth(viewRect),
                                            CGRectGetHeight(viewRect));
    
    
    [self.view addSubview:backgroundViewFirst];
    
    [self.view addSubview:backgroundViewSecond];
    
    
    [self moveBackgroundWithFirstView:backgroundViewFirst secondView:backgroundViewSecond andDuration:10];
    
}

- (void)moveBackgroundWithFirstView:(UIImageView *)firstView secondView:(UIImageView *)secondView andDuration:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         firstView.frame = CGRectMake(CGRectGetMinX(firstView.frame),
                                                      CGRectGetMaxY(firstView.frame),
                                                      CGRectGetWidth(firstView.frame),
                                                      CGRectGetHeight(firstView.frame));
                         
                         secondView.frame = CGRectMake(CGRectGetMinX(secondView.frame),
                                                       CGRectGetMaxY(secondView.frame),
                                                       CGRectGetWidth(secondView.frame),
                                                       CGRectGetHeight(secondView.frame));
                         
                     } completion:nil];
    
}

#pragma mark - Hide StatusBar

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat delta = 20.f;
    CGFloat oldX = CGRectGetMidX(self.spaceShip.frame);
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointTouch = [touch locationInView:self.view];
    
    if (pointTouch.x <= CGRectGetMidX(self.view.frame) &&
        CGRectGetMinX(self.view.frame) <= CGRectGetMinX(self.spaceShip.frame)-delta) {
        
        CGFloat newX = oldX-delta;
        
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.spaceShip.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.spaceShip.frame.size.width/2);
                         }
                         completion:^(BOOL finished) {
                         }];
        
    } else  if(pointTouch.x > CGRectGetMidX(self.view.frame) &&
               CGRectGetMaxX(self.view.frame) >= CGRectGetMaxX(self.spaceShip.frame)+delta) {
        
        CGFloat newX = oldX+delta;
        
        [UIView animateWithDuration:0.3f
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.spaceShip.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.spaceShip.frame.size.width/2);
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

#pragma mark - Memory

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
