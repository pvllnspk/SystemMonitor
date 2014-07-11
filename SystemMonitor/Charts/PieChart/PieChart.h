//
//  PieChartView.h
//  SystemMonitor
//
//  Created by Barney on 7/8/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart.h"

@interface PieChart : Chart

@property (nonatomic, retain) NSArray *sliceArray;
@property (nonatomic, retain) NSArray *colorsArray;

@end
