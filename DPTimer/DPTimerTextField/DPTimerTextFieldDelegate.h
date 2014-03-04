//
// Created by Dani Postigo on 3/1/14.
//

#import <Foundation/Foundation.h>

@class DPTimerTextField;

@protocol DPTimerTextFieldDelegate <NSObject>

@optional
- (void) timerTextFieldDidStart: (DPTimerTextField *) textField;
- (void) timerTextFieldDidPause: (DPTimerTextField *) textField;
- (void) timerTextFieldDidResume: (DPTimerTextField *) textField;

- (void) timerTextFieldDidIncrementMinute: (DPTimerTextField *) textField;
- (void) timerTextFieldDidIncrementHour: (DPTimerTextField *) textField;

@end