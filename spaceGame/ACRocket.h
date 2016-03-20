//
//  ACRocket.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface ACRocket : UIImageView

@property (weak,nonatomic) UIImageView *rocketView;

- (void)createRocketShipMidX:(CGFloat)shipMidX shipMinY:(CGFloat)shipMinY;

@end
