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
#import "ACGameOverController.h"
#import <AVFoundation/AVFoundation.h>
#import "ACStartViewController.h"

@interface ACSceneViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *healthCollection;

@property (strong, nonatomic) ACSpaceShip *spaceShip;
@property (strong, nonatomic) NSMutableArray *enemiesArray;
@property (strong, nonatomic) NSMutableArray *rocketsArray;

@property (assign, nonatomic) NSUInteger totalScore;
@property (strong, nonatomic) UILongPressGestureRecognizer *lpgr;
@property (assign, nonatomic) BOOL isPause;
@property (assign, nonatomic) CGFloat moveShipDuration;
@property (strong, nonatomic) NSTimer *addingEnemyTimer;
@property (strong, nonatomic) NSTimer *shootingEnemyTimer;
@property (strong, nonatomic) NSTimer *shootingShipTimer;

@end

@implementation ACSceneViewController

static CGFloat animationDuration = 0.3f;
AVAudioPlayer *audioPlayer2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enemiesArray = [NSMutableArray array];
    self.rocketsArray = [NSMutableArray array];
    
    self.spaceShip = [[ACSpaceShip alloc] init];
    
    [self.view addSubview:self.spaceShip];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    lpgr.allowableMovement = 20;
    lpgr.minimumPressDuration = 0.1f;
    [self.view addGestureRecognizer:lpgr];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(rocketFinishedFlyAction:)
                               name:rocketFinishedFlyNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(checkForRocketHits:)
                               name:rocketCurrentPositionNotification
                             object:nil];
    
    [self setupBackgroundImageViews];
    
    [self setupScoreLabel:self.scoreLabel];
    
    [self createAddingEnemiesTimer];
    [self createShootingEnemiesTimer];
    [self createShootingShipTimer];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self makeShootFromView:self.spaceShip];
    
    if (self.isPause) {
        
        self.isPause = NO;
        
        [self changePauseValueForSpaceObjectsWithValue:self.isPause];
        
        [self makeShootFromView:self.spaceShip];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Getter Methods

- (CGFloat)moveShipDuration {
    
    return (arc4random_uniform(200) + 300) / 10000.f;
}

#pragma mark - rocketCurrentPositionNotification

- (void)checkForRocketHits:(NSNotification *)notification {
    
    if ([notification.object isKindOfClass: [ACRocket class]]) {
        
        ACRocket *rocket = notification.object;
        
        for (ACEnemy *enemyShip in self.enemiesArray) {
            
            if (CGRectIntersectsRect(enemyShip.frame, rocket.frame) && rocket.owner == ACRocketOwnerSpaceShip) {
                
                rocket.isHit = YES;
                [self removeRocket:rocket];
                
                enemyShip.lifeQuantity -= 1;
                
                if (enemyShip.lifeQuantity > 0) {
                    
                    [self hitSpaceObjectAnimated:enemyShip];
                    
                } else {
                    
                    enemyShip.isHit = YES;
                    
                    self.scoreLabel.text = [NSString stringWithFormat:@" Score: %lu ", (unsigned long)(self.totalScore += 1)];
                    
                    [self removeSpaceObjectAnimated:enemyShip];
                }
                
                return;
            }
            
        }
        
        if (CGRectIntersectsRect(self.spaceShip.frame, rocket.frame) && rocket.owner == ACRocketOwnerEnemy) {
            
            rocket.isHit = YES;
            [self removeRocket:rocket];
            
            self.spaceShip.lifeQuantity -= 1;
            
            [self.healthCollection reloadData];
            
            if (self.spaceShip.lifeQuantity > 0) {
                
                [self hitSpaceObjectAnimated:self.spaceShip];
                
            } else if (self.spaceShip.lifeQuantity == 0) {
                
                [self removeSpaceObjectAnimated:self.spaceShip];
                
                
                if ([ACStartViewController audioPlayer].playing) {
                    [ACStartViewController audioPlayer].volume = 0.0;
                }
                
                [self showGameOverController];
            }
        }
    }
}

#pragma mark - rocketFinishedFlyNotification

- (void)rocketFinishedFlyAction:(NSNotification *)notification {
    
    ACRocket *rocket = notification.object;
    
    if (rocket) {
        
        [self removeRocket:rocket];
    }
    
}

#pragma mark - Help Methods

- (void)makeShootFromView:(UIView *)view {
    
    ACRocket *rocket;
    
    if ([view isKindOfClass:[ACSpaceShip class]] && self.spaceShip.lifeQuantity > 0) {
        
        rocket = [[ACRocket alloc] initWithShipView:view];
        
    } else if ([view isKindOfClass:[ACEnemy class]] && self.spaceShip.lifeQuantity > 0) {
        
        rocket = [[ACRocket alloc] initWithEnemyView:view];
        
    } else {
        
        NSLog(@"Wrong view Type or lifeQuantity == 0");
        
        return;
    }
    
    
    [self.rocketsArray addObject:rocket];
    
    [self.view addSubview:rocket];
    
}

- (void)createShootingShipTimer {
    
    self.shootingShipTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                              target:self
                                                            selector:@selector(makeShootForSpaceShip)
                                                            userInfo:nil
                                                             repeats:YES];
}

- (void)createShootingEnemiesTimer {
    
    self.shootingEnemyTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                                               target:self
                                                             selector:@selector(makeShootForEnemies)
                                                             userInfo:nil
                                                              repeats:YES];
}

