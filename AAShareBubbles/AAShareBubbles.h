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

typedef NS_ENUM(NSUInteger, AAShareBubbleType) {
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
    AAShareBubbleTypeWhatsapp = 13,
    AAShareBubbleTypeMessage = 14,
    AAShareBubbleTypeQQ = 15,
    AAShareBubbleTypeQzone = 16,
    AAShareBubbleTypeSinaWeibo = 17,
    AAShareBubbleTypeWechat = 18
};

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
@property (nonatomic, assign) BOOL showSinaWeiboBubble;
@property (nonatomic, assign) BOOL showQQBubble;
@property (nonatomic, assign) BOOL showQzoneBubble;
@property (nonatomic, assign) BOOL showWechatBubble;
@property (nonatomic, assign) BOOL showMessageBubble;
@property (nonatomic, strong) NSMutableArray *customButtons;

// The radius from center point to each share button
@property (nonatomic, assign) NSInteger radius;

// Bubble button radius
@property (nonatomic, assign) NSInteger bubbleRadius;

// Define if bubbles are currently animating (showing or hiding)
@property (nonatomic, assign) BOOL isAnimating;

// Define if view will dismiss when user taps on background (Default: YES)
@property (nonatomic, assign) BOOL dismissOnBackgroundTap;

@property (nonatomic, weak) UIView *parentView;

// The fader view alpha, by default is 0.15
@property(nonatomic, assign) CGFloat faderAlpha;

// The fader view background color, default is black
@property (nonatomic, strong) UIColor *faderColor;

@property (nonatomic, assign) NSInteger facebookBackgroundColorRGB;
@property (nonatomic, assign) NSInteger twitterBackgroundColorRGB;
@property (nonatomic, assign) NSInteger mailBackgroundColorRGB;
@property (nonatomic, assign) NSInteger googlePlusBackgroundColorRGB;
@property (nonatomic, assign) NSInteger tumblrBackgroundColorRGB;
@property (nonatomic, assign) NSInteger vkBackgroundColorRGB;
@property (nonatomic, assign) NSInteger linkedInBackgroundColorRGB;
@property (nonatomic, assign) NSInteger pinterestBackgroundColorRGB;
@property (nonatomic, assign) NSInteger youtubeBackgroundColorRGB;
@property (nonatomic, assign) NSInteger vimeoBackgroundColorRGB;
@property (nonatomic, assign) NSInteger redditBackgroundColorRGB;
@property (nonatomic, assign) NSInteger instagramBackgroundColorRGB;
@property (nonatomic, assign) NSInteger favoriteBackgroundColorRGB;
@property (nonatomic, assign) NSInteger whatsappBackgroundColorRGB;
@property (nonatomic, assign) NSInteger sinaWeiboBackgroundColorRGB;
@property (nonatomic, assign) NSInteger qqBackgroundColorRGB;
@property (nonatomic, assign) NSInteger qzoneBackgroundColorRGB;
@property (nonatomic, assign) NSInteger wechatBackgroundColorRGB;
@property (nonatomic, assign) NSInteger messageBackgroundColorRGB;

-(instancetype)initWithPoint:(CGPoint)point radius:(NSInteger)radiusValue inView:(UIView *)inView;

// Share bubbles will appear in UIWindow instance
-(instancetype)initCenteredInWindowWithRadius:(NSInteger)radiusValue;

-(void)show;
-(void)hide;

-(void)addCustomButtonWithIcon:(UIImage *)icon backgroundColor:(UIColor *)color andButtonId:(NSInteger)buttonId;

@end

@protocol AAShareBubblesDelegate<NSObject>

@optional

// On buttons pressed
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType;

// On bubbles hide
-(void)aaShareBubblesDidHide:(AAShareBubbles *)shareBubbles;
@end
