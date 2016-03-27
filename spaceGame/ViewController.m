//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ViewController.h"
#import "ACSpaceShip.h"
#import "ACEnemy.h"


@interface ViewController ()

@property (strong, nonatomic) ACSpaceShip *spaceShip;
@property (strong, nonatomic) ACEnemy *enemyShip;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackgroundImageViews];
    
    //spaceShip Create
    
    self.spaceShip = [[ACSpaceShip alloc]init];
    
    [self.view addSubview:self.spaceShip];
    
    //enemyShip Create
    
    self.enemyShip = [[ACEnemy alloc]init];
    
    [self.view addSubview:self.enemyShip];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(shipRocketFinishedFlyAction) name:shipRocketFinishedFlyNotification object:nil];
    
    [notificationCenter addObserver:self selector:@selector(enemyRocketFinishedFlyAction) name:enemyRocketFinishedFlyNotification object:nil];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.spaceShip makeShootOnView:self.view];
    
    [self.enemyShip makeShootOnView:self.view];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - shipRocketFinishedFlyNotification

- (void)shipRocketFinishedFlyAction {
    
    [self.spaceShip makeShootOnView:self.view];
}

#pragma mark - enemyRocketFinishedFlyNotification

- (void)enemyRocketFinishedFlyAction {
    
    [self.enemyShip makeShootOnView:self.view];
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
@end
