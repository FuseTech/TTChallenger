//
//  LoginViewController.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

-(void)loginViewDidLoginUser;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, assign) id <LoginViewControllerDelegate> delegate;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)loginPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end