- (void)createAddingEnemiesTimer {
    
    self.addingEnemyTimer = [NSTimer scheduledTimerWithTimeInterval:(arc4random_uniform(3000) + 1000) / 1000
                                                             target:self
                                                           selector:@selector(addEnemy)
                                                           userInfo:nil
                                                            repeats:YES];
}

- (void)showGameOverController {
    
    self.isPause = YES;
    
    [self changePauseValueForSpaceObjectsWithValue:self.isPause];
    
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dead2" ofType:@"mp3"]];
    
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    audioPlayer2.volume = 0.5f;
    
    [audioPlayer2 play];
    
    ACGameOverController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ACGameOverController"];
    
    vc.score = self.totalScore;
    
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)changePauseValueForSpaceObjectsWithValue:(BOOL)isPaused {
    
    if (isPaused) {
        
        [self.addingEnemyTimer invalidate];
        self.addingEnemyTimer = nil;
        
        [self.shootingEnemyTimer invalidate];
        self.shootingEnemyTimer = nil;
        
        [self.shootingShipTimer invalidate];
        self.shootingShipTimer = nil;
        
    } else {
        
        //        [self createAddingEnemiesTimer];
        //        [self createShootingEnemiesTimer];
        //        [self createShootingShipTimer];
        
        for (ACRocket *rocket in self.rocketsArray) {
            
            rocket.isPaused = isPaused;
        }
        
        for (ACEnemy *enemyShip in self.enemiesArray) {
            
            enemyShip.isPaused = isPaused;
            
            [enemyShip moveShipWithDuration:self.moveShipDuration];
        }
        
    }
    
}

#pragma mark - Rocket Processing

- (void)removeRocket:(UIView *)rocket {
    
    [rocket removeFromSuperview];
    
    [self.rocketsArray removeObject:rocket];
    
    rocket = nil;
    
}

#pragma mark - SpaceShip Processing

- (void)makeShootForSpaceShip {
    
    [self makeShootFromView:self.spaceShip];
}

#pragma mark - Enemy Processing

- (void)makeShootForEnemies {
    
    for (ACEnemy *enemy in self.enemiesArray) {
        
        [self makeShootFromView:enemy];
    }
    
}

- (void)addEnemy {
    
    ACEnemy *enemy = [[ACEnemy alloc] init];
    
    [self.enemiesArray addObject:enemy];
    
    [self.view addSubview:enemy];
    
    [enemy moveShipWithDuration:self.moveShipDuration];
    
}

- (void)removeEnemy:(UIView *)enemy {
    
    [self.enemiesArray removeObject:enemy];
    
    [enemy removeFromSuperview];
    
    enemy = nil;
    
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
                                  
                                  self.spaceShip = nil;
                                  
                                  [self.healthCollection reloadData];
                                  
                              } else if ([ship isKindOfClass:[ACEnemy class]]) {
                                  
                                  [self removeEnemy:ship];
                                  
                              } else {
                                  
                                  NSLog(@"Wrong ship Type");
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
    
    UIImageView *backgroundViewSecond = [[UIImageView alloc] initWithImage:backgroundImage];
    
    backgroundViewSecond.frame = CGRectMake(CGRectGetMinX(viewRect),
                                            -CGRectGetHeight(viewRect),
                                            CGRectGetWidth(viewRect),
                                            CGRectGetHeight(viewRect));
    
    [self.view addSubview:backgroundViewFirst];
    
    [self.view addSubview:backgroundViewSecond];
    
    [self.view sendSubviewToBack:backgroundViewSecond];
    [self.view sendSubviewToBack:backgroundViewFirst];
    
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

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGFloat delta = 30.f;
    CGFloat oldX = CGRectGetMidX(self.spaceShip.frame);
    
    CGPoint pointTouch = [gestureRecognizer locationInView:self.view];
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if (pointTouch.x <= CGRectGetMidX(self.view.frame) &&
            CGRectGetMinX(self.view.frame) <= CGRectGetMinX(self.spaceShip.frame)-delta && pointTouch.y > 60) {
            
            CGFloat newX = oldX-delta;
            
            [self animationWithDelta:delta oldX:oldX newX:newX gestureRecognizer:gestureRecognizer];
            
        } else if (pointTouch.x > CGRectGetMidX(self.view.frame) &&
                   CGRectGetMaxX(self.view.frame) >= CGRectGetMaxX(self.spaceShip.frame)+delta && pointTouch.y > 60) {
            
            CGFloat newX = oldX+delta;
            
            [self animationWithDelta:delta oldX:oldX newX:newX gestureRecognizer:gestureRecognizer];
        }
    }
}

- (void)animationWithDelta:(CGFloat)delta oldX:(CGFloat)oldX newX:(CGFloat)newX gestureRecognizer:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.spaceShip.center = CGPointMake(newX, CGRectGetMaxY(self.view.frame)-self.spaceShip.frame.size.width/2);
                     }
                     completion:^(BOOL finished) {
                         
                         if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
                             
                             [self handleLongPress:gestureRecognizer];
                             
                         }
                     }];
}

#pragma mark - Actions

- (IBAction)actionPauseButton:(UIButton *)sender {
    
    self.isPause = YES;
    
    [self changePauseValueForSpaceObjectsWithValue:self.isPause];
    
    UIViewController *nav =
    [self.storyboard instantiateViewControllerWithIdentifier:@"ACPauseControllerViewController"];
    
    [nav setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
