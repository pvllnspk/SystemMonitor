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
    
    [((AreaChart*)self.chartView) setSendTrafficTotal:send];
    [((AreaChart*)self.chartView) setReceivedTrafficTotal:received];
    
    if([((AreaChart*)self.chartView) sendTrafficBunch]){
        
        if([[((AreaChart*)self.chartView) sendTrafficBunch] count] > STEPS_NUMBER){
            [[((AreaChart*)self.chartView) sendTrafficBunch] removeObjectAtIndex:0];
        }
        [[((AreaChart*)self.chartView) sendTrafficBunch] addObject:[NSNumber numberWithFloat:(dSend > peek ? 1.0f : dSend / peek)]];
        
        [((AreaChart*)self.chartView) setNeedsDisplay];
    }
    
    if([((AreaChart*)self.chartView) receivedTrafficBunch]){
        
        if([[((AreaChart*)self.chartView) receivedTrafficBunch] count] > STEPS_NUMBER){
            [[((AreaChart*)self.chartView) receivedTrafficBunch] removeObjectAtIndex:0];
        }
        [[((AreaChart*)self.chartView) receivedTrafficBunch] addObject:[NSNumber numberWithFloat:(dReceived > peek ? 1.0f : dReceived / peek)]];
        
        [((AreaChart*)self.chartView) setNeedsDisplay];
    }
}

@end
