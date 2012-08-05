//
//  ViewController.m
//
//  Copyright 2011 Shuichi Tsutsumi. All rights reserved.
//

#import "ViewController.h"
#import "UIView+shake.h"
#import "UIImageView+effects.h"
#import "UIImage+fill.h"


@implementation ViewController

@synthesize slider;
@synthesize segmented;
@synthesize charaImgView;
@synthesize damageLabel;


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
    
    [self.segmented setSelectedSegmentIndex:2];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark -------------------------------------------------------------------
#pragma mark IBAction

- (IBAction)pressDamage {
    
    CGFloat value = 999.0 * slider.value;
    
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
