//
//  ViewController.h
//  SystemMonitor
//
//  Created by Barney on 7/10/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundGridView.h"
#import "Chart.h"
#import "System.h"
#import "ChartDelegate.h"

@interface ViewController : UIViewController <ChartDelegate>

@property (nonatomic) Chart *chartView;

@end
