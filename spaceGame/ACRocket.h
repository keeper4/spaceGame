//
//  ACRocket.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//


#import "UIKit/UIKit.h"

extern NSString * const shipRocketFinishedFlyNotification;
extern NSString * const enemyRocketFinishedFlyNotification;

extern NSString * const rocketCurrentPositionNotification;


typedef enum {
    ACRocketOwnerEnemy,
    ACRocketOwnerSpaceShip
} ACRocketOwner;

@interface ACRocket : UIImageView

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) BOOL isHit;
@property (assign, nonatomic) BOOL isPaused;
@property (assign, nonatomic) ACRocketOwner owner;


- (instancetype)initWithShipView:(UIView *)shipView;
- (instancetype)initWithEnemyView:(UIView *)enemyView;

- (void)moveRocket;

@end
