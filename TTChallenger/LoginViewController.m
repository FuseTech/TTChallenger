//
//  LoginViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

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

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)loginPressed:(id)sender {
    [[FatFractal main] loginWithUserName:self.usernameTextField.text andPassword:self.passwordTextField.text onComplete:^(NSError *theErr, id theObj, NSHTTPURLResponse *theResponse) {
       
        if(theErr){
            NSLog(@" Error Logging In : %@", [theErr localizedDescription]);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Your username and password could not be authenticated. Double check that you entered them correctly and try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
        else {
            if(theObj){
                [self saveUserCredentialsInKeychain];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
               [self dismissViewControllerAnimated:NO completion:^{
                    [self handleSuccessfulLogin];
                }];
            }
        }
        
    }];
    
    
}




#pragma mark - Keychain/Signup helper methods
-(void)saveUserCredentialsInKeychain {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    KeychainItemWrapper *keychainItem =  [AppDelegate keychainItem];
    [keychainItem setObject:username forKey:(__bridge id)(kSecAttrAccount)];
    [keychainItem setObject:password forKey:(__bridge id)(kSecValueData)];
}

#pragma mark - Login VC delegate
-(void)handleSuccessfulLogin {
    
    if([self.delegate respondsToSelector:@selector(loginViewDidLoginUser)]){
        [self.delegate loginViewDidLoginUser];
    }
  
    
}
@end
