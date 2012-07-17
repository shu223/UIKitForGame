//
//  UIImageView+effects.h
//
//  Copyright 2011 Shuichi Tsutsumi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Extension)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end


@interface UIImageView (effects)

- (void)whiteFadeInWithDuration:(NSTimeInterval)duration
                         delay:(NSTimeInterval)delay
                         block:(void (^)(void))block;

@end
