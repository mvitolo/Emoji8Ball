//
//  8BallAnswer.m
//  Emoji8Ball
//
//  Created by Matteo Vitolo on 15/05/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "8BallAnswer.h"
#include <stdlib.h>

@interface _BallAnswer()
@property (strong) NSArray* emojiFiles;
@end

@implementation _BallAnswer
+ (instancetype)sharedInstance
{
    static _BallAnswer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[_BallAnswer alloc] init];
        // Do any other initialisation stuff here
        [sharedInstance initializeEmojis];
    });
    return sharedInstance;
}

- (void) initializeEmojis{
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '-emoji.png'"];
    self.emojiFiles = [dirContents filteredArrayUsingPredicate:fltr];
}


- (NSArray*) getTheAnswer;{
    int r = arc4random_uniform(3) +1;

    NSMutableArray* emoji = [NSMutableArray arrayWithCapacity:r];
    
    for (int i = 0; i < r; i++) {
        int r3 = arc4random_uniform((int)[self.emojiFiles count]);
        [emoji addObject:[self.emojiFiles objectAtIndex:r3]];

    }
    
    return emoji;
}

@end
