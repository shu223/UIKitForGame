//
//  DamageValueLabel.h
//
//  Copyright (c) 2011 Shuichi Tsutsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	DamageAnimationType1,
	DamageAnimationType2,
	DamageAnimationType3,
} DamageAnimationType;


@interface DamageValueLabel : UILabel
- (void)startAnimation;
- (void)startAnimationWithAnimationType:(DamageAnimationType)type;
@end
