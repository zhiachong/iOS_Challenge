//
//  FNBCellTableViewCell.m
//  FBNTable
//
//  Created by Dzmitry Navak on 04/11/14.
//  Copyright (c) 2014 navakdzmitry. All rights reserved.
//

#import "FBNCellTableViewCell.h"
#import "UILabel+FBNAdditions.h"

@interface FBNCellTableViewCell ()

@property (nonatomic, strong) UILabel*  positionLabel;
@property (nonatomic, strong) UILabel*  valueLabel;

@end

static const  CGFloat margin = 10;

@implementation FBNCellTableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        [self.contentView addSubview:self.positionLabel];
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.valueLabel.numberOfLines = 0;
        [self.contentView addSubview:self.valueLabel];
    }
    
    return self;
}

- (void)setFibNumber:(NSString*)fibNumber forPosition:(NSUInteger)position
{
    if(![self.valueLabel.text isEqualToString:fibNumber]) {
        
        self.valueLabel.text = fibNumber;
        self.positionLabel.text = [NSString stringWithFormat:@"F(%lu)", (unsigned long)position];
        
        [self setNeedsLayout];
    }
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat positionWidth = CGRectGetWidth(self.positionLabel.bounds);
    
    self.valueLabel.frame = CGRectMake(2*margin + positionWidth,
                                      margin,
                                      CGRectGetWidth(self.contentView.bounds) - 3*margin - positionWidth,
                                      30);
    
    [self.valueLabel fbnAdjustFrameSize];
    [self.positionLabel fbnAdjustFrameSize];
    
    if (CGRectGetHeight(self.valueLabel.bounds) + 2*margin < CGRectGetHeight(self.contentView.bounds)) {
        self.valueLabel.frame = CGRectMake(2*margin + positionWidth,
                                           (CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(self.valueLabel.bounds))/2,
                                           CGRectGetWidth(self.contentView.bounds) - 3*margin - positionWidth,
                                           CGRectGetHeight(self.valueLabel.bounds));
    }
    else {
        self.valueLabel.frame = CGRectMake(2*margin + positionWidth,
                                           margin,
                                           CGRectGetWidth(self.contentView.bounds) - 3*margin - positionWidth,
                                           CGRectGetHeight(self.valueLabel.bounds));
    }
    
    self.positionLabel.frame = CGRectMake(margin,
                                          (CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(self.positionLabel.bounds))/2,
                                          positionWidth,
                                          CGRectGetHeight(self.positionLabel.bounds));
    
}

#pragma mark - publick methods

-(CGFloat) optimalHeight
{
    [self layoutSubviews];
    
    return CGRectGetMaxY(self.valueLabel.frame) + 2*margin;
}

@end
