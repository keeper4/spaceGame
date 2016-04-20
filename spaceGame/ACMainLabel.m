//
//  ACMainLabel.m
//  spaceGame
//
//  Created by Oleksandr Chyzh on 20/4/16.
//  Copyright © 2016 Aleksandr Chyzh. All rights reserved.
//

#import "ACMainLabel.h"

@implementation ACMainLabel

-(id) initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        self.opaque = NO;
        self.backgroundColor = [self buttonColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        [self setFont:[UIFont fontWithName:@"Bohema" size:20.0f]];

    }
    return self;
}

- (UIColor *)buttonColor {
    
    UIColor *color = [UIColor colorWithRed:0.84 green:0.93 blue:0.67 alpha:1.0];
    
    return color;
}

@end
