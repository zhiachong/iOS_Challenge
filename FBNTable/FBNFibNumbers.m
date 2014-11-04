//
//  FBNFibNumbers.m
//  FBNTable
//
//  Created by Dzmitry Navak on 04/11/14.
//  Copyright (c) 2014 navakdzmitry. All rights reserved.
//

#import "FBNFibNumbers.h"
#import "JKBigInteger.h"

@interface FBNFibNumbers()

@property (nonatomic, strong) NSMutableArray* fibNumbers;

@end

@implementation FBNFibNumbers

- (id)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    
    if (self) {
        if (capacity<2) {
            capacity = 2;
        }
        
        _fibNumbers = [[NSMutableArray alloc] initWithCapacity:capacity];
        for (int i = 0; i < capacity; i++) {
            _fibNumbers[i] = [[JKBigInteger alloc] initWithUnsignedLong:0];
        }
        
        _fibNumbers[1] = [[JKBigInteger alloc] initWithUnsignedLong:1];
    }
    
    return self;
}

- (NSString*)fibStringAtPosition:(NSUInteger)position
{
    return [[self fibNumberAtPosition:position] stringValue];
}

- (BOOL)isElementSetted:(NSUInteger)position
{
    if (position < 2) {
        return YES;
    }
    
    if (position < [_fibNumbers count]) {
        JKBigInteger* current = _fibNumbers[position];
        JKBigInteger* bigZero = [[JKBigInteger alloc] initWithUnsignedLong:0];
        return [current compare:bigZero] != NSOrderedSame;
    }
    
    return NO;
}

- (JKBigInteger*)fibNumberAtPosition:(NSUInteger)position
{
    if (position < 2)
        return [[JKBigInteger alloc] initWithUnsignedLong:position];
    
    JKBigInteger* current = _fibNumbers[position];
    JKBigInteger* before = _fibNumbers[position-1];
    JKBigInteger* bigZero = [[JKBigInteger alloc] initWithUnsignedLong:0];

    if ([current compare:bigZero] != NSOrderedSame) {
        return current;
    }
    
    if ([before compare:bigZero] == NSOrderedSame) {
        self.fibNumbers[position-1] = [self fibNumberAtPosition:(position-1)];
    }
    
    JKBigInteger* newFib = [self.fibNumbers[position-1] add:self.fibNumbers[position-2]];
    self.fibNumbers[position] = newFib;
    
    return newFib;
}

@end
