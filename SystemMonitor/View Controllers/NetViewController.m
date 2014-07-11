//
//  NetworkViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "NetViewController.h"

@implementation NetViewController
{
    int bReceived, bSend;
}

- (void)initChart{
    
    self.chartView = [[AreaChart alloc] initWithFrame:self.view.bounds];
}

- (void) drawChart{
    
    const float peek = 5 * 1024;
    
    NSArray * networkTraffic = [System getNetworkTraffic];
    
    int send = [[networkTraffic objectAtIndex:0] intValue] + [[networkTraffic objectAtIndex:2] intValue];
    int received = [[networkTraffic objectAtIndex:1] intValue] + [[networkTraffic objectAtIndex:3] intValue];
    
    int dSend = send - bSend;
    int dReceived = received - bReceived;
    
    bSend = send;
    bReceived = received;
    
    if([((AreaChart*)self.chartView) sendTraffic]){
        
        if([[((AreaChart*)self.chartView) sendTraffic] count] > STEPS_NUMBER){
            [[((AreaChart*)self.chartView) sendTraffic] removeObjectAtIndex:0];
        }
        [[((AreaChart*)self.chartView) sendTraffic] addObject:[NSNumber numberWithFloat:(dSend > peek ? 1.0f : dSend / peek)]];
        
        [((AreaChart*)self.chartView) setNeedsDisplay];
    }
    
    if([((AreaChart*)self.chartView) receivedTraffic]){
        
        if([[((AreaChart*)self.chartView) receivedTraffic] count] > STEPS_NUMBER){
            [[((AreaChart*)self.chartView) receivedTraffic] removeObjectAtIndex:0];
        }
        [[((AreaChart*)self.chartView) receivedTraffic] addObject:[NSNumber numberWithFloat:(dReceived > peek ? 1.0f : dReceived / peek)]];
        
        [((AreaChart*)self.chartView) setNeedsDisplay];
    }
}

@end
