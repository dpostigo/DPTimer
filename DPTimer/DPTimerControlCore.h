//
// Created by Dani Postigo on 2/21/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPTimerDatum;

@interface DPTimerControlCore : NSTextField {
    BOOL autostarts;

    NSTimeInterval pausedTime;

    DPTimerDatum *timerData;

}

@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *stopDate;

@property(nonatomic) BOOL autostarts;
@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic) NSTimeInterval pausedTime;

@property(nonatomic, strong) DPTimerDatum *timerData;
- (void) timerStart;
- (void) timerStop;

- (void) pause;
- (void) start;
- (void) restart;
- (void) toggle;

- (IBAction) pause: (id) sender;
- (IBAction) start: (id) sender;
- (IBAction) toggle: (id) sender;

@end