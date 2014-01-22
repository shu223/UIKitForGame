# UIKitForGame

UIKitForGame provides RPG-style effects entirely inside of UIKit.


## Demo

Please check out the demo project included.

![](http://f.cl.ly/items/3k1E1X1b352i0n3b0K1I/uikitforgame_full.gif)

## Examples

APIs are very simple.

### DamageValueLabel

    [self.charaImgView whiteFadeInWithDuration:0.3
                                         delay:0.0
                                         block:^(void) {
                                         }];

### UIImageViwe+effects

    [self.label startAnimation];


### UIView+shake

    [self.view shakeWithCount:10 interval:0.03];


### DQView

No codes are needed. Just enter "DQView" as the class in IB inspector.


### CustomFontLabel

No codes are needed. Just define "kCustomFontName" and enter "CustomFontLabel" as the class in IB inspector.

