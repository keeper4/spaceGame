//
//  ViewController.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 16/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ViewController.h"
#import "ACSpaceShip.h"
#import "ACRocket.h"

@interface ViewController ()

@property (strong,nonatomic) ACSpaceShip *spaceShipBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    
<<<<<<< HEAD
    
    //spaceShip Create
    
    self.spaceShipBlock = [[ACSpaceShip alloc]init];
    
    [self.view addSubview:self.spaceShipBlock];
    
 
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
  //  NSThread *one = [[NSThread alloc] initWithTarget:self selector:@selector(makeShoot) object:nil];
 //   [one start];
    
    
    
=======
    //spaceShip Create
    
    ACSpaceShip *spaceShip = [[ACSpaceShip alloc]init];
    
    [self.view addSubview:spaceShip];
    
    self.spaceShipBlock = spaceShip;
    
    
    [self setupBackgroundImageViews];
    
}

#pragma mark - Setup Animation Background

- (void)setupBackgroundImageViews {
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *backgroundViewFirst = [[UIImageView alloc] initWithImage:backgroundImage];
    
    CGRect viewRect = self.view.frame;
    
    backgroundViewFirst.frame = CGRectMake(CGRectGetMinX(viewRect),
                                           CGRectGetMinX(viewRect),
                                           CGRectGetWidth(viewRect),
                                           CGRectGetHeight(viewRect));
    
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
                         
                         secondView.frame = firstView.frame;
                         
                     } completion:nil];
    
>>>>>>> 91c3983ba4bf10869d6cb992bf6f99aec308673e
}
#pragma mark - Methods

- (void)makeShoot {
    
    [self.spaceShipBlock makeShootOnView:self.view];
    
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
