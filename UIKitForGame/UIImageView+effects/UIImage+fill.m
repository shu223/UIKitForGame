//
//  UIImage+fill.m
//  UIKitForGameDemo
//
//  Created by shuichi on 12/07/17.
//
//

#import "UIImage+fill.h"

@implementation UIImage (fill)

- (UIImage *)imageFilledWithColor:(UIColor *)color {

	const size_t width = self.size.width;
	const size_t height = self.size.height;
	const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
	if (!bmContext)
		return nil;
    
	CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, self.CGImage);
    
	UInt8 *data = (UInt8*)CGBitmapContextGetData(bmContext);
	if (!data)
	{
		CGContextRelease(bmContext);
		return nil;
	}

    const CGFloat *components = CGColorGetComponents(color.CGColor);
    const int numComponents = CGColorGetNumberOfComponents(color.CGColor);
    CGFloat r, g, b;
    if (numComponents == 4) {
        r = components[0];
        g = components[1];
        b = components[2];
    } else {
        r = g = b = components[0];
    }

    unsigned char R = (unsigned char)(r * 255.);
    unsigned char G = (unsigned char)(g * 255.);
    unsigned char B = (unsigned char)(b * 255.);

    const size_t bitmapByteCount = bytesPerRow * height;
    for (int i=0; i < bitmapByteCount; i+=4) {

        if (data[i+0] == 0 ||
            (data[i+1] == 0 &&
             data[i+2] == 0 &&
             data[i+3] == 0))
        {
            continue;
        }

        data[i+1] = R;
        data[i+2] = G;
        data[i+3] = B;
    }

	CGImageRef dstImageRef = CGBitmapContextCreateImage(bmContext);
	UIImage *dstImage = [UIImage imageWithCGImage:dstImageRef];
    
	CGImageRelease(dstImageRef);
	CGContextRelease(bmContext);
    
    return dstImage;
}

- (UIImage *)imageFilledBlack {
    return [self imageFilledWithColor:[UIColor blackColor]];
}

- (UIImage *)imageFilledWhite {
    return [self imageFilledWithColor:[UIColor whiteColor]];
}

@end
