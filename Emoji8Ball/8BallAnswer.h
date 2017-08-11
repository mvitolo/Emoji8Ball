//
//  8BallAnswer.h
//  Emoji8Ball
//
//  Created by Matteo Vitolo on 15/05/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _BallAnswer : NSObject
+ (instancetype)sharedInstance;

- (NSArray*) getTheAnswer;
@end
