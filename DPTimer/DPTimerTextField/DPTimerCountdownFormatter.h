//
// Created by Dani Postigo on 3/2/14.
//

#import <Foundation/Foundation.h>
#import "WDCountdownFormatter.h"

@interface DPTimerCountdownFormatter : WDCountdownFormatter {

    BOOL showsMilliseconds;
}

@property(nonatomic) BOOL showsMilliseconds;
@end