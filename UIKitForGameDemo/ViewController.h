//
//  ViewController.h
//
//  Copyright 2011 Shuichi Tsutsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DamageValueLabel.h"


@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmented;
@property (nonatomic, retain) IBOutlet UIImageView *charaImgView;
@property (nonatomic, retain) IBOutlet DamageValueLabel *damageLabel;
@property (nonatomic, strong) IBOutlet UIView *shadowView;

- (IBAction)pressDamage;

@end
