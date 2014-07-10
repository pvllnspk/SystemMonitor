//
//  System.m
//  SystemMonitor
//
//  Created by Barney on 7/9/14.
//  Copyright (c) 2014 pvllnspk. All rights reserved.
//

#import "System.h"

@implementation System

+ (NSArray *)getCoresUsage{
    
    processor_info_array_t _cpuInfo, _prevCpuInfo = NULL;
    mach_msg_type_number_t _numCpuInfo, _numPrevCpuInfo = 0;
    unsigned _numCPUs;
    NSLock *_CPUUsageLock;
    
    NSMutableArray *_cores;
    
    int mib[2U] = { CTL_HW, HW_NCPU };
    size_t sizeOfNumCPUs = sizeof(_numCPUs);
    int status = sysctl(mib, 2U, &_numCPUs, &sizeOfNumCPUs, NULL, 0U);
    if (status) _numCPUs = 1;
    _CPUUsageLock = [[NSLock alloc] init];
    
    _cores = [NSMutableArray array];
    
    natural_t numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &_cpuInfo, &_numCpuInfo);
    
    if(err == KERN_SUCCESS)
    {
        [_CPUUsageLock lock];
        
        for(unsigned i = 0U; i < _numCPUs; ++i)
        {
            float inUse, total;
            if(_prevCpuInfo)
            {
                inUse = (
                         (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                         + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                         + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                         );
                
                total = inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
                
            } else
            {
                inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                total = inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            
            [_cores addObject:[NSNumber numberWithFloat: inUse / total ]];
        }
        
        [_CPUUsageLock unlock];
        
        if(_prevCpuInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCpuInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCpuInfo, prevCpuInfoSize);
        }
        
        _prevCpuInfo = _cpuInfo;
        _numPrevCpuInfo = _numCpuInfo;
        
        _cpuInfo = NULL;
        _numCpuInfo = 0U;
    } else
    {
        NSLog(@"Error!");
    }
    return _cores;
}

+ (NSArray *)getNetworkTraffic{
    
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    success = getifaddrs(&addrs) == 0;
    if (success){
        
        cursor = addrs;
        while (cursor != NULL){
            
            NSString * name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            
            if (cursor->ifa_addr->sa_family == AF_LINK){
                
                if ([name hasPrefix:@"en"]){
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    
                }
                if ([name hasPrefix:@"pdp_ip"]){
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
}

+ (NSInteger)totalMemory {
    int nearest = 256;
    int totalMemory = [[NSProcessInfo processInfo] physicalMemory] / 1024 / 1024;
    int rem = (int)totalMemory % nearest;
    int tot = 0;
    if (rem >= nearest/2) {
        tot = ((int)totalMemory - rem)+256;
    } else {
        tot = ((int)totalMemory - rem);
    }
    
    return tot;
}

+ (CGFloat)freeMemory {
    double totalMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    totalMemory = ((vm_page_size * vmStats.free_count) / 1024) / 1024;
    
    return totalMemory;
}

+ (CGFloat)usedMemory {
    double usedMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    usedMemory = ((vm_page_size * (vmStats.active_count + vmStats.inactive_count + vmStats.wire_count)) / 1024) / 1024;
    
    return usedMemory;
}

+ (CGFloat)activeMemory {
    double activeMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    activeMemory = ((vm_page_size * vmStats.active_count) / 1024) / 1024;
    
    return activeMemory;
}

+ (CGFloat)inactiveMemory {
    double inactiveMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    inactiveMemory = ((vm_page_size * vmStats.inactive_count) / 1024) / 1024;
    
    return inactiveMemory;
}

+ (CGFloat)wiredMemory {
    double wiredMemory = 0.00;
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return -1;
    }
    wiredMemory = ((vm_page_size * vmStats.wire_count) / 1024) / 1024;
    
    return wiredMemory;
}

@end
