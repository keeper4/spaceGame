//
//  ACEnemy.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 20/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSpaceObject.h"

extern NSString * const enemyShipFinishedFlyNotification;

@interface ACEnemy : ACSpaceObject

- (void)moveShipWithDuration:(NSTimeInterval)duration;

@end
