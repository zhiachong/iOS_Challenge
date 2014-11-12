//
//  MathFunctions.m
//  Fibonacci
//
//  Created by toxicsun on 11/4/14.
//  Copyright (c) 2014 Arevik Tunyan. All rights reserved.
//

#import "MathFunctions.h"
#import "JKBigInteger.h"

static MathFunctions *shareInstance = nil;

@interface MathFunctions () {
	NSMutableArray *fibNumbers;
	JKBigInteger *prevNumber;
}

@end

@implementation MathFunctions

+ (MathFunctions*)shareInstance {
	if (!shareInstance) {
		shareInstance = [[self alloc] init];
	}
	return shareInstance;
}

- (id) init {
	self = [super init];
	if (self) {
		fibNumbers = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSArray *)getFibonacciSequence:(JKBigInteger*)number {
	if ([number unsignedIntValue] < 1)
		return nil;
	
	[fibNumbers removeAllObjects];
	self.numbersArray = [NSArray arrayWithArray:fibNumbers];
	
	
	JKBigInteger *prevOne = [[JKBigInteger alloc] initWithUnsignedLong:1]; //last
	JKBigInteger *prevTwo = [[JKBigInteger alloc] initWithUnsignedLong:0]; //beforeLast
	JKBigInteger *current = [[JKBigInteger alloc] initWithUnsignedLong:0];
	
	[fibNumbers addObject: [prevOne stringValue]];
	while ([number unsignedIntValue] >= 2) {
		current = [prevOne add:prevTwo];
		[fibNumbers addObject:[current stringValue]];
		prevTwo = prevOne;
		prevOne = current;
		number = [number subtract:[[JKBigInteger alloc] initWithUnsignedLong:1]];
		[self updateNumbersArray];
	}
	
	return (NSArray *)fibNumbers;
}

- (void)updateNumbersArray {
	if ([fibNumbers count] - [self.numbersArray count] > 100) {
		self.numbersArray = [NSArray arrayWithArray:fibNumbers];
		 [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateView" object:nil userInfo:nil];
	}
}

@end
