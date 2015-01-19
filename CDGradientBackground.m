//
//  CDGradientBackground.m
//
//  Created by Ismail Ege AKPINAR on 12/11/2013.
//  Copyright (c) 2013 Creatd. Use as you wish.
//

#import "CDGradientBackground.h"

@implementation CDGradientBackground

/////////////////////////////////////////////////////////////////////////
#pragma mark - Private internals
/////////////////////////////////////////////////////////////////////////

- (void)_commonInit {
    /////////////////////////////////////////
    // Set defaults
    /////////////////////////////////////////
    
    self.startColour = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.];
    self.endColour = [UIColor colorWithRed:1 green:1 blue:1 alpha:.1];
    self.isRadial = NO;
    self.startEdge = CDGradientEdgeTop;

    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - Default methods
/////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _commonInit];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self _commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _commonInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect   {
    CGGradientRef glossGradient;
    CGColorSpaceRef colourSpace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    
    const CGFloat *componentsStart = CGColorGetComponents(self.startColour.CGColor);
    const CGFloat *componentsEnd = CGColorGetComponents(self.endColour.CGColor);
    NSInteger countComponents1 = CGColorGetNumberOfComponents(self.startColour.CGColor);
    NSInteger countComponents2 = CGColorGetNumberOfComponents(self.endColour.CGColor);
    if (countComponents1 != countComponents2) {
        NSLog(@"Error - Start colour and end colour have different colour spaces (%d vs %d), gradient won't work", countComponents1, countComponents2);
    }
    NSInteger countComponents = MIN(countComponents1, countComponents2);
    CGFloat *components = malloc(countComponents * sizeof(CGFloat) * 2);
    for (int i=0; i<countComponents; i++) {
        components[i] = componentsStart[i];
    }
    for (int i=countComponents; i<2*countComponents; i++) {
        components[i] = componentsEnd[i-countComponents];
    }
    
    colourSpace = CGColorGetColorSpace(self.startColour.CGColor);
    glossGradient = CGGradientCreateWithColorComponents(colourSpace, components, locations, num_locations);
    
    CGRect currentBounds = self.bounds;

    // Draw gradient
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (self.isRadial) {
        CGPoint midCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
        float radius = currentBounds.size.height > currentBounds.size.width ? currentBounds.size.height/1.5f : currentBounds.size.width/1.5f;
        CGContextDrawRadialGradient(currentContext, glossGradient, midCenter, 0, midCenter, radius, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    }
    else {
        CGPoint startPoint, endPoint;
        switch (self.startEdge) {
            default:
            case CDGradientEdgeTop:
                startPoint = CGPointMake(0, 0);
                endPoint = CGPointMake(0, currentBounds.size.height);
                break;
            case CDGradientEdgeBottom:
                startPoint = CGPointMake(0, currentBounds.size.height);
                endPoint = CGPointMake(0, 0);
                break;
            case CDGradientEdgeLeft:
                startPoint = CGPointMake(0, 0);
                endPoint = CGPointMake(currentBounds.size.width, 0);
                break;
            case CDGradientEdgeRight:
                startPoint = CGPointMake(currentBounds.size.width, 0);
                endPoint = CGPointMake(0, 0);
                break;
        }
        CGContextDrawLinearGradient(currentContext, glossGradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        
    }
    
    CGGradientRelease(glossGradient);
    free(components);
}

@end