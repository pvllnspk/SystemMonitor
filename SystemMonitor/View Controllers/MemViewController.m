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
    
    ((PieChart*)self.chartView).valuesArray = [NSArray arrayWithObjects:@"Active", @"Inactive", @"Free", @"Wired", nil];
    
    ((PieChart*)self.chartView).slicesArray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:[System activeMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System inactiveMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System freeMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System wiredMemory]/[System totalMemory]], nil];
    
    ((PieChart*)self.chartView).colorsArray = [NSArray arrayWithObjects:
                              [UIColor colorWithRed:244/255.0f green:245/255.0f blue:28/255.0f alpha:1.f],
                              [UIColor colorWithRed:14/255.0f green:113/255.0f blue:219/255.0f alpha:1.0f],
                              [UIColor colorWithRed:14/255.0f green:223/255.0f blue:47/255.0f alpha:1.0f],
                              [UIColor colorWithRed:244/255.0f green:114/255.0f blue:67/255.0f alpha:1.0f], nil];
    
    [self.chartView setNeedsDisplay];
}


@end
