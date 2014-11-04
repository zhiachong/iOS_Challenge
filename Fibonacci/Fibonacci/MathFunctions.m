//
//  MathFunctions.m
//  Fibonacci
//
//  Created by toxicsun on 11/4/14.
//  Copyright (c) 2014 Arevik Tunyan. All rights reserved.
//

#import "MathFunctions.h"

static MathFunctions *shareInstance = nil;

@implementation MathFunctions

+ (MathFunctions*)shareInstance {
	if (!shareInstance) {
		shareInstance = [[self alloc] init];
	}
	return shareInstance;
}

- (NSArray *)getFibonacciSequence:(NSUInteger)number {
	NSMutableArray *fibonacciNumbers = [NSMutableArray array];
	
	[fibonacciNumbers addObject: [NSNumber numberWithUnsignedInt: 0]];
	[fibonacciNumbers addObject: [NSNumber numberWithUnsignedInt: 1]];
	
	unsigned int prevTwo = 0, prevOne = 1, current;
	
	do {
		current = prevOne + prevTwo;
		[fibonacciNumbers addObject: [NSNumber numberWithUnsignedInt: current]];
		prevTwo = prevOne, prevOne = current;
	} while (prevOne <= number - prevTwo);
 
	return (NSArray *)fibonacciNumbers;
}

@end
