//
//  SecondViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "CorViewController.h"

@implementation CorViewController

- (void)initChart{
    
    self.chartView = [[BarChart alloc] initWithFrame:self.view.bounds];
}


- (void) drawChart{
    
    [((BarChart*)self.chartView) setData:[System getCoresUsage]];
    [((BarChart*)self.chartView) setNeedsDisplay];
}

@end
