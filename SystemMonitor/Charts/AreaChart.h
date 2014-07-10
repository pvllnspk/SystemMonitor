//
//  LineChartView.h
//  SystemMonitor
//
//  Created by Barney on 7/5/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"

extern const int STEPS_NUMBER;

@interface AreaChart : UIView

@property (nonatomic) NSMutableArray *sendTraffic;
@property (nonatomic) NSMutableArray *receivedTraffic;

@end
