//
// Created by Dani Postigo on 2/21/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kDPTimerDateKey;
extern NSString *const kDPTimerIntervalKey;

@interface DPTimerDatum : NSObject {
    NSDate *startDate;
    NSDate *endDate;
    NSMutableArray *pauses;

    NSTimer *timer;
    BOOL isPaused;
}

@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;

@property(nonatomic, strong) NSMutableArray *pauses;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic) BOOL isPaused;
- (instancetype) initWithStartDate: (NSDate *) aStartDate endDate: (NSDate *) anEndDate;

- (void) start;
- (void) pause;
- (void) unpause;
- (NSTimeInterval) interval;
- (NSArray *) unpausedDatums;
@end