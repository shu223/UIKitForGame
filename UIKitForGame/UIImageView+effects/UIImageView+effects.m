//
//  UIImageView+effects.m
//
//  Copyright 2011 Shuichi Tsutsumi. All rights reserved.
//

#import "UIImageView+effects.h"
#import "UIImage+fill.h"

@implementation NSObject (Extension)
- (void)executeBlock__:(void (^)(void))block
{
    block();
#if !__has_feature(objc_arc)
    [block release];
#endif
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(executeBlock__:)
               withObject:[block copy]
               afterDelay:delay];
    // アナライザでleakの警告でるが、executeBlock__でreleaseしてるので問題なし
}

@end




@implementation UIImageView (effects)


#pragma mark -------------------------------------------------------------------
#pragma mark Public

- (void)whiteFadeInWithDuration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                         block:(void (^)(void))block
{
    if (!self.image) {
        return;
    }
    
#if !__has_feature(objc_arc)
    UIImageView *effectImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
#else
    UIImageView *effectImageView = [[UIImageView alloc] initWithFrame:self.bounds];
#endif

    effectImageView.backgroundColor = [UIColor clearColor];
    effectImageView.image = [self.image imageFilledWhite];
    effectImageView.contentMode = self.contentMode;
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction;
    [self performBlock:^(void) {
        self.hidden = NO;
        self.alpha = 1.0;
        [self addSubview:effectImageView];
        [UIView animateWithDuration:duration delay:0.0
                            options:options
                         animations:^(void) {
                             effectImageView.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             [effectImageView removeFromSuperview];
                             self.backgroundColor = [UIColor clearColor];
                             
                             if (block) {
                                 block();
                             }
                         }];
    }
            afterDelay:delay];
}


@end
