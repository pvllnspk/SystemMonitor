//
//  Chart.h
//  SystemMonitor
//
//  Created by Barney on 7/11/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Color.h"
#import "ChartDelegate.h"

@interface Chart : UIView

@property (nonatomic, retain) id<ChartDelegate> delegate;

@end
