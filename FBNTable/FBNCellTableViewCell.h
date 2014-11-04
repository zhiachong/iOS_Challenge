//
//  FNBCellTableViewCell.h
//  FBNTable
//
//  Created by Dzmitry Navak on 04/11/14.
//  Copyright (c) 2014 navakdzmitry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBNCellTableViewCell : UITableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (CGFloat)optimalHeight;
- (void)setFibNumber:(NSString*)fibNumber forPosition:(NSUInteger)position;

@end
