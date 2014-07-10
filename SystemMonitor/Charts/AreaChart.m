//
//  LineChartView.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "AreaChart.h"

#define xPadding 0
#define circleRadius 2.0

#define DRAW_CIRCLES    NO
#define FILL_CHART      YES

int const STEPS_NUMBER = 15;

@implementation AreaChart

- (void) drawLineChart:(CGRect)rect withContext: (CGContextRef) context withData:(NSMutableArray*) data withColor:(UIColor*) color {
    
    CGColorRef lineColor = [color CGColor];
    CGColorRef fillColor = [[color colorWithAlphaComponent:0.2] CGColor] ;
    
    float xStep = rect.size.width / STEPS_NUMBER;
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, lineColor);
    
    float maxChartHeight =rect.size.height * 0.7;
    float yPadding = (rect.size.height - maxChartHeight) / 2;
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, xPadding, rect.size.height - (maxChartHeight) * [[data objectAtIndex:0] floatValue] - yPadding);
    for (int i = 1; i < [data count]; i++){
        float x = xPadding + i * xStep;
        float y = rect.size.height - maxChartHeight * [[data objectAtIndex:i] floatValue] - yPadding;
        CGContextAddLineToPoint(context, x, y);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
    if(DRAW_CIRCLES){
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        
        for (int i = 1; i < [data count] - 1; i++){
            float x = i * xStep;
            float y = rect.size.height - maxChartHeight * [[data objectAtIndex:i] floatValue] - yPadding;
            CGRect rect = CGRectMake(x - circleRadius, y - circleRadius, 2 * circleRadius, 2 * circleRadius);
            CGContextAddEllipseInRect(context, rect);
        }
        
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    if(FILL_CHART){
        
        CGContextSetFillColorWithColor(context, fillColor);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, xPadding, rect.size.height);
        CGContextAddLineToPoint(context, xPadding, rect.size.height - (maxChartHeight) * [[data objectAtIndex:0] floatValue] - yPadding);
        for (int i = 1; i < [data count]; i++){
            float x = xPadding + i * xStep;
            float y = rect.size.height - maxChartHeight * [[data objectAtIndex:i] floatValue] - yPadding;
            CGContextAddLineToPoint(context, x, y);
        }
        CGContextAddLineToPoint(context, xPadding + ([data count] - 1) * xStep, rect.size.height);
        CGContextClosePath(context);
        
        //        CGContextDrawPath(context, kCGPathFill);
        CGContextSaveGState(context);
        CGContextClip(context);
        
        //Draw the gradient
        
        CGFloat startColor[4] = {}, endColor[4] = {};
        memcpy(startColor, CGColorGetComponents(fillColor), sizeof(startColor));
        memcpy(endColor, CGColorGetComponents(lineColor), sizeof(endColor));
        
        CGGradientRef gradient;
        CGColorSpaceRef colorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = {0.0, 1.0};
        CGFloat components[8] = {startColor[0], startColor[1], startColor[2], startColor[3],  endColor[0], endColor[1], endColor[2], endColor[3]};
        colorspace = CGColorSpaceCreateDeviceRGB();
        gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
        
        CGPoint startPoint, endPoint;
        startPoint.x = xPadding;
        startPoint.y = rect.size.height;
        endPoint.x = xPadding;
        endPoint.y = yPadding;
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        
        CGContextRestoreGState(context);
        CGColorSpaceRelease(colorspace);
        CGGradientRelease(gradient);
    }
}


- (void)drawRect:(CGRect)rect{
    
    if(_sendTraffic==nil){
        _sendTraffic = [NSMutableArray array];
    }
    if(_receivedTraffic==nil){
        _receivedTraffic = [NSMutableArray array];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if([_sendTraffic count] > 0){
        [self drawLineChart:rect withContext:context withData:_sendTraffic withColor:[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0]];
    }
    if([_receivedTraffic count] > 0){
        [self drawLineChart:rect withContext:context withData:_receivedTraffic withColor:[[UIColor greenColor] colorWithAlphaComponent:1.0]];
    }
}


@end
