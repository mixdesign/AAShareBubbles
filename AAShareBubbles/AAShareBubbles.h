//
//  AAShareBubbles.h
//  AAShareBubbles
//
//  Created by Almas Adilbek on 26/11/13.
//  Copyright (c) 2013 Almas Adilbek. All rights reserved.
//  https://github.com/mixdesign/AAShareBubbles
//

#import <UIKit/UIKit.h>

@protocol AAShareBubblesDelegate;

typedef enum AAShareBubbleType : int {
    AAShareBubbleTypeFacebook = 0,
    AAShareBubbleTypeTwitter = 1,
    AAShareBubbleTypeGooglePlus = 2,
    AAShareBubbleTypeTumblr = 3,
    AAShareBubbleTypeMail = 4,
    AAShareBubbleTypeVk = 5, // Vkontakte (vk.com)
    AAShareBubbleTypeLinkedIn = 6,
    AAShareBubbleTypePinterest = 7,
    AAShareBubbleTypeYoutube = 8,
    AAShareBubbleTypeVimeo = 9,
    AAShareBubbleTypeReddit = 10,
    AAShareBubbleTypeInstagram = 11,
    AAShareBubbleTypeFavorite = 12,
    AAShareBubbleTypeWhatsapp = 13
    
} AAShareBubbleType;

@interface AAShareBubbles : UIView

@property (nonatomic, assign) id<AAShareBubblesDelegate> delegate;

@property (nonatomic, assign) BOOL showFacebookBubble;
@property (nonatomic, assign) BOOL showTwitterBubble;
@property (nonatomic, assign) BOOL showMailBubble;
@property (nonatomic, assign) BOOL showGooglePlusBubble;
@property (nonatomic, assign) BOOL showTumblrBubble;
@property (nonatomic, assign) BOOL showVkBubble;
@property (nonatomic, assign) BOOL showLinkedInBubble;
@property (nonatomic, assign) BOOL showPinterestBubble;
@property (nonatomic, assign) BOOL showYoutubeBubble;
@property (nonatomic, assign) BOOL showVimeoBubble;
@property (nonatomic, assign) BOOL showRedditBubble;
@property (nonatomic, assign) BOOL showInstagramBubble;
@property (nonatomic, assign) BOOL showFavoriteBubble;
@property (nonatomic, assign) BOOL showWhatsappBubble;
@property (nonatomic, strong) NSMutableArray *customButtons;

// The radius from center point to each share button
@property (nonatomic, assign) int radius;

// Bubble button radius
@property (nonatomic, assign) int bubbleRadius;

// Define if bubbles are currently animating (showing or hiding)
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, weak) UIView *parentView;

// The fader view alpha, by default is 0.15
@property(nonatomic, assign) CGFloat faderAlpha;

// The fader view background color, default is black
@property (nonatomic, strong) UIColor *faderColor;

@property (nonatomic, assign) int facebookBackgroundColorRGB;
@property (nonatomic, assign) int twitterBackgroundColorRGB;
@property (nonatomic, assign) int mailBackgroundColorRGB;
@property (nonatomic, assign) int googlePlusBackgroundColorRGB;
@property (nonatomic, assign) int tumblrBackgroundColorRGB;
@property (nonatomic, assign) int vkBackgroundColorRGB;
@property (nonatomic, assign) int linkedInBackgroundColorRGB;
@property (nonatomic, assign) int pinterestBackgroundColorRGB;
@property (nonatomic, assign) int youtubeBackgroundColorRGB;
@property (nonatomic, assign) int vimeoBackgroundColorRGB;
@property (nonatomic, assign) int redditBackgroundColorRGB;
@property (nonatomic, assign) int instagramBackgroundColorRGB;
@property (nonatomic, assign) int favoriteBackgroundColorRGB;
@property (nonatomic, assign) int whatsappBackgroundColorRGB;

-(id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView;

// Share bubbles will appear in UIWindow instance
-(id)initCenteredInWindowWithRadius:(int)radiusValue;

-(void)show;
-(void)hide;

-(void)addCustomButtonWithIcon:(UIImage *)icon backgroundColor:(UIColor *)color andButtonId:(int)buttonId;

@end

@protocol AAShareBubblesDelegate<NSObject>

@optional

// On buttons pressed
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(int)bubbleType;

// On bubbles hide
-(void)aaShareBubblesDidHide:(AAShareBubbles *)shareBubbles;
@end
