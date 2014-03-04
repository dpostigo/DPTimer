//
// Created by Dani Postigo on 2/28/14.
//

#import <DPKit/NSObject+CallSelector.h>
#import "DPTimerTextField.h"
#import "WDCountdownFormatter.h"
#import "DPTimerDatumNew.h"
#import "DPTimerTextFieldDelegate.h"
#import "DPTimerCountdownFormatter.h"

@implementation DPTimerTextField

@synthesize isRunning;
@synthesize timerDatum;

@synthesize timer;
@synthesize timerDelegate;
@synthesize didStart;

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        [self setup];
    }

    return self;
}

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if (self) {
        [self setup];
    }

    return self;
}


- (void) setup {
    if (self.formatter == nil || (self.formatter && ![self.formatter isKindOfClass: [WDCountdownFormatter class]])) {
        self.formatter = [[DPTimerCountdownFormatter alloc] init];
    }
}

- (DPTimerCountdownFormatter *) countdownFormatter {
    return [self.formatter isKindOfClass: [DPTimerCountdownFormatter class]] ? self.formatter : nil;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [[self cell] setPlaceholderString: @"00:00:00"];
}


#pragma mark Reset

- (void) reset {
    [self timerPause];
    [[self cell] setPlaceholderString: @"00:00:00"];
    timerDatum = nil;
    didStart = NO;
    [self timerUpdate: nil];

}

#pragma mark Timer start

- (void) timerStart {
    if (!isRunning) {
        isRunning = YES;
        [self.timerDatum start];
        [self startUpdating];
        self.didStart = YES;
        [self timerUpdate: nil];
        [self forwardSelector: @selector(timerTextFieldDidResume:) delegate: timerDelegate object: self];
    }
}

- (IBAction) timerStart: (id) sender {
    [self timerStart];
}

#pragma mark Timer pause

- (void) timerPause {
    if (isRunning) {
        isRunning = NO;
        [self.timerDatum pause];
        [self stopUpdating];
        [self forwardSelector: @selector(timerTextFieldDidPause:) delegate: timerDelegate object: self];

    }
}

- (IBAction) timerPause: (id) sender {
    [self timerPause];
}


#pragma mark Timer toggle

- (void) timerToggle {
    if (isRunning) {
        [self timerPause];
    } else {
        [self timerStart];
    }
}


- (IBAction) timerToggle: (id) sender {
    [self timerToggle];
}


#pragma mark Timer management

- (void) startUpdating {
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(timerUpdate:) userInfo: nil repeats: YES];
}

- (void) stopUpdating {
    [timer invalidate];
}

- (void) timerUpdate: (id) sender {
    double timePassed_ms = [self.timerDatum.startDate timeIntervalSinceNow] * -1000.0;

    NSTimeInterval interval = -[self.timerDatum.startDate timeIntervalSinceNow];
    self.doubleValue = self.timerDatum.totalTime;

    double remainder = fmod(self.timerDatum.totalTime, 60);
    if (remainder < 1) {
        NSLog(@"remainder = %f", remainder);
    }
    if (fmod(self.timerDatum.totalTime, 60) < 1) {
        [self forwardSelector: @selector(timerTextFieldDidIncrementMinute:) delegate: timerDelegate object: self];
    }

    if (fmod(self.timerDatum.totalTime, 60 * 60) < 1) {
        [self forwardSelector: @selector(timerTextFieldDidIncrementHour:) delegate: timerDelegate object: self];
    }
}


#pragma mark Getters

- (DPTimerDatumNew *) timerDatum {
    if (timerDatum == nil) {
        timerDatum = [[DPTimerDatumNew alloc] init];
    }
    return timerDatum;
}


#pragma mark Start Date

- (NSDate *) startDate {
    return self.timerDatum.startDate;
}

- (void) setStartDate: (NSDate *) startDate {
    self.timerDatum.startDate = startDate;
    [self timerUpdate: nil];
}


- (NSTimeInterval) totalTime {
    return self.timerDatum.totalTime;
}

- (NSDate *) endDate {
    return self.timerDatum.endDate;
}


- (void) setDidStart: (BOOL) didStart1 {
    if (didStart != didStart1) {
        didStart = didStart1;
        [self forwardSelector: @selector(timerTextFieldDidStart:) delegate: timerDelegate object: self];

    }
}

@end