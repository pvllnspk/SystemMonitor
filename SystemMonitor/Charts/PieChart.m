//
//  PieChartView.m
//  SystemMonitor
//
//  Created by Barney on 7/8/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "PieChart.h"
#import <QuartzCore/QuartzCore.h>

#define CIRCLE_RADIUS   100

@implementation PieChart

- (void)drawPieChart:(CGContextRef)context rect:(CGRect)rect {
    
    CGPoint circleCenter = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    for (NSUInteger i = 0; i < [_sliceArray count]; i++) {
        
        CGFloat startValue = 0;
        for (int k = 0; k < i; k++) {
            startValue += [[_sliceArray objectAtIndex:k] floatValue];
        }
        CGFloat startAngle = startValue * 2 * M_PI - M_PI/2;
        
        CGFloat endValue = 0;
        for (int j = i; j >= 0; j--) {
            endValue += [[_sliceArray objectAtIndex:j] floatValue];
        }
        CGFloat endAngle = endValue * 2 * M_PI - M_PI/2;
        
        CGContextSetFillColorWithColor(context,(__bridge CGColorRef)[_colorsArray objectAtIndex:i]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
        CGContextAddArc(context, circleCenter.x, circleCenter.y, CIRCLE_RADIUS, startAngle, endAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawPieChart:context rect:rect];
}

@end
