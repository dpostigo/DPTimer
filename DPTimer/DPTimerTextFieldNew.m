//
// Created by Dani Postigo on 2/28/14.
//

#import <DPKit/NSObject+CallSelector.h>
#import "DPTimerTextFieldNew.h"
#import "WDCountdownFormatter.h"
#import "DPTimerDatumNew.h"
#import "DPTimerTextFieldDelegate.h"

@implementation DPTimerTextFieldNew

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
        self.formatter = [[WDCountdownFormatter alloc] init];
    }

}

- (void) awakeFromNib {
    [super awakeFromNib];
    [[self cell] setPlaceholderString: @"00:00:00"];
}


#pragma mark Timer start

- (void) timerStart {
    if (!isRunning) {
        isRunning = YES;
        [self.timerDatum start];
        [self startUpdating];
        self.didStart = YES;
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

    NSTimeInterval interval = -[self.timerDatum.startDate timeIntervalSinceNow];
    self.doubleValue = self.timerDatum.totalTime;
}


#pragma mark Getters
- (DPTimerDatumNew *) timerDatum {
    if (timerDatum == nil) {
        timerDatum = [[DPTimerDatumNew alloc] init];
    }
    return timerDatum;
}


- (NSDate *) startDate {
    return self.timerDatum.startDate;
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