//
//  Chart.m
//  SystemMonitor
//
//  Created by Barney on 7/11/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "Chart.h"

@implementation Chart

- (void) drawRect:(CGRect)rect withContext: (CGContextRef) context andColor:(UIColor*)color{
    
    CGContextBeginPath(context);
    [color setFill];
    
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end
