//
//  BarChartView.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "BarChart.h"

#define xBarWidth 40

@implementation BarChart
{
    NSMutableArray* touchAreas;
}

- (void)drawRect:(CGRect)rect{
    
    if(touchAreas == nil){
        touchAreas = [NSMutableArray array];
    }
    
    [touchAreas removeAllObjects];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float maxBarHeight =rect.size.height * 0.6;
    float xPadding = (rect.size.width - xBarWidth * [_data count])/ ([_data count] + 3);
    float xOffset = (rect.size.width - (xPadding * ([_data count] - 1) + xBarWidth * [_data count])) / 2;
    float yOffset = (rect.size.height - maxBarHeight) / 2 + 25;
    
    float data[[_data count]];
    for(int j=0;j<sizeof(data)/sizeof(float);j++){
        data[j] = 1.0f;
    }
    
    for (int i = 0; i < [_data count]; i++){
        
        float barX = xOffset + i * (xPadding + xBarWidth);
        float barY = yOffset + maxBarHeight - maxBarHeight * data[i];
        float barHeight = maxBarHeight * data[i];
        
        CGRect barRect = CGRectMake(barX, barY, xBarWidth, barHeight);
        [self drawRect:barRect withContext:context andColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        
        [touchAreas addObject:[NSValue valueWithCGRect:barRect]];
        
        barX = xOffset + i * (xPadding + xBarWidth);
        barY = yOffset + maxBarHeight - maxBarHeight * [[_data objectAtIndex:i] floatValue];
        barHeight = maxBarHeight * [[_data objectAtIndex:i] floatValue];
        
        barRect = CGRectMake(barX, barY, xBarWidth, barHeight);
        [self drawRect:barRect withContext:context andColor:[UIColor colorWithRed:106.0/255 green:175.0/255 blue:232.0/255 alpha:1]];
    }
    
    //    CGContextSetTextMatrix(context, CGAffineTransformRotate(CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0), M_PI / 2));
    CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 16, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, LightGrey);
    
    for (int i = 0; i < [_data count]; i++){
        
        float barX = 0.95 * xOffset + i * (xPadding + xBarWidth);
        float barY = 0.80 * yOffset + maxBarHeight - maxBarHeight * data[i];
        
        NSString *theText = [NSString stringWithFormat:@"%.02f%%", [[_data objectAtIndex:i] floatValue] * 100];
        CGContextShowTextAtPoint(context, barX, barY, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    for (int i = 0; i < [touchAreas count]; i++){
        if (CGRectContainsPoint([[touchAreas objectAtIndex:i] CGRectValue], point)){
            
            if ([self.delegate respondsToSelector:@selector(userClickedOnBarCharIndex:)]) {
                [self.delegate userClickedOnBarCharIndex:i];
            }
            break;
        }
    }
}


@end
