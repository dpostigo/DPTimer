//
// Created by Dani Postigo on 1/30/14.
// Copyright (c) 2014 Dani Postigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPTimerControlCore.h"

@class DPTimerTextField;


typedef void(^DPTimerTextFieldBlock)(DPTimerTextField *textField);

@interface DPTimerTextField : DPTimerControlCore {

    BOOL isRunning;


    DPTimerTextFieldBlock startBlock;
    DPTimerTextFieldBlock stopBlock;
    DPTimerTextFieldBlock toggleBlock;
}

@property(nonatomic) BOOL isRunning;

@property(nonatomic) NSTimeInterval pausedTime;
@property(nonatomic, strong) NSDate *stopDate;
@property(nonatomic, strong) NSDate *startDate;

@property(nonatomic, copy) DPTimerTextFieldBlock startBlock;
@property(nonatomic, copy) DPTimerTextFieldBlock stopBlock;
@property(nonatomic, copy) DPTimerTextFieldBlock toggleBlock;


@end