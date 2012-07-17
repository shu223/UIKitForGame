//
//  DamageValueLabel.m
//
//  Copyright (c) 2011 Shuichi Tsutsumi. All rights reserved.
//

#import "DamageValueLabel.h"


@interface DamageValueLabel ()
{
    CGPoint orgPos;
}
@end


@implementation DamageValueLabel


- (void)initCommon {
    self.hidden = YES;
}

- (void)awakeFromNib {
    [self initCommon];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}



#pragma mark -------------------------------------------------------------------
#pragma mark Private

- (NSArray *)dividedLabels {

    NSString *orgStr = self.text;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    CGPoint nextOrigin = self.frame.origin;
    CGRect frame;
    for (int i=0; i<[orgStr length]; i++) {
        NSString *substr = [orgStr substringWithRange:NSMakeRange(i, 1)];
        CGSize size = [substr sizeWithFont:self.font constrainedToSize:self.frame.size];
        frame.size = size;
        frame.origin = nextOrigin;
        DamageValueLabel *label = [[DamageValueLabel alloc] initWithFrame:frame];
        label.font = self.font;
        label.textColor = self.textColor;
        label.opaque = self.opaque;
        label.backgroundColor = self.backgroundColor;
        label.text = substr;
        [arr addObject:label];
        nextOrigin = CGPointMake(nextOrigin.x + size.width, nextOrigin.y);
    }
    return arr;
}

- (void)startPopAnimationWithDelay:(NSTimeInterval)delay
                removeAtCompletion:(BOOL)removeAtCompletion {
    
    orgPos = self.center;
    self.hidden = NO;
    self.alpha = 0.3;
    CGFloat moveAmount = self.frame.size.height;


    // 上昇
    self.center = CGPointMake(orgPos.x, orgPos.y - moveAmount * 0.8);
    [UIView animateWithDuration:0.12
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         // 上昇
                         self.center = CGPointMake(orgPos.x, self.center.y - moveAmount * 0.2);
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                         // 落下
                         [UIView animateWithDuration:0.22
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                                          animations:^(void) {
                                              
                                              self.center = orgPos;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              // オブジェクト消去
                                              // 消すタイミングは合わせる
                                              CGFloat hideDelay = 0.5 - delay;
                                              hideDelay = hideDelay < 0.0 ? 0.0 : hideDelay;
                                              [UIView animateWithDuration:0.1 delay:hideDelay
                                                                  options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                                                               animations:^(void) {
                                                                   self.alpha = 0.0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   self.hidden = YES;
                                                                   if (removeAtCompletion) {
                                                                       [self removeFromSuperview];
                                                                   }
                                                               }];
                                          }];
                     }];
}

- (void)startPopAnimationWithDelay:(NSTimeInterval)delay {
    [self startPopAnimationWithDelay:delay removeAtCompletion:NO];
}

- (void)startAnimationWithAnimationType1 {
    self.hidden = NO;
    [self startPopAnimationWithDelay:0.0];
}

- (void)startAnimationWithAnimationType2 {
    self.hidden = NO;
    orgPos = self.center;
    self.alpha = 0.0;
    CGAffineTransform scale = CGAffineTransformMakeScale(0.7, 0.7);
    [self setTransform:scale];
    scale = CGAffineTransformMakeScale(1.0, 1.0);
    
    CGFloat moveAmount = self.frame.size.height * 0.15;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         self.center = CGPointMake(orgPos.x, orgPos.y - moveAmount);
                         self.alpha = 1.0;
                         [self setTransform:scale];
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                                          animations:^(void) {
                                              self.center = CGPointMake(orgPos.x, self.center.y - moveAmount);
                                              self.alpha = 0.0;
                                          }
                                          completion:^(BOOL finished) {
                                              self.hidden = YES;
                                          }];
                     }];
}

- (void)startAnimationWithAnimationType3 {
    NSArray *labels = [self dividedLabels];
    self.text = nil;
    self.hidden = YES;
    NSTimeInterval delay = 0.0;
    for (DamageValueLabel *aLabel in labels) {
        [self.superview addSubview:aLabel];
        [aLabel startPopAnimationWithDelay:delay removeAtCompletion:YES];
        delay += 0.04;
    }
}



#pragma mark -------------------------------------------------------------------
#pragma mark Public

- (void)startAnimation {
    [self startAnimationWithAnimationType:DamageAnimationType3];
}


- (void)startAnimationWithAnimationType:(DamageAnimationType)type {
    orgPos = self.center;
    [self.superview bringSubviewToFront:self];
    
    switch (type) {
        case DamageAnimationType1:
            [self startAnimationWithAnimationType1];
            break;
        case DamageAnimationType2:
            [self startAnimationWithAnimationType2];
            break;
        case DamageAnimationType3:
        default:
            [self startAnimationWithAnimationType3];
            break;
    }
}



@end
