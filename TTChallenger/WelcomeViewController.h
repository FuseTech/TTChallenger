//
//  WelcomeViewController.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"
#import "LoginViewController.h"

@protocol WelcomeViewControllerDelegate <NSObject>

-(void)userDidAuthenticate;

@end

@interface WelcomeViewController : UIViewController <SignUpViewControllerDelegate, LoginViewControllerDelegate>
@property (nonatomic, assign) id <WelcomeViewControllerDelegate> delegate;
- (IBAction)signUpPressed:(id)sender;
- (IBAction)loginPressed:(id)sender;



@end
