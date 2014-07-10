//
//  SecondViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "CorViewController.h"
#import "BarChart.h"

@interface CorViewController ()

@property (weak, nonatomic) IBOutlet BackgroundGridView *gridView;
@property (weak, nonatomic) IBOutlet BarChart *chartView;

@end

@implementation CorViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [_gridView setContentMode:UIViewContentModeRedraw];
    [_chartView setContentMode:UIViewContentModeRedraw];
    [_chartView setBackgroundColor:[UIColor clearColor]];
}

- (void) drawChart{
    
    [_chartView setData:[System getCoresUsage]];
    [_chartView setNeedsDisplay];
}

@end
