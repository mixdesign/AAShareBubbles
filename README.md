Intro
==============

Animated Social share buttons control.<br>
Supported buttons:<br><b>Facebook</b>,  <b>Twitter</b>,  <b>Google+</b>, <b>Tumblr</b>, <b>Vkontakte (vk.com)</b>, <b>LinkedIn</b>, <b>Pinterest</b>, <b>Youtube</b>, <b>Vimeo</b>, <b>Reddit</b>, <b>Instagram</b>, <b>Whatsapp</b>, <b>E-mail</b>, <b>Add to favorites</b>

Also supports custom buttons.

**Demo video:**<br>
http://www.youtube.com/watch?v=0yvl4_db1F4

<img src="http://mixdesign.kz/external/media/AAShareBubbles/bubbles.png?1"/>&nbsp;&nbsp;
<img src="http://mixdesign.kz/external/media/AAShareBubbles/abay2.png"/>

Installation
------

Two ways:<br>
1. Just drag n drop **AAShareBubbles** folder into your xcode project.<br>
2. **Cocoapods:**
```ruby
pod 'AAShareBubbles'
```
Usage:
------
```objective-c
#import "AAShareBubbles.h"
```
```objective-c
AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(100, 100)
                                                              radius:100
                                                              inView:self.view];
shareBubbles.delegate = self;
shareBubbles.bubbleRadius = 45; // Default is 40
shareBubbles.showFacebookBubble = YES;
shareBubbles.showTwitterBubble = YES;
shareBubbles.showMailBubble = YES;
shareBubbles.showGooglePlusBubble = YES;
shareBubbles.showTumblrBubble = YES;
shareBubbles.showVkBubble = YES;

// add custom buttons -- buttonId for custom buttons MUST be greater than or equal to 100
[shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"custom-icon"]
                      backgroundColor:[UIColor greenColor]
                          andButtonId:100];


[shareBubbles show];

// Use another initialization method to create share buttons on UIWindow instance (at the center)
AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initCenteredInWindowWithRadius:100];
...
````
#####Delegate
```objective-c
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
            NSLog(@"Facebook");
            break;
        case AAShareBubbleTypeTwitter:
            NSLog(@"Twitter");
            break;
        case AAShareBubbleTypeMail:
            NSLog(@"Email");
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
        case 100:
            // custom buttons have type >= 100
            NSLog(@"Custom Button With Type 100");
            break;
        default:
            break;
    }
}

-(void)aaShareBubblesDidHide:(AAShareBubbles *)bubbles {
    NSLog(@"All Bubbles hidden");
}

```

Requirements:
------------
`ARC`, `iOS 5+`, `Xcode 4+`


Todo:
-------
- Add more social buttons.
- Add opportunity to show bubbles in specified order.
