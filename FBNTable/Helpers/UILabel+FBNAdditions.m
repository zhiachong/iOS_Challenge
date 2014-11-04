//
//  UILabel (additions).m
//  FBNTable
//
//  Created by Dzmitry Navak on 04/11/14.
//  Copyright (c) 2014 navakdzmitry. All rights reserved.
//

#import "UILabel+FBNAdditions.h"

@implementation UILabel (FBNAdditions)

- (void)fbnAdjustFrameSize
{
    self.numberOfLines = 0;
    
    CGRect originalRect = self.frame;
    CGRect resultRect = originalRect;
    
    CGSize size = [self sizeThatFits:originalRect.size];
    
    //sometimes this size is little biggers
    if(size.width <= originalRect.size.width)
    {
        resultRect.size = size;
    }
    else
    {
        CGRect singleLineRect = [self textRectForBounds:originalRect limitedToNumberOfLines:1];
        CGRect textRect = [self textRectForBounds:originalRect limitedToNumberOfLines:self.numberOfLines];
        resultRect.size = textRect.size;
        
        if(textRect.size.height == singleLineRect.size.height)
        {
            //"feature" in iOS. Actual text doesn't fit in returned size.
            resultRect.size.width = originalRect.size.width;
            self.numberOfLines = 1;
            self.minimumScaleFactor = 0;
            self.adjustsFontSizeToFitWidth = YES;
        }
    }
    
    switch (self.textAlignment)
    {
        case NSTextAlignmentLeft:
            resultRect.origin.x = originalRect.origin.x;
            break;
            
        case NSTextAlignmentCenter:
            resultRect.origin.x = originalRect.origin.x + floorf( (originalRect.size.width - resultRect.size.width)/2 );
            break;
            
        case NSTextAlignmentRight:
            resultRect.origin.x = originalRect.origin.x + (originalRect.size.width - resultRect.size.width);
            break;
            
        default:
            resultRect.size.width = originalRect.size.width;
            break;
    }
    self.frame = resultRect;
}

@end
