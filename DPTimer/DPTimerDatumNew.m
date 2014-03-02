//
// Created by Dani Postigo on 2/28/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimerDatumNew.h"

@implementation DPTimerDatumNew

@synthesize datums;
@synthesize startDate;
@synthesize endDate;

- (instancetype) initWithStartDate: (NSDate *) aStartDate endDate: (NSDate *) anEndDate {
    self = [super init];
    if (self) {
        startDate = aStartDate;
        endDate = anEndDate;
    }
    return self;
}

- (instancetype) initWithStartDate: (NSDate *) aStartDate {
    return [self initWithStartDate: aStartDate endDate: nil];
}


- (void) start {
    [self.datums addObject: [[DPTimerDatumNew alloc] initWithStartDate: [NSDate date]]];
    startDate = self.firstDatum.startDate;
}

- (void) pause {
    DPTimerDatumNew *datum = [self.datums lastObject];
    datum.endDate = [NSDate date];
    endDate = datum.endDate;
}


- (DPTimerDatumNew *) firstDatum {
    return [self.datums count] > 0 ? [self.datums objectAtIndex: 0] : nil;
}

- (DPTimerDatumNew *) lastValidDatum {
    DPTimerDatumNew *ret = [self.datums lastObject];
    while (ret.endDate == nil) {
        ret = [self.datums objectAtIndex: [self.datums indexOfObject: ret]];
    }
    return ret;
}


- (NSMutableArray *) datums {
    if (datums == nil) {
        datums = [[NSMutableArray alloc] init];
    }
    return datums;
}

- (NSTimeInterval) totalTime {
    NSTimeInterval ret = 0;
    for (int j = 0; j < [self.datums count]; j++) {
        DPTimerDatumNew *datum = [self.datums objectAtIndex: j];
        ret += datum.duration;

    }
    return ret;
}


- (NSTimeInterval) duration {
    NSTimeInterval ret = 0;
    if (self.startDate) {
        if (self.endDate) {
            ret = [self.endDate timeIntervalSinceDate: self.startDate];
        } else {
            ret = -[self.startDate timeIntervalSinceNow];
        }
    }

    if (ret < 0) {
        NSLog(@"ret = %f", ret);
    }
    return ret;
}

@end