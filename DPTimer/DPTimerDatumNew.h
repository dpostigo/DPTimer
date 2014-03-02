//
// Created by Dani Postigo on 2/28/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPTimerDatumNew : NSObject {

    NSDate *startDate;
    NSDate *endDate;
    NSMutableArray *datums;
}

@property(nonatomic, strong) NSMutableArray *datums;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;

- (instancetype) initWithStartDate: (NSDate *) aStartDate endDate: (NSDate *) anEndDate;
- (instancetype) initWithStartDate: (NSDate *) aStartDate;


- (void) start;
- (void) pause;
- (NSTimeInterval) totalTime;
@end