//
//  DQView.m
//  UIViewWithDQFrameDemo
//
//  Created by shuichi on 12/08/09.
//  Copyright (c) 2012年 shuichi. All rights reserved.
//

#import "DQView.h"
#import <QuartzCore/QuartzCore.h>


@implementation DQView

- (void)drawRect:(CGRect)rect {

    CGContextRef c = UIGraphicsGetCurrentContext();

    CGContextSetRGBStrokeColor(c, 0.4, 0.4, 0.4, 1.0);
    [self drawDQFramePathWithContext:c lineWidth:1.0 margin:0 cornerRadius:5.0];

    CGContextSetRGBStrokeColor(c, 0.7, 0.7, 0.7, 1.0);
    [self drawDQFramePathWithContext:c lineWidth:1.0 margin:1 cornerRadius:4.0];

    CGContextSetRGBStrokeColor(c, 1.0, 1.0, 1.0, 1.0);
    [self drawDQFramePathWithContext:c lineWidth:1.5 margin:2 cornerRadius:3.0];
}

- (void)layoutSubviews {
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
}



#pragma mark -------------------------------------------------------------------
#pragma mark Private

- (void)drawDQFramePathWithContext:(CGContextRef)c
                         lineWidth:(CGFloat)lineWidth
                            margin:(CGFloat)margin
                      cornerRadius:(CGFloat)cornerRadius
{
	CGContextSetLineWidth(c, lineWidth);
    CGMutablePathRef framePath = CGPathCreateMutable();
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    // 上／中央からスタート
    CGPathMoveToPoint(framePath, NULL, w / 2, margin);
    
    // 右上
    CGPathAddArcToPoint(framePath, NULL,
                        w - margin, margin,
                        w - margin, margin + cornerRadius,
                        cornerRadius);
    // 右下
    CGPathAddArcToPoint(framePath, NULL,
                        w - margin, h - margin,
                        w - margin - cornerRadius, h - margin,
                        cornerRadius);
    // 左下
    CGPathAddArcToPoint(framePath, NULL,
                        margin, h - margin,
                        margin, h - margin - cornerRadius,
                        cornerRadius);
    // 左上
    CGPathAddArcToPoint(framePath, NULL,
                        margin, margin,
                        margin + cornerRadius, margin,
                        cornerRadius);
    
    CGPathAddLineToPoint(framePath, NULL, w / 2, margin);
    
    
    CGPathCloseSubpath(framePath);
    
    CGContextAddPath(c, framePath);
    CGContextDrawPath(c, kCGPathStroke);
    
	CGPathRelease(framePath);
}

@end
