//
//  FBNFibNumbers.h
//  FBNTable
//
//  Created by Dzmitry Navak on 04/11/14.
//  Copyright (c) 2014 navakdzmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBNFibNumbers : NSObject

- (id)initWithCapacity:(NSUInteger)capacity;
- (NSString*)fibStringAtPosition:(NSUInteger)position;

- (BOOL)isElementSetted:(NSUInteger)position;

@end
