//
//  NetworkViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "NetViewController.h"

@interface NetViewController ()

@property (weak, nonatomic) IBOutlet BackgroundGridView *gridView;
@property (weak, nonatomic) IBOutlet AreaChart *chartView;

@end

@implementation NetViewController
{
    int bReceived, bSend;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_gridView setContentMode:UIViewContentModeRedraw];
    [_chartView setContentMode:UIViewContentModeRedraw];
    [_chartView setBackgroundColor:[UIColor clearColor]];
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
    
    if([_chartView sendTraffic]){
        
        if([[_chartView sendTraffic] count] > STEPS_NUMBER){
            [[_chartView sendTraffic] removeObjectAtIndex:0];
        }
        [[_chartView sendTraffic] addObject:[NSNumber numberWithFloat:(dSend > peek ? 1.0f : dSend / peek)]];
        
        [_chartView setNeedsDisplay];
    }
    
    if([_chartView receivedTraffic]){
        
        if([[_chartView receivedTraffic] count] > STEPS_NUMBER){
            [[_chartView receivedTraffic] removeObjectAtIndex:0];
        }
        [[_chartView receivedTraffic] addObject:[NSNumber numberWithFloat:(dReceived > peek ? 1.0f : dReceived / peek)]];
        
        [_chartView setNeedsDisplay];
    }
}

@end
