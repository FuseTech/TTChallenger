//
//  SignupViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "SignupViewController.h"
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface SignupViewController () <UITextFieldDelegate>

@end

@implementation SignupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)signUpButtonPressed:(id)sender {
    NSString *name = _nameTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *email = _emailTextField.text;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Signing up...";
    hud.dimBackground = YES;
    hud.yOffset = -77;
    
    
    //Create new FFUser, register the user and save to keychain
    FFUser *newUser = [[FFUser alloc] initWithFF:[FatFractal main]];
    newUser.userName = name;
    newUser.email = email;
    
    //Register
    [[FatFractal main] registerUser:newUser password:password onComplete:^(NSError *theErr, id theObj, NSHTTPURLResponse *theResponse) {
        if (theErr) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[theErr localizedDescription] delegate:nil cancelButtonTitle:@"Acknowledged" otherButtonTitles: nil];
            [alert show];
            return;
        } else {
            if (theObj) {
                [self saveUserCredentialsInKeychain];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self dismissViewControllerAnimated:NO completion:^{
                    [self handleSuccessfulSignup];
                }];
            }
        }
    }];
}

#pragma mark - Keychain/Signup helper methods
-(void)saveUserCredentialsInKeychain {
    NSString *username = _nameTextField.text;
    NSString *password = _passwordTextField.text;
    
    KeychainItemWrapper *keychainItem =  [AppDelegate keychainItem];
    [keychainItem setObject:username forKey:(__bridge id)(kSecAttrAccount)];
    [keychainItem setObject:password forKey:(__bridge id)(kSecValueData)];
}

#pragma mark - Signup VC delegate
-(void)handleSuccessfulSignup {
    if ([self.delegate respondsToSelector:@selector(signupViewControllerDidSignupUser)]) {
        [self.delegate signupViewControllerDidSignupUser];
    }
}
@end
