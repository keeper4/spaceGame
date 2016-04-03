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

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (assign, nonatomic) NSUInteger score;
@property (strong, nonatomic) ACSpaceShip *spaceShip;
@property (strong, nonatomic) ACEnemy *enemyShip;

@end

@implementation SceneViewController

static CGFloat animationDuration = 0.3f;
static CGFloat shotDuration = 0.06f;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackgroundImageViews];
    
    [self setupScoreLabel:self.scoreLabel];
    
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
        
        [rocket createRocketFromMidX:CGRectGetMidX(view.frame) minY:CGRectGetMinY(view.frame) withDuration:shotDuration];
        
    } else if ([view isKindOfClass:[ACEnemy class]]) {
        
        rocket = [[ACRocket alloc] initWithEnemyView:view];
        
        [rocket createRocketFromMidX:CGRectGetMidX(view.frame) maxY:CGRectGetMaxY(view.frame) withDuration:shotDuration];
    }
    
    [self.view addSubview:rocket];
    
}

#pragma mark - rocketCurrentPositionNotification

- (void)checkForRocketHits:(NSNotification *)notification {
    
    if ([notification.object isKindOfClass: [ACRocket class]]) {
        
        ACRocket *rocket = notification.object;
        
        if (CGRectContainsRect(self.enemyShip.frame, rocket.frame)){
            
            [rocket removeFromSuperview];
            rocket.isHit = YES;
            rocket = nil;
            
            self.enemyShip.lifeQuantity -= 1;
            
            if (self.enemyShip.lifeQuantity > 0) {
                
                [self hitSpaceObjectAnimated:self.enemyShip];
                
            } else if (self.enemyShip.lifeQuantity == 0) {
                
                self.scoreLabel.text = [NSString stringWithFormat:@" Score: %ld ", self.score += 1];
                
                [self removeSpaceObjectAnimated:self.enemyShip];
            }
            
        } else if (CGRectContainsRect(self.spaceShip.frame, rocket.frame)) {
            
            [rocket removeFromSuperview];
            rocket.isHit = YES;
            rocket = nil;
            
            self.spaceShip.lifeQuantity -= 1;
            
            if (self.spaceShip.lifeQuantity > 0) {
                
                [self hitSpaceObjectAnimated:self.spaceShip];
                
            } else if (self.spaceShip.lifeQuantity == 0) {
                
                self.score = 0;
                self.scoreLabel.text = @" Score: 0 " ;
                
                [self removeSpaceObjectAnimated:self.spaceShip];
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

#pragma mark - Animations

- (void)hitSpaceObjectAnimated:(ACSpaceObject *)ship {
    
    [UIImageView animateWithDuration:animationDuration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              ship.alpha = 0.2f;
                              
                          } completion:^(BOOL finished) {
                              
                              [UIImageView animateWithDuration:animationDuration
                                                         delay:0
                                                       options:UIViewAnimationOptionCurveLinear
                                                    animations:^{
                                                        
                                                        ship.alpha = 1.f;
                                                        
                                                    } completion:nil];
                          }];
    
}

- (void)removeSpaceObjectAnimated:(ACSpaceObject *)ship {
    
    [UIImageView animateWithDuration:animationDuration
                               delay:0
                             options:UIViewAnimationOptionCurveLinear
                          animations:^{
                              
                              ship.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
                              
                          } completion:^(BOOL finished) {
                              
                              [ship removeFromSuperview];
                              
                              if ([ship isKindOfClass:[ACSpaceShip class]]) {
                                  
                                  self.spaceShip = [[ACSpaceShip alloc] init];
                                  [self.view addSubview:self.spaceShip];
                                  
                              } else if ([ship isKindOfClass:[ACEnemy class]]) {
                                  
                                  self.enemyShip = [[ACEnemy alloc] init];
                                  [self.view addSubview:self.enemyShip];
                              }
                              
                          }];
    
}

#pragma mark - Setup ScoreLabel

- (void)setupScoreLabel:(UILabel *)label {
    
    [self.view bringSubviewToFront:label];
    
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.borderWidth = 1.f;
    label.layer.cornerRadius = CGRectGetHeight(label.frame)/3;
    
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
