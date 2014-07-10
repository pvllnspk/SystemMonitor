//
//  FirstViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "MemViewController.h"

@interface MemViewController ()

@property (weak, nonatomic) IBOutlet BackgroundGridView *gridView;
@property (weak, nonatomic) IBOutlet PieChart *chartView;

@end

@implementation MemViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [_gridView setContentMode:UIViewContentModeRedraw];
    [_chartView setContentMode:UIViewContentModeRedraw];
    [_chartView setBackgroundColor:[UIColor clearColor]];
}


- (void) drawChart{
    
    _chartView.sliceArray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:[System activeMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System inactiveMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System freeMemory]/[System totalMemory]],
                             [NSNumber numberWithFloat:[System wiredMemory]/[System totalMemory]],
                             nil];
    
    _chartView.colorsArray = [NSArray arrayWithObjects:(id)LightYellow,
                              (id)LightBlue,
                              (id)LightGreen,
                              (id)LightRed, nil];
    
    [_chartView setNeedsDisplay];
}


@end
