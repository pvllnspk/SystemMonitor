//
//  PieChartView.m
//  SystemMonitor
//
//  Created by Barney on 7/8/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "PieChart.h"

#define CIRCLE_RADIUS   100

@implementation PieChart

- (void)drawPieChart:(CGContextRef)context rect:(CGRect)rect {
    
    CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 16, kCGEncodingMacRoman);
    UIFont *theFont = [UIFont fontWithName:@"Helvetica" size:16];
    CGContextSetTextDrawingMode(context, kCGTextFill);    
    
    CGPoint circleCenter = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    for (NSUInteger i = 0; i < [_slicesArray count]; i++) {
        
        CGFloat startValue = 0;
        for (int k = 0; k < i; k++) {
            startValue += [[_slicesArray objectAtIndex:k] floatValue];
        }
        CGFloat startAngle = startValue * 2 * M_PI - M_PI/2;
        
        CGFloat endValue = 0;
        for (int j = i; j >= 0; j--) {
            endValue += [[_slicesArray objectAtIndex:j] floatValue];
        }
        CGFloat endAngle = endValue * 2 * M_PI - M_PI/2;
        
        CGContextSetFillColorWithColor(context,[[[_colorsArray objectAtIndex:i] colorWithAlphaComponent:0.5] CGColor]);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
        CGContextAddArc(context, circleCenter.x, circleCenter.y, CIRCLE_RADIUS, startAngle, endAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
        
        
        NSString *text = [NSString stringWithFormat:@"%@: %.2f %%", [_valuesArray objectAtIndex:i], 100 * [[_slicesArray objectAtIndex:i] floatValue]];
        CGFloat textAngle = (startAngle + endAngle) / 2;
        
        CGFloat approxTextSize = [text sizeWithFont:theFont].width;
        CGFloat xPadding = 10;

        
        CGFloat x = abs(textAngle * 180 / M_PI) < 90 ?
        circleCenter.x  + cos(textAngle) * CIRCLE_RADIUS + (rect.size.width - circleCenter.x - cos(textAngle) * CIRCLE_RADIUS - approxTextSize) / 2 :
        (circleCenter.x + cos(textAngle) * CIRCLE_RADIUS - approxTextSize) / 2;
        CGFloat y = (circleCenter.y + sin(textAngle) * CIRCLE_RADIUS);
        x = x < 0 ? xPadding : x + approxTextSize > rect.size.width ? rect.size.width - approxTextSize - xPadding: x;
        
        CGContextSetFillColorWithColor(context, [[_colorsArray objectAtIndex:i] CGColor]);
        CGContextShowTextAtPoint(context, x, y, [text UTF8String], [text length]);
    }
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawPieChart:context rect:rect];
}

@end
