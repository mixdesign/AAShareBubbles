//
//  AAShareBubbles.m
//  AAShareBubbles
//
//  Created by Almas Adilbek on 26/11/13.
//  Copyright (c) 2013 Almas Adilbek. All rights reserved.
//  https://github.com/mixdesign/AAShareBubbles
//

#import "AAShareBubbles.h"

@interface AACustomShareBubble : NSObject
@property int customId;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) UIColor *backgroundColor;
@end

@implementation AACustomShareBubble
@end

@interface AAShareBubbles()
@end

@implementation AAShareBubbles
{
    NSMutableArray *bubbles;
    NSMutableDictionary *bubbleIndexTypes;

    UIView *faderView;
}

@synthesize delegate = _delegate, parentView;

- (id)initCenteredInWindowWithRadius:(int)radiusValue
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return [self initWithPoint:CGPointMake((CGFloat) (window.frame.size.width * 0.5), (CGFloat) (window.frame.size.height * 0.5)) radius:radiusValue inView:window];
}

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView
{
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, 2 * radiusValue, 2 * radiusValue)];
    if (self) {
        self.radius = radiusValue;
        self.bubbleRadius = 40;
        self.parentView = inView;
        self.faderAlpha = 0.15;
        self.faderColor = [UIColor blackColor];
        
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
        
        self.customButtons = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark Actions

-(void)buttonWasTapped:(UIButton *)button {
    int buttonType = [bubbleIndexTypes[@(button.tag)] intValue];
    [self shareButtonTappedWithType:buttonType];
}

-(void)shareButtonTappedWithType:(int)buttonType {
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
        faderView = [[UIView alloc] initWithFrame:self.parentView.bounds];
        faderView.backgroundColor = self.faderColor;
        faderView.alpha = 0.0f;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewBackgroundTapped:)];
        [faderView addGestureRecognizer:tapges];
        [parentView insertSubview:faderView belowSubview:self];

        [UIView animateWithDuration:0.25 animations:^{
            faderView.alpha = self.faderAlpha;
        }];
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
        if(self.showRedditBubble)       [self createButtonWithIcon:@"icon-aa-reddit.png" backgroundColor:self.redditBackgroundColorRGB andType:AAShareBubbleTypeReddit];
        if(self.showInstagramBubble)    [self createButtonWithIcon:@"icon-aa-instagram.png" backgroundColor:self.instagramBackgroundColorRGB andType:AAShareBubbleTypeInstagram];
        if(self.showFavoriteBubble)     [self createButtonWithIcon:@"icon-aa-star.png" backgroundColor:self.favoriteBackgroundColorRGB andType:AAShareBubbleTypeFavorite];
        if(self.showWhatsappBubble)     [self createButtonWithIcon:@"icon-aa-whatsapp.png" backgroundColor:self.whatsappBackgroundColorRGB andType:AAShareBubbleTypeWhatsapp];
        
        for (AACustomShareBubble *customBubble in self.customButtons)
        {
            [self createButtonWithIcon:customBubble.icon backgroundColor:customBubble.backgroundColor andButtonId:customBubble.customId];
        }
        
        if(bubbles.count == 0) return;
        
        float bubbleDistanceFromPivot = self.radius - self.bubbleRadius;
        
        float bubblesBetweenAngel = 360 / bubbles.count;
        float angely = (float) ((180 - bubblesBetweenAngel) * 0.5);
        float startAngel = 180 - angely;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < bubbles.count; ++i)
        {
            UIButton *bubble = bubbles[i];
            bubble.tag = i;
            
            float angle = startAngel + i * bubblesBetweenAngel;
            float x = (float) (cos(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius);
            float y = (float) (sin(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius);

            [coordinates addObject:@{@"x" : @(x), @"y" : @(y)}];
            
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(self.radius, self.radius);
        }
        
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = bubbles[inetratorI];
            float delayTime = (float) (inetratorI * 0.1);
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:@{@"button" : bubble, @"coordinate" : coordinate} afterDelay:delayTime];
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
            CGFloat delayTime = (CGFloat) (inetratorI * 0.1);
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

#pragma mark -
#pragma mark Helper functions

-(void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture
{
    [self hide];
}

-(void)showBubbleWithAnimation:(NSDictionary *)info
{
    UIButton *bubble = (UIButton *) info[@"button"];
    NSDictionary *coordinate = (NSDictionary *) info[@"coordinate"];
    
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = CGPointMake([coordinate[@"x"] floatValue], [coordinate[@"y"] floatValue]);
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

                [UIView animateWithDuration:0.25 animations:^{
                    faderView.alpha = 0;
                } completion:^(BOOL finished) {
                    [faderView removeFromSuperview];
                    if([self.delegate respondsToSelector:@selector(aaShareBubblesDidHide:)]) {
                        [self.delegate aaShareBubblesDidHide:self];
                    }
                    [self removeFromSuperview];
                }];
            }
            [bubble removeFromSuperview];
        }];
    }];
}

-(void)createButtonWithIcon:(UIImage *)icon backgroundColor:(UIColor *)color andButtonId:(int)buttonId
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius);
    
    // Circle background
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = self.bubbleRadius;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    
    // Circle icon
    UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
    CGRect f = iconView.frame;
    f.origin.x = (CGFloat) ((circle.frame.size.width - f.size.width) * 0.5);
    f.origin.y = (CGFloat) ((circle.frame.size.height - f.size.height) * 0.5);
    iconView.frame = f;
    [circle addSubview:iconView];
    
    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    
    [bubbles addObject:button];
    bubbleIndexTypes[@(bubbles.count - 1)] = @(buttonId);
    
    [self addSubview:button];
}

-(void)createButtonWithIcon:(NSString *)iconName backgroundColor:(int)rgb andType:(AAShareBubbleType)type
{
    UIImage *icon = [UIImage imageNamed:[NSString stringWithFormat:@"AAShareBubbles.bundle/%@", iconName]];
    UIColor *color = [self colorFromRGB:rgb];
    [self createButtonWithIcon:icon backgroundColor:color andButtonId:type];
}

-(void)addCustomButtonWithIcon:(UIImage *)icon backgroundColor:(UIColor *)color andButtonId:(int)buttonId
{
    NSAssert(buttonId >= 100, @"Custom Button Ids must be >= 100");
    
    AACustomShareBubble *customButton = [[AACustomShareBubble alloc] init];
    customButton.backgroundColor = color;
    customButton.icon = icon;
    customButton.customId = buttonId;
    [self.customButtons addObject:customButton];
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
