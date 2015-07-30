//
//  ViewController.m
//  Emoji8Ball
//
//  Created by Matteo Vitolo on 15/05/15.
//  Copyright (c) 2015 Funambol. All rights reserved.
//

#import "ViewController.h"
#import "8BallAnswer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.labelContainer setAlpha:0];
    [self.shareButton setHidden:YES];

}

-(void) showAnswer{
    [self.emoticon1 setImage: nil];
    [self.emoticon2 setImage: nil];
    [self.emoticon3 setImage: nil];
    [self.emoticon4 setImage: nil];
    
    NSArray* vals = [[_BallAnswer sharedInstance] getTheAnswer];
    
    switch ([vals count]) {
        case 1:
            [self.emoticon4 setImage:[UIImage imageNamed:[vals objectAtIndex:0]]];
            break;
        case 2:
            [self.emoticon2 setImage:[UIImage imageNamed:[vals objectAtIndex:0]]];
            [self.emoticon3 setImage:[UIImage imageNamed:[vals objectAtIndex:1]]];
            
            break;
        case 3:
            [self.emoticon1 setImage:[UIImage imageNamed:[vals objectAtIndex:0]]];
            
            [self.emoticon2 setImage:[UIImage imageNamed:[vals objectAtIndex:1]]];
            
            [self.emoticon3 setImage:[UIImage imageNamed:[vals objectAtIndex:2]]];
            
            break;
        default:
            break;
    }
}

- (void) shakeAnimation{
    [self.labelContainer setAlpha:0];

    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self startFade];
    }];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.1];
    [animation setRepeatCount:8];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.ball.center.x -20.0f, self.ball.center.y) ]];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.ball.center.x +20.0f, self.ball.center.y) ]];
    [[self.ball layer] addAnimation:animation forKey:@"position"];
    [CATransaction commit];
}

- (void) startFade{
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:2.0];
    [self.labelContainer setAlpha:1];
    [UIView commitAnimations];
}

-(IBAction)askAction:(id)sender;
{
    [self.askText resignFirstResponder];
    
    [self shakeAnimation];

    [self showAnswer];
}

-(IBAction)shareAction:(id)sender;
{
    
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self shakeAnimation];
    
    [self showAnswer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
