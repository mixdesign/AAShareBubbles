//
//  AAShareBubbles.m
//  AAShareBubbles
//
//  Created by Almas Adilbek on 26/11/13.
//  Copyright (c) 2013 Almas Adilbek. All rights reserved.
//  https://github.com/mixdesign/AAShareBubbles
//

#import "AAShareBubbles.h"
#import <QuartzCore/QuartzCore.h>

@interface AAShareBubbles()
-(UIColor *)colorFromRGB:(int)rgb;
-(UIButton *)shareButtonWithIcon:(NSString *)iconName andBackgroundColorRGB:(int)rgb;
-(UIImage *)imageWithView:(UIView *)view;

-(void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture;

-(void)showBubbleWithAnimation:(NSDictionary *)info;
-(void)hideBubbleWithAnimation:(UIButton *)bubble;

-(void)facebookTapped;
-(void)twitterTapped;
-(void)mailTapped;
-(void)googlePlusTapped;
@end

@implementation AAShareBubbles

@synthesize isAnimating, delegate = _delegate, showFacebookBubble, showMailBubble, showTwitterBubble, showGooglePlusBubble, radius, bubbleRadius, facebookBackgroundColorRGB, twitterBackgroundColorRGB, mailBackgroundColorRGB, googlePlusBackgroundColorRGB, parentView;

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView
{
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, 2 * radiusValue, 2 * radiusValue)];
    if (self) {
        self.radius = radiusValue;
        self.bubbleRadius = 40;
        self.parentView = inView;
        
        self.facebookBackgroundColorRGB = 0x3c5a9a;
        self.twitterBackgroundColorRGB = 0x3083be;
        self.mailBackgroundColorRGB = 0xbb54b5;
        self.googlePlusBackgroundColorRGB = 0xd95433;
    }
    return self;
}

#pragma mark -
#pragma mark Actions

-(void)facebookTapped {
    [self shareButtonTappedWithType:AAShareBubbleTypeFacebook];
}
-(void)twitterTapped {
    [self shareButtonTappedWithType:AAShareBubbleTypeTwitter];
}
-(void)mailTapped {
    [self shareButtonTappedWithType:AAShareBubbleTypeMail];
}
-(void)googlePlusTapped {
    [self shareButtonTappedWithType:AAShareBubbleTypeGooglePlus];
}

-(void)shareButtonTappedWithType:(AAShareBubbleType)buttonType {
    [self hide];
    if([self.delegate respondsToSelector:@selector(aaShareBubbles:tappedBubbleWithType:)]) {
        [self.delegate aaShareBubbles:self tappedBubbleWithType:buttonType];
    }
}

#pragma mark -
#pragma mark Methods

-(void)show
{
    if(!isAnimating)
    {
        isAnimating = YES;
        
        [self.parentView addSubview:self];
        
        // Create background
        bgView = [[UIView alloc] initWithFrame:self.parentView.bounds];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewBackgroundTapped:)];
        [bgView addGestureRecognizer:tapges];
        [parentView addSubview:bgView];
        [parentView insertSubview:bgView belowSubview:self];
        // --
        
        if(bubbles) {
            bubbles = nil;
        }
        bubbles = [[NSMutableArray alloc] init];
        if(showFacebookBubble) {
            UIButton *facebookBubble = [self shareButtonWithIcon:@"icon-aa-facebook.png" andBackgroundColorRGB:facebookBackgroundColorRGB];
            [facebookBubble addTarget:self action:@selector(facebookTapped) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:facebookBubble];
            [bubbles addObject:facebookBubble];
        }
        if(showTwitterBubble) {
            UIButton *twitterBubble = [self shareButtonWithIcon:@"icon-aa-twitter.png" andBackgroundColorRGB:twitterBackgroundColorRGB];
            [twitterBubble addTarget:self action:@selector(twitterTapped) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:twitterBubble];
            [bubbles addObject:twitterBubble];
        }
        if(showMailBubble) {
            UIButton *mailBubble = [self shareButtonWithIcon:@"icon-aa-at.png" andBackgroundColorRGB:mailBackgroundColorRGB];
            [mailBubble addTarget:self action:@selector(mailTapped) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:mailBubble];
            [bubbles addObject:mailBubble];
        }
        if(showGooglePlusBubble) {
            UIButton *googlePlusBubble = [self shareButtonWithIcon:@"icon-aa-googleplus.png" andBackgroundColorRGB:googlePlusBackgroundColorRGB];
            [googlePlusBubble addTarget:self action:@selector(googlePlusTapped) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:googlePlusBubble];
            [bubbles addObject:googlePlusBubble];
        }
        
        if(bubbles.count == 0) return;
        
        float bubbleDistanceFromPivot = radius - bubbleRadius;
        
        float bubblesBetweenAngel = 360 / bubbles.count;
        float angely = (180 - bubblesBetweenAngel) * 0.5;
        float startAngel = 180 - angely;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < bubbles.count; ++i)
        {
            UIButton *bubble = [bubbles objectAtIndex:i];
            bubble.tag = i;
            
            float angel = startAngel + i * bubblesBetweenAngel;
            float x = cos(angel * M_PI / 180) * bubbleDistanceFromPivot + radius;
            float y = sin(angel * M_PI / 180) * bubbleDistanceFromPivot + radius;
            
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", [NSNumber numberWithFloat:y], @"y", nil]];
            
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(radius, radius);
        }
        
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = [bubbles objectAtIndex:inetratorI];
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate", nil] afterDelay:delayTime];
            ++inetratorI;
        }
    }
}
-(void)hide
{
    if(!isAnimating)
    {
        isAnimating = YES;
        int inetratorI = 0;
        for (UIButton *bubble in bubbles)
        {
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

#pragma mark -
#pragma mark Helper functions

-(void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture {
    [tapGesture.view removeFromSuperview];
    [self hide];
}

-(void)showBubbleWithAnimation:(NSDictionary *)info
{
    UIButton *bubble = (UIButton *)[info objectForKey:@"button"];
    NSDictionary *coordinate = (NSDictionary *)[info objectForKey:@"coordinate"];
    
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            bubble.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                bubble.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                if(bubble.tag == bubbles.count - 1) isAnimating = NO;
                bubble.layer.shadowColor = [UIColor blackColor].CGColor;
                bubble.layer.shadowOpacity = 0.2;
                bubble.layer.shadowOffset = CGSizeMake(0, 1);
                bubble.layer.shadowRadius = 2;
            }];
        }];
    }];
}
-(void)hideBubbleWithAnimation:(UIButton *)bubble
{
    [UIView animateWithDuration:0.2 animations:^{
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            bubble.center = CGPointMake(radius, radius);
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.alpha = 0;
        } completion:^(BOOL finished) {
            if(bubble.tag == bubbles.count - 1) {
                isAnimating = NO;
                self.hidden = YES;
                [bgView removeFromSuperview];
                bgView = nil;
                [self removeFromSuperview];
            }
            [bubble removeFromSuperview];
        }];
    }];
}

-(UIButton *)shareButtonWithIcon:(NSString *)iconName andBackgroundColorRGB:(int)rgb
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 2 * bubbleRadius, 2 * bubbleRadius);
    
    // Circle background
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * bubbleRadius, 2 * bubbleRadius)];
    circle.backgroundColor = [self colorFromRGB:rgb];
    circle.layer.cornerRadius = bubbleRadius;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    
    // Circle icon
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    CGRect f = icon.frame;
    f.origin.x = (circle.frame.size.width - f.size.width) * 0.5;
    f.origin.y = (circle.frame.size.height - f.size.height) * 0.5;
    icon.frame = f;
    [circle addSubview:icon];
    
    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    
    return button;
}

-(UIColor *)colorFromRGB:(int)rgb {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

-(UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
