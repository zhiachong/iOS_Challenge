//
//  MathFunctions.h
//  Fibonacci
//
//  Created by toxicsun on 11/4/14.
//  Copyright (c) 2014 Arevik Tunyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKBigInteger.h"

@interface MathFunctions : NSObject

@property (nonatomic, strong) NSArray *numbersArray;

+ (MathFunctions*)shareInstance;
- (NSArray *)getFibonacciSequence:(JKBigInteger*)number;


@end
