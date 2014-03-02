//
// Created by Dani Postigo on 2/21/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import "DPTimerControlCore.h"
#import "DPTimerDatum.h"

@implementation DPTimerControlCore {
    NSTimer *timer;
}

@synthesize timer;
@synthesize pausedTime;

@synthesize autostarts;

@synthesize timerData;

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        [self setup];
    }
    return self;
}


- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        [self setup];
    }
    return self;
}


- (void) setup {
    autostarts = YES;

}


- (void) setStartDate: (NSDate *) startDate {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    self.timerData.startDate = startDate;
    if (self.startDate && autostarts) {
        [self start];
    }
}

- (NSDate *) startDate {
    return self.timerData.startDate;
}

- (void) setStopDate: (NSDate *) stopDate {
    self.timerData.endDate = stopDate;
}

- (NSDate *) stopDate {
    return self.timerData.endDate;
}


#pragma mark Timer

- (void) timerStart {

    if (self.startDate == nil) {
        self.startDate = [NSDate date];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(timerUpdate:) userInfo: nil repeats: YES];
}

- (void) timerStop {
    [timer invalidate];
}

- (void) timerUpdate: (id) sender {
    NSTimeInterval interval = -[self.startDate timeIntervalSinceNow];
    self.doubleValue = interval - pausedTime;
}

#pragma mark Autostart



#pragma mark Public

- (void) toggle {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void) start {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void) pause {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void) restart {
    //    NSLog(@"%s", __PRETTY_FUNCTION__);
}


#pragma mark Sender

- (IBAction) toggle: (id) sender {
    [self toggle];
}

- (IBAction) start: (id) sender {
    [self start];
}

- (IBAction) pause: (id) sender {
    [self pause];
}



#pragma mark Getters

- (DPTimerDatum *) timerData {
    if (timerData == nil) {
        timerData = [[DPTimerDatum alloc] init];
    }
    return timerData;
}


@end