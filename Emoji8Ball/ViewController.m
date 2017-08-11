//
//  ViewController.m
//  Emoji8Ball
//
//  Created by Matteo Vitolo on 15/05/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "ViewController.h"
#import "8BallAnswer.h"
@import GoogleMobileAds;

@interface ViewController () <GADBannerViewDelegate>
@property(nonatomic, strong) GADBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.labelContainer setAlpha:0];
    [self.shareButton setHidden:YES];
    
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeBanner];
    self.bannerView.delegate = self;

    [self.view addSubview:self.bannerView];
    self.bannerView.adUnitID = @"ca-app-pub-3058866967373393/2894501473";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    

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

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

@end
