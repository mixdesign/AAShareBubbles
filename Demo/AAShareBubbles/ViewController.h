//
//  ViewController.h
//  AAShareBubbles
//
//  Created by Almas Adilbek on 11/26/13.
//  Copyright (c) 2013 GoodApp inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAShareBubbles.h"

@interface ViewController : UIViewController<AAShareBubblesDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
@property (weak, nonatomic) IBOutlet UISlider *bubbleRadiusSlider;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *bubbleRadiusLabel;
- (IBAction)shareTapped:(id)sender;
- (IBAction)radiusValueChanged:(id)sender;
- (IBAction)bubbleRadiusValueChanged:(id)sender;

@end
