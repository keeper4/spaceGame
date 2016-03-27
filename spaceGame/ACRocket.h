//
//  ACRocket.h
//  spaceGame
//
//  Created by Oleksandr Chyzh on 19/3/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//


#import "UIKit/UIKit.h"

@interface ACRocket : UIImageView

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;

- (instancetype)initWithShipView:(UIView *)shipView;

- (void)createRocketFromMidX:(CGFloat)midX minY:(CGFloat)minY withDuration:(NSTimeInterval)duration;

- (void)createRocketFromMidX:(CGFloat)midX maxY:(CGFloat)maxY withDuration:(NSTimeInterval)duration;

@end
