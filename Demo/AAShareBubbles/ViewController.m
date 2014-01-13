//
//  ViewController.m
//  AAShareBubbles
//
//  Created by Almas Adilbek on 11/26/13.
//  Copyright (c) 2013 GoodApp inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    AAShareBubbles *shareBubbles;
    float radius;
    float bubbleRadius;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    radius = 130;
    bubbleRadius = 40;
    _radiusSlider.value = radius;
    _bubbleRadiusSlider.value = bubbleRadius;
    
    _radiusLabel.text = [NSString stringWithFormat:@"%.0f", radius];
    _bubbleRadiusLabel.text = [NSString stringWithFormat:@"%.0f", bubbleRadius];
}

- (IBAction)shareTapped:(id)sender
{
    if(shareBubbles) {
        shareBubbles = nil;
    }
    shareBubbles = [[AAShareBubbles alloc] initWithPoint:_shareButton.center radius:radius inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = bubbleRadius;
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showGooglePlusBubble = YES;
    shareBubbles.showTumblrBubble = YES;
    shareBubbles.showVkBubble = YES;
    shareBubbles.showLinkedInBubble = YES;
    shareBubbles.showYoutubeBubble = YES;
    shareBubbles.showVimeoBubble = YES;
    shareBubbles.showRedditBubble = YES;
    [shareBubbles show];
}

- (IBAction)radiusValueChanged:(id)sender {
    radius = [(UISlider *)sender value];
    _radiusLabel.text = [NSString stringWithFormat:@"%.0f", radius];
}

- (IBAction)bubbleRadiusValueChanged:(id)sender {
    bubbleRadius = [(UISlider *)sender value];
    _bubbleRadiusLabel.text = [NSString stringWithFormat:@"%.0f", bubbleRadius];
}

#pragma mark -
#pragma mark AAShareBubbles

-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
            NSLog(@"Facebook");
            break;
        case AAShareBubbleTypeTwitter:
            NSLog(@"Twitter");
            break;
        case AAShareBubbleTypeGooglePlus:
            NSLog(@"Google+");
            break;
        case AAShareBubbleTypeTumblr:
            NSLog(@"Tumblr");
            break;
        case AAShareBubbleTypeVk:
            NSLog(@"Vkontakte (vk.com)");
            break;
        case AAShareBubbleTypeLinkedIn:
            NSLog(@"LinkedIn");
            break;
        case AAShareBubbleTypeYoutube:
            NSLog(@"Youtube");
            break;
        case AAShareBubbleTypeVimeo:
            NSLog(@"Vimeo");
            break;
        case AAShareBubbleTypeReddit:
            NSLog(@"Reddit");
            break;
        default:
            break;
    }
}

-(void)aaShareBubblesDidHide {
    NSLog(@"All Bubbles hidden");
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setShareButton:nil];
    [self setRadiusSlider:nil];
    [self setRadiusLabel:nil];
    [self setBubbleRadiusSlider:nil];
    [self setBubbleRadiusLabel:nil];
    [super viewDidUnload];
}
@end
