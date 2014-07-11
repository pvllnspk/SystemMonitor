//
//  ChartDelegate.h
//  SystemMonitor
//
//  Created by Barney on 7/11/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChartDelegate <NSObject>

@optional
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(int)lineIndex;
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(int)lineIndex andPointIndex:(int)pointIndex;
- (void)userClickedOnBarCharIndex:(int)barIndex;

@end
