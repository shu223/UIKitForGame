//
//  UIView+effects.m
//
//  Copyright 2011 Shuichi Tsutsumi. All rights reserved.
//

#import "UIView+shake.h"


@implementation UIView (shake)


#pragma mark -------------------------------------------------------------------
#pragma mark Private

- (void)shaking:(NSTimer *)aTimer {
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:[aTimer userInfo]];
    [aTimer invalidate];
    aTimer = nil;
    int shakeCnt = [[info objectForKey:@"count"] intValue];
    CGPoint orgCenter = [[info objectForKey:@"center"] CGPointValue];
	CGPoint to;
	if (shakeCnt % 2 == 0 && shakeCnt > 0) {
		to = CGPointMake(orgCenter.x + floor(random() % shakeCnt) - shakeCnt / 2,
						 orgCenter.y + floor(random() % shakeCnt) - shakeCnt / 2);
	}else {
		to = orgCenter;
	}
    
	[self setCenter:to];
	shakeCnt--;
	if (shakeCnt > 0) {
        [info setObject:[NSNumber numberWithInt:shakeCnt] forKey:@"count"];
        [NSTimer scheduledTimerWithTimeInterval:[[info objectForKey:@"interval"] doubleValue]
                                         target:self
                                       selector:@selector(shaking:)
                                       userInfo:info repeats:NO];	
    }
}


#pragma mark -------------------------------------------------------------------
#pragma mark Public

- (void)shakeWithCount:(int)count interval:(NSTimeInterval)interval {
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithDouble:interval], @"interval",
                          [NSNumber numberWithInt:count],@"count",
                          [NSValue valueWithCGPoint:self.center],@"center",
                          nil];
	[NSTimer scheduledTimerWithTimeInterval:interval target:self
								   selector:@selector(shaking:)
								   userInfo:info repeats:NO];	
}



@end
