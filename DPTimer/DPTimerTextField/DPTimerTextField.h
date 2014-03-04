//
// Created by Dani Postigo on 2/28/14.
//

#import <Foundation/Foundation.h>

@class DPTimerDatumNew;
@protocol DPTimerTextFieldDelegate;
@class WDCountdownFormatter;
@class DPTimerCountdownFormatter;

@interface DPTimerTextField : NSTextField {
    IBOutlet DPTimerDatumNew *timerDatum;
    BOOL isRunning;
    BOOL didStart;
    NSTimer *timer;

    __unsafe_unretained id <DPTimerTextFieldDelegate> timerDelegate;
}

@property(nonatomic, strong) DPTimerDatumNew *timerDatum;
@property(nonatomic) BOOL isRunning;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) id <DPTimerTextFieldDelegate> timerDelegate;
@property(nonatomic) BOOL didStart;

@property(nonatomic, strong) NSDate *startDate;
- (DPTimerCountdownFormatter *) countdownFormatter;
- (void) reset;
- (IBAction) timerStart: (id) sender;
- (IBAction) timerPause: (id) sender;
- (IBAction) timerToggle: (id) sender;
- (NSTimeInterval) totalTime;
- (NSDate *) endDate;
@end