//
//  ViewController.h
//  Emoji8Ball
//
//  Created by Matteo Vitolo on 15/05/15.
//  Copyright (c) 2015 Funambol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property IBOutlet UIImageView* ball;
@property IBOutlet UIView* labelContainer;

@property IBOutlet UIImageView* label;

@property IBOutlet UIImageView* emoticon1;
@property IBOutlet UIImageView* emoticon2;
@property IBOutlet UIImageView* emoticon3;

@property IBOutlet UIImageView* emoticon4;

@property IBOutlet UIButton* askButton;
@property IBOutlet UIButton* shareButton;
@property IBOutlet UITextField* askText;
-(IBAction)askAction:(id)sender;
-(IBAction)shareAction:(id)sender;

@end

