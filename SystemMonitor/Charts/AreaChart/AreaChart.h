//
//  LineChartView.h
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart.h"

extern const int STEPS_NUMBER;

@interface AreaChart : Chart

@property (nonatomic) NSMutableArray *sendTraffic;
@property (nonatomic) NSMutableArray *receivedTraffic;

@end
