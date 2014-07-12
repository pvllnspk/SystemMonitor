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
    
    const float peek = 10 * 1024;
    
    NSArray * networkTraffic = [System getNetworkTraffic];
    
    int send = [[networkTraffic objectAtIndex:0] intValue] + [[networkTraffic objectAtIndex:2] intValue];
    int received = [[networkTraffic objectAtIndex:1] intValue] + [[networkTraffic objectAtIndex:3] intValue];
    
    int dSend = send - bSend;
    int dReceived = received - bReceived;
    
    bSend = send;
    bReceived = received;
    
    AreaChart *chart = ((AreaChart*)self.chartView);
    
    [chart setSendTrafficTotal:send];
    [chart setReceivedTrafficTotal:received];
    
    if([[chart sendTrafficBunch] count] > STEPS_NUMBER){
        [[chart sendTrafficBunch] removeObjectAtIndex:0];
    }
    [[chart sendTrafficBunch] addObject:[NSNumber numberWithFloat:(dSend > peek ? 1.0f : dSend / peek)]];
    
    
    if([[chart receivedTrafficBunch] count] > STEPS_NUMBER){
        [[chart receivedTrafficBunch] removeObjectAtIndex:0];
    }
    [[chart receivedTrafficBunch] addObject:[NSNumber numberWithFloat:(dReceived > peek ? 1.0f : dReceived / peek)]];
    
    [chart setNeedsDisplay];
}

@end
