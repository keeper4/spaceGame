//
//  ACSpaceObject.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 20/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACRocket.h"

@interface ACSpaceObject : UIImageView

@property (assign, nonatomic) NSUInteger lifeQuantity;

@property (assign, nonatomic) BOOL isHit;
@property (assign, nonatomic) BOOL isPaused;

@end
