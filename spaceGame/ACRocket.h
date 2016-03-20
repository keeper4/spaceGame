//
//  ACRocket.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//


#import "UIKit/UIKit.h"

@interface ACRocket : UIImageView

@property (weak,nonatomic) UIImageView *rocketView;

- (void)createRocketFromShip:(UIView *)ship withDuration:(NSTimeInterval)duration;

@end
