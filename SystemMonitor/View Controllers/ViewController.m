//
//  ViewController.m
//  SystemMonitor
//
//  Created by Barney on 7/10/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
{
    BackgroundGridView *gridView;
    NSTimer *timer;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    gridView = [[BackgroundGridView alloc] initWithFrame:self.view.bounds];
    [gridView setContentMode:UIViewContentModeRedraw];
    [gridView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:gridView];
    
    [self performSelector:@selector(initChart) withObject: nil];
    [_chartView setContentMode:UIViewContentModeRedraw];
    [_chartView setBackgroundColor:[UIColor clearColor]];
    _chartView.delegate = self;
    [self.view addSubview:_chartView];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    gridView.frame = self.view.bounds;
    _chartView.frame = self.view.bounds;
    [gridView setNeedsDisplay];
    [_chartView setNeedsDisplay];
}


- (void) viewWillAppear:(BOOL)animated{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(drawChart) userInfo:nil repeats:YES];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [timer invalidate];
    timer = nil;
}

@end
