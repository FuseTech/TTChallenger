//
//  WelcomeViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "WelcomeViewController.h"


@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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

- (IBAction)signUpPressed:(id)sender {


}

- (IBAction)loginPressed:(id)sender {
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"signUpSegue"]) {
        SignupViewController *signupVC = [segue destinationViewController];
        signupVC.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"loginSegue"]) {
        LoginViewController *loginVC = [segue destinationViewController];
        loginVC.delegate = self;
    }
}

#pragma mark - SignupVC Delegate
-(void)signupViewControllerDidSignupUser {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self userSuccessfullyAuthenticated];
}

#pragma mark - Login VC delegate
-(void)loginViewDidLoginUser {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self userSuccessfullyAuthenticated];
}

-(void)userSuccessfullyAuthenticated {
    if ([self.delegate respondsToSelector:@selector(userDidAuthenticate)]) {
        [self.delegate userDidAuthenticate];
    }
}
@end
