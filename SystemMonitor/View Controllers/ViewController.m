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
    NSTimer *timer;
}

- (void) viewWillAppear:(BOOL)animated{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(drawChart) userInfo:nil repeats:YES];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [timer invalidate];
    timer = nil;
}

@end
