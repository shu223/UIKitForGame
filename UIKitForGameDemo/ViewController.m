//
//  ViewController.m
//
//  Copyright 2011 Shuichi Tsutsumi. All rights reserved.
//

#import "ViewController.h"
#import "UIView+shake.h"
#import "UIImageView+effects.h"
#import "UIImage+fill.h"
#import <QuartzCore/QuartzCore.h>


@implementation ViewController


- (void)dealloc
{
    [self viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor underPageBackgroundColor];

//    self.shadowView.layer.shadowOpacity = 0.3;
//    self.shadowView.layer.shadowOffset = CGSizeMake(0.0, 5.0);

    [self.segmented setSelectedSegmentIndex:2];
    
    
    // ---- UIImage+fill samples ----
    UIImage *whiteImage     = [self.charaImgView.image imageFilledWhite];
    UIImage *purpleImage    = [self.charaImgView.image imageFilledWithColor:[UIColor purpleColor]];
    UIImage *magentaImage   = [self.charaImgView.image imageFilledWithColor:[UIColor magentaColor]];
    UIImage *cyanImage      = [self.charaImgView.image imageFilledWithColor:[UIColor cyanColor]];
    UIImage *greenImage     = [self.charaImgView.image imageFilledWithColor:[UIColor greenColor]];
    UIImage *brownImage     = [self.charaImgView.image imageFilledWithColor:[UIColor brownColor]];
    UIImage *orangeImage    = [self.charaImgView.image imageFilledWithColor:[UIColor orangeColor]];
    [self saveImage:whiteImage filename:@"white"];
    [self saveImage:purpleImage filename:@"purple"];
    [self saveImage:magentaImage filename:@"magenta"];
    [self saveImage:cyanImage filename:@"cyan"];
    [self saveImage:greenImage filename:@"green"];
    [self saveImage:brownImage filename:@"brown"];
    [self saveImage:orangeImage filename:@"orange"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark -------------------------------------------------------------------
#pragma mark Private

- (void)saveImage:(UIImage *)image filename:(NSString *)filename {
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png",
                          [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],
                          filename];
    if ([data writeToFile:filePath atomically:YES]) {
        NSLog(@"OK");
    } else {
        NSLog(@"Error");
    }
}



#pragma mark -------------------------------------------------------------------
#pragma mark IBAction

- (IBAction)pressDamage {
    
    CGFloat value = 999.0 * self.slider.value;
    
    if (value > 500) {
        self.damageLabel.textColor = [UIColor redColor];
    }
    else {
        self.damageLabel.textColor = [UIColor whiteColor];
    }
    
    self.damageLabel.text = [NSString stringWithFormat:@"%3.0f", value];
    
    DamageAnimationType type;
    switch (self.segmented.selectedSegmentIndex) {
        case 0:
        default:
            type = DamageAnimationType1;
            self.damageLabel.center = CGPointMake(self.charaImgView.center.x, self.charaImgView.center.y + self.charaImgView.frame.size.height * 0.6);
            break;
        case 1:
            type = DamageAnimationType2;
            self.damageLabel.center = CGPointMake(self.charaImgView.center.x, self.charaImgView.center.y - self.charaImgView.frame.size.height * 0.6);
            break;
        case 2:
            type = DamageAnimationType3;
            self.damageLabel.center = CGPointMake(self.charaImgView.center.x, self.charaImgView.center.y + self.charaImgView.frame.size.height * 0.6);
            break;
    }
    
    [self.charaImgView shakeWithCount:10 interval:0.03];
    [self.charaImgView whiteFadeInWithDuration:0.3
                                         delay:0.0
                                         block:^(void) {
                                             [self.damageLabel startAnimationWithAnimationType:type];
                                         }];
}

@end
