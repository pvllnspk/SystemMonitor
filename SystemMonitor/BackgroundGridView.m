//
//  BackgroundGridView.m
//  SystemMonitor
//
//  Created by Barney on 7/10/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "BackgroundGridView.h"

#define xyGridStep  40

@implementation BackgroundGridView

- (void) drawBackgroundGrid:(CGRect)rect withContext: (CGContextRef) context{
    
    CGContextSetLineWidth(context, 0.2);
    CGContextSetStrokeColorWithColor(context,[[UIColor lightGrayColor] CGColor]);
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    
    int xLines = (rect.size.width) / xyGridStep;
    for (int i = 0; i < xLines; i++){
        CGContextMoveToPoint(context, i * xyGridStep, 0);
        CGContextAddLineToPoint(context, i * xyGridStep, rect.size.height);
    }
    
    int yLines = (rect.size.height) / xyGridStep;
    for (int i = 0; i <= yLines; i++){
        CGContextMoveToPoint(context, 0, rect.size.height - i * xyGridStep);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height - i * xyGridStep);
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0);
}


- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawBackgroundGrid:rect withContext:context];
}


@end
