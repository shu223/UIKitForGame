//
//  CustomFontLabel.m
//
//  Copyright (c) 2012 Shuichi Tsutsumi. All rights reserved.
//

#import "CustomFontLabel.h"

@implementation CustomFontLabel

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.font = [UIFont fontWithName:kCustomFontName size:self.font.pointSize];
}

- (id)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont fontWithName:kCustomFontName size:fontSize];
    }
    return self;
}

@end
