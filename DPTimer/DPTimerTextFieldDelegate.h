//
// Created by Dani Postigo on 3/1/14.
//

#import <Foundation/Foundation.h>

@class DPTimerTextFieldNew;

@protocol DPTimerTextFieldDelegate <NSObject>

@optional
- (void) timerTextFieldDidStart: (DPTimerTextFieldNew *) textField;
- (void) timerTextFieldDidPause: (DPTimerTextFieldNew *) textField;
- (void) timerTextFieldDidResume: (DPTimerTextFieldNew *) textField;

@end