//
//  CDGradientBackground.h
//
//  Created by Ismail Ege AKPINAR on 12/11/2013.
//  Copyright (c) 2013 Creatd. Use as you wish.
//

#import <UIKit/UIKit.h>

typedef enum {
    CDGradientEdgeTop,
    CDGradientEdgeRight,
    CDGradientEdgeBottom,
    CDGradientEdgeLeft,
} CDGradientEdge;

@interface CDGradientBackground : UIView

/**
 Whether gradient should be radial from center or linear from one side
 NO by default
 */
@property (nonatomic, assign) BOOL isRadial;

/**
 Gradient start colour
 White (opaque) by default
 */
@property (nonatomic, retain) UIColor *startColour;

/**
 Gradient end colour
 White (transparent) by default
 */
@property (nonatomic, retain) UIColor *endColour;

/**
 Edge where gradient begins
 Top by default
 */
@property (nonatomic, assign) CDGradientEdge startEdge;

@end
