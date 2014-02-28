//
// Created by Dani Postigo on 2/21/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimerDatum.h"

@implementation DPTimerDatum

@synthesize startDate;
@synthesize endDate;
@synthesize pauses;

@synthesize timer;

@synthesize isPaused;
NSString *const kDPTimerDateKey = @"date";
NSString *const kDPTimerIntervalKey = @"interval";

- (instancetype) initWithStartDate: (NSDate *) aStartDate endDate: (NSDate *) anEndDate {
    self = [super init];
    if (self) {
        startDate = aStartDate;
        endDate = anEndDate;
    }

    return self;
}


- (void) start {
    if (startDate == nil) {
        self.startDate = [NSDate date];
    } else {
        [self unpause];
    }
}

- (void) stop {
    self.endDate = [NSDate date];
}

- (void) pause {
    if (!isPaused) {
        isPaused = YES;
        [self stop];

        NSMutableDictionary *pause = [[NSMutableDictionary alloc] init];
        [pause setObject: [NSDate date] forKey: kDPTimerDateKey];
        [self.pauses addObject: pause];
    }

}

- (void) unpause {
    if (isPaused) {
        self.endDate = nil;

        NSMutableDictionary *pause = [self.pauses lastObject];

        NSDate *date = [pause objectForKey: kDPTimerDateKey];
        NSTimeInterval interval = -[date timeIntervalSinceNow];
        [pause setObject: [NSNumber numberWithDouble: interval] forKey: kDPTimerIntervalKey];

    }
}


#pragma mark Pauses

- (NSTimeInterval) interval {
    NSTimeInterval ret = 0;
    if (self.startDate && self.endDate) {
        ret = [self.endDate timeIntervalSinceDate: self.startDate];
    }
    return ret;
}


- (NSArray *) unpausedDatums {

    NSMutableArray *ret = [[NSMutableArray alloc] init];


    NSDate *date = self.startDate;

    for (int j = 0; j < self.pauses.count; j++) {
        DPTimerDatum *datum = [self.pauses objectAtIndex: j];
        [ret addObject: [[DPTimerDatum alloc] initWithStartDate: date endDate: datum.startDate]];
        date = datum.endDate;
    }

    if (self.endDate) {
        [ret addObject: [[DPTimerDatum alloc] initWithStartDate: date endDate: self.endDate]];
    }

    return ret;
}

- (NSMutableArray *) pauses {
    if (pauses == nil) {
        pauses = [[NSMutableArray alloc] init];
    }
    return pauses;
}

@end