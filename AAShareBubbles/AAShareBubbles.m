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
@end

@implementation AAShareBubbles
{
    NSMutableArray *bubbles;
    NSMutableDictionary *bubbleIndexTypes;
    
    UIView *bgView;
}

@synthesize delegate = _delegate, parentView;

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
        self.tumblrBackgroundColorRGB = 0x385877;
        self.vkBackgroundColorRGB = 0x4a74a5;
        self.linkedInBackgroundColorRGB = 0x008dd2;
        self.pinterestBackgroundColorRGB = 0xb61d23;
        self.youtubeBackgroundColorRGB = 0xce3025;
        self.vimeoBackgroundColorRGB = 0x00acf2;
        self.redditBackgroundColorRGB = 0xffffff;
        self.instagramBackgroundColorRGB = 0x2e5e89;
        self.favoriteBackgroundColorRGB = 0xedd013;
        self.whatsappBackgroundColorRGB = 0x00B000;
    }
    return self;
}

#pragma mark -
#pragma mark Actions

-(void)buttonWasTapped:(UIButton *)button {
    AAShareBubbleType buttonType = [[bubbleIndexTypes objectForKey:[NSNumber numberWithInteger:button.tag]] intValue];
    [self shareButtonTappedWithType:buttonType];
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
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        
        [self.parentView addSubview:self];
        
        // Create background
        bgView = [[UIView alloc] initWithFrame:self.parentView.bounds];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewBackgroundTapped:)];
        [bgView addGestureRecognizer:tapges];
        [parentView insertSubview:bgView belowSubview:self];
        // --
        
        if(bubbles) {
            bubbles = nil;
        }
        
        bubbles = [[NSMutableArray alloc] init];
        bubbleIndexTypes = [[NSMutableDictionary alloc] init];
        
        if(self.showFacebookBubble)     [self createButtonWithIcon:@"icon-aa-facebook.png" backgroundColor:self.facebookBackgroundColorRGB andType:AAShareBubbleTypeFacebook];
        if(self.showTwitterBubble)      [self createButtonWithIcon:@"icon-aa-twitter.png" backgroundColor:self.twitterBackgroundColorRGB andType:AAShareBubbleTypeTwitter];
        if(self.showGooglePlusBubble)   [self createButtonWithIcon:@"icon-aa-googleplus.png" backgroundColor:self.googlePlusBackgroundColorRGB andType:AAShareBubbleTypeGooglePlus];
        if(self.showTumblrBubble)       [self createButtonWithIcon:@"icon-aa-tumblr.png" backgroundColor:self.tumblrBackgroundColorRGB andType:AAShareBubbleTypeTumblr];
        if(self.showMailBubble)         [self createButtonWithIcon:@"icon-aa-at.png" backgroundColor:self.mailBackgroundColorRGB andType:AAShareBubbleTypeMail];
        if(self.showVkBubble)           [self createButtonWithIcon:@"icon-aa-vk.png" backgroundColor:self.vkBackgroundColorRGB andType:AAShareBubbleTypeVk];
        if(self.showLinkedInBubble)     [self createButtonWithIcon:@"icon-aa-linkedin.png" backgroundColor:self.linkedInBackgroundColorRGB andType:AAShareBubbleTypeLinkedIn];
        if(self.showPinterestBubble)    [self createButtonWithIcon:@"icon-aa-pinterest.png" backgroundColor:self.pinterestBackgroundColorRGB andType:AAShareBubbleTypePinterest];
        if(self.showYoutubeBubble)      [self createButtonWithIcon:@"icon-aa-youtube.png" backgroundColor:self.youtubeBackgroundColorRGB andType:AAShareBubbleTypeYoutube];
        if(self.showVimeoBubble)        [self createButtonWithIcon:@"icon-aa-vimeo.png" backgroundColor:self.vimeoBackgroundColorRGB andType:AAShareBubbleTypeVimeo];
        if(self.showRedditBubble)        [self createButtonWithIcon:@"icon-aa-reddit.png" backgroundColor:self.redditBackgroundColorRGB andType:AAShareBubbleTypeReddit];
        if(self.showInstagramBubble)     [self createButtonWithIcon:@"icon-aa-instagram.png" backgroundColor:self.instagramBackgroundColorRGB andType:AAShareBubbleTypeInstagram];
        if(self.showFavoriteBubble) [self createButtonWithIcon:@"icon-aa-star.png" backgroundColor:self.favoriteBackgroundColorRGB andType:AAShareBubbleTypeFavorite];
        if(self.showWhatsappBubble) [self createButtonWithIcon:@"icon-aa-whatsapp.png" backgroundColor:self.whatsappBackgroundColorRGB andType:AAShareBubbleTypeWhatsapp];
        
        if(bubbles.count == 0) return;
        
        float bubbleDistanceFromPivot = self.radius - self.bubbleRadius;
        
        float bubblesBetweenAngel = 360 / bubbles.count;
        float angely = (180 - bubblesBetweenAngel) * 0.5;
        float startAngel = 180 - angely;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < bubbles.count; ++i)
        {
            UIButton *bubble = [bubbles objectAtIndex:i];
            bubble.tag = i;
            
            float angle = startAngel + i * bubblesBetweenAngel;
            float x = cos(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
            float y = sin(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius;
            
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", [NSNumber numberWithFloat:y], @"y", nil]];
            
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(self.radius, self.radius);
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
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
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
                if(bubble.tag == bubbles.count - 1) self.isAnimating = NO;
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
            bubble.center = CGPointMake(self.radius, self.radius);
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.alpha = 0;
        } completion:^(BOOL finished) {
            if(bubble.tag == bubbles.count - 1) {
                self.isAnimating = NO;
                self.hidden = YES;
                [bgView removeFromSuperview];
                bgView = nil;
                
                if([self.delegate respondsToSelector:@selector(aaShareBubblesDidHide:)]) {
                    [self.delegate aaShareBubblesDidHide:self];
                }
                
                [self removeFromSuperview];
            }
            [bubble removeFromSuperview];
        }];
    }];
}

-(void)createButtonWithIcon:(NSString *)iconName backgroundColor:(int)rgb andType:(AAShareBubbleType)type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius);
    
    // Circle background
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius)];
    circle.backgroundColor = [self colorFromRGB:rgb];
    circle.layer.cornerRadius = self.bubbleRadius;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    
    // Circle icon
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"AAShareBubbles.bundle/%@", iconName]]];
    CGRect f = icon.frame;
    f.origin.x = (circle.frame.size.width - f.size.width) * 0.5;
    f.origin.y = (circle.frame.size.height - f.size.height) * 0.5;
    icon.frame = f;
    [circle addSubview:icon];
    
    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    
    [bubbles addObject:button];
    [bubbleIndexTypes setObject:[NSNumber numberWithInteger:type] forKey:[NSNumber numberWithInteger:(bubbles.count - 1)]];
    
    [self addSubview:button];
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
