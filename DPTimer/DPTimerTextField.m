//
// Created by Dani Postigo on 1/30/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimerTextField.h"
#import "DPTimerDatum.h"

@implementation DPTimerTextField

@synthesize isRunning;

@synthesize startBlock;
@synthesize stopBlock;
@synthesize toggleBlock;

- (void) awakeFromNib {
    [super awakeFromNib];
    self.doubleValue = 0;
}


#pragma mark Public

- (void) start {
    [super start];
    if (!self.isRunning) {
        isRunning = YES;
        [self timerStart];

        [self.timerData start];
        if (startBlock) self.startBlock(self);
    }
}

- (void) pause {
    [super pause];
    if (self.isRunning) {
        isRunning = NO;
        [self timerStop];

        [self.timerData pause];
        if (stopBlock) self.stopBlock(self);
    }
}

- (void) toggle {
    [super toggle];

    if (self.isRunning) {
        [self pause];
    } else {
        if (self.startDate == nil) {
            [self start];
        } else {

            [self restart];
        }
    }

    if (toggleBlock) self.toggleBlock(self);
}

- (void) restart {
    [super restart];
    NSTimeInterval interval = -[self.stopDate timeIntervalSinceNow];
    pausedTime += interval;

    NSLog(@"pausedTime = %f", pausedTime);
    [self.timerData unpause];
    [self start];
}


@end