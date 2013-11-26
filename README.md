AAShareBubbles
==============

AAShareBubbles View  - animated Social share buttons

<img src="http://mixdesign.kz/external/AAShareBubbles.png?tmp"/>

Usage:
------
`#import "AAShareBubbles.h"`

    AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(100, 100) radius:100 inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = 35; // Default is 40
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showMailBubble = YES;
    [self.view addSubview:shareBubbles];
    [shareBubbles show];

Requirements:
------------
`ARC`, `iOS 5` and later, `Xcode 4` and later.

Todo:
-------
- Add more social icons.

License
==============
<b>AAShareBubbles</b> published under the MIT license:

Copyright (C) 2013, Almas Adilbek

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
