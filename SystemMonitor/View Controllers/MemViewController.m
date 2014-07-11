//
//  FirstViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "MemViewController.h"

@implementation MemViewController

- (void)initChart{
    
    self.chartView = [[PieChart alloc] initWithFrame:self.view.bounds];
}


- (void) drawChart{
    
    ((PieChart*)self.chartView).sliceArray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:[System activeMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System inactiveMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System freeMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System wiredMemory]/[System totalMemory]],
                             nil];
    
    ((PieChart*)self.chartView).colorsArray = [NSArray arrayWithObjects:(id)LightYellow,
                              (id)LightBlue,
                              (id)LightGreen,
                              (id)LightRed, nil];
    
    [self.chartView setNeedsDisplay];
}


@end
