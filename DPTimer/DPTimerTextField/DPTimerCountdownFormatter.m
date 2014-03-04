//
// Created by Dani Postigo on 3/2/14.
//

#import "DPTimerCountdownFormatter.h"

@implementation DPTimerCountdownFormatter

@synthesize showsMilliseconds;

- (NSString *) placeholderString {
    NSMutableString *ret = [[NSMutableString alloc] initWithString: @"00:00:00"];
    if (showsMilliseconds) {
    [ret appendString: @":00"];
    }
    return ret;
}

- (NSString *) stringForObjectValue: (id) anObject {
    if (![anObject isKindOfClass: [NSNumber class]]) {
        return nil;
    }

    NSNumber *intervalNumber = anObject;
    NSTimeInterval interval = [intervalNumber doubleValue];

    if (interval < 0) {
        return nil;
    }


    // Calculate the components
    NSInteger hours = interval / (60 * 60);
    NSInteger minutes = (interval / 60) - (hours * 60);
    NSInteger seconds = interval - (minutes * 60) - (hours * 60 * 60);
    NSInteger milliseconds = 10 * (interval - (seconds) - (minutes * 60) - (hours * 60 * 60));

    //    NSInteger milliseconds = interval - ((NSInteger) interval) * 1000;
    //    NSLog(@"interval = %f, milliseconds = %li", interval, milliseconds);

    // Construct the string
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMinimumIntegerDigits: 2];
    [formatter setNumberStyle: NSNumberFormatterNoStyle];

    NSString *hoursString = [formatter stringFromNumber: @(hours)];
    NSString *minutesString = [formatter stringFromNumber: @(minutes)];
    NSString *secondsString = [formatter stringFromNumber: @(seconds)];
    NSString *millisecondsString = [formatter stringFromNumber: @(milliseconds)];


    NSMutableString *string = [[NSMutableString alloc] initWithFormat: @"%@:%@:%@", hoursString, minutesString, secondsString];
    if (showsMilliseconds) {
        [string appendFormat: @":%@", millisecondsString];
    }
    return string;
}
@end