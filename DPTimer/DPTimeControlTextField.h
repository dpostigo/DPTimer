//
// Created by Dani Postigo on 1/29/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPTimerTextField.h"

@interface DPTimeControlTextField : DPTimerTextField {

    IBOutlet __unsafe_unretained NSButton *toggleButton;
    IBOutlet NSButton *startButton;
    IBOutlet NSButton *stopButton;


    NSString *startTitle;
    NSString *stopTitle;
}

@property(nonatomic, assign) NSButton *toggleButton;
@property(nonatomic, copy) NSString *startTitle;
@property(nonatomic, copy) NSString *stopTitle;
@end