//
//  MathFunctions.h
//  Fibonacci
//
//  Created by toxicsun on 11/4/14.
//  Copyright (c) 2014 Arevik Tunyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathFunctions : NSObject

+ (MathFunctions*)shareInstance;
- (NSArray *)getFibonacciSequence:(NSUInteger)number;


@end
