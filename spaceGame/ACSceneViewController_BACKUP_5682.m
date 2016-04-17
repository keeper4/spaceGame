//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACSceneViewController.h"
#import "ACSpaceShip.h"
#import "ACEnemy.h"
#import "ACPauseControllerViewController.h"

@interface ACSceneViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *healthCollection;

@property (assign, nonatomic) NSUInteger score;
@property (strong, nonatomic) ACSpaceShip *spaceShip;
@property (strong, nonatomic) ACEnemy *enemyShip;

@end

@implementation ACSceneViewController

static CGFloat animationDuration = 0.3f;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //spaceShip Create
    
    self.spaceShip = [[ACSpaceShip alloc] init];
    
    [self.view addSubview:self.spaceShip];
    
    //enemyShip Create
    
    self.enemyShip = [[ACEnemy alloc] init];
    
    [self.view addSubview:self.enemyShip];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(shipRocketFinishedFlyAction)
                               name:shipRocketFinishedFlyNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(enemyRocketFinishedFlyAction)
                               name:enemyRocketFinishedFlyNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(checkForRocketHits:)
                               name:rocketCurrentPositionNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(enemyShipFinishedFlyAction)
                               name:enemyShipFinishedFlyNotification
                             object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupBackgroundImageViews];
    
    [self setupScoreLabel:self.scoreLabel];
    
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
        
    } else if ([view isKindOfClass:[ACEnemy class]]) {
        
        rocket = [[ACRocket alloc] initWithEnemyView:view];
    }
    
    [self.view addSubview:rocket];
    
}

#pragma mark - rocketCurrentPositionNotification

- (void)checkForRocketHits:(NSNotification *)notification {
    
    if ([notification.object isKindOfClass: [ACRocket class]]) {
        
        ACRocket *rocket = notification.object;
        
        if (CGRectIntersectsRect(self.enemyShip.frame, rocket.frame)) {
            
            rocket.isHit = YES;
            [rocket removeFromSuperview];
            rocket = nil;
            
            self.enemyShip.lifeQuantity -= 1;
            
            if (self.enemyShip.lifeQuantity > 0) {
                
                [self hitSpaceObjectAnimated:self.enemyShip];
                
            } else if (self.enemyShip.lifeQuantity == 0) {
                
<<<<<<< HEAD
                self.enemyShip.isHit = YES;

                self.scoreLabel.text = [NSString stringWithFormat:@" Score: %ld ", self.score += 1];
=======
                self.scoreLabel.text = [NSString stringWithFormat:@" Score: %u ", self.score += 1];
>>>>>>> 444f874a111dfc064e6e3322b1432ed67118886c
                
                [self removeSpaceObjectAnimated:self.enemyShip];
            }
            
        } else if (CGRectIntersectsRect(self.spaceShip.frame, rocket.frame)) {
            
            rocket.isHit = YES;
            [rocket removeFromSuperview];
            rocket = nil;
            
            self.spaceShip.lifeQuantity -= 1;
            
            [self.healthCollection reloadData];
            
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

#pragma mark - enemyShipFinishedFlyNotification

- (void)enemyShipFinishedFlyAction {
    
    [self.enemyShip removeFromSuperview];
    self.enemyShip = nil;
    
    self.enemyShip = [[ACEnemy alloc] init];

    [self.view addSubview:self.enemyShip];
    
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
                                  
                                  [self.healthCollection reloadData];
                                  
                              } else if ([ship isKindOfClass:[ACEnemy class]]) {
                                  
                                  self.enemyShip = [[ACEnemy alloc] init];
                                  [self.view addSubview:self.enemyShip];
                              }
                              
                          }];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.spaceShip.lifeQuantity;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"heartCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
    
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
    backgroundViewFirst.layer.zPosition = -1;
    
    
    UIImageView *backgroundViewSecond = [[UIImageView alloc] initWithImage:backgroundImage];
    
    backgroundViewSecond.frame = CGRectMake(CGRectGetMinX(viewRect),
                                            -CGRectGetHeight(viewRect),
                                            CGRectGetWidth(viewRect),
                                            CGRectGetHeight(viewRect));
    
    backgroundViewSecond.layer.zPosition = -1;
    
    
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
        
    } else if (pointTouch.x > CGRectGetMidX(self.view.frame) &&
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

#pragma mark - Actions

- (IBAction)actionPauseButton:(UIButton *)sender {
    
    UIViewController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"ACPauseControllerViewController"];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
