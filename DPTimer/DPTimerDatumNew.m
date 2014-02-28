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
    return [self initWithStartDate: startDate endDate: nil];
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

@end