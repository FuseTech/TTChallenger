//
//  SignupViewController.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignUpViewControllerDelegate <NSObject>
-(void)signupViewControllerDidSignupUser;
@end

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic, assign) id <SignUpViewControllerDelegate> delegate;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)signUpButtonPressed:(id)sender;

@end
