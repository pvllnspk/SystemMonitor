//
//  System.h
//  SystemMonitor
//
//  Created by Barney on 7/9/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach/mach.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

@interface System : NSObject

+ (NSArray *)getCoresUsage;

+ (NSArray *)getNetworkTraffic;

+ (NSInteger)totalMemory;

+ (CGFloat)freeMemory;

+ (CGFloat)wiredMemory;

+ (CGFloat)activeMemory;

+ (CGFloat)inactiveMemory;

+ (CGFloat)usedMemory;

@end
