//
//  PostsViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "PostsViewController.h"
#import "AppDelegate.h"

@interface PostsViewController () <UIActionSheetDelegate>

- (IBAction)logoutPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;

@end

@implementation PostsViewController

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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkForAuthentication];
}

-(void)checkForAuthentication {
    
    /* To Do: Replace with check for authentication */
    if ([AppDelegate checkForAuthentication]) {
        
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WelcomeViewController *welcomeVC = [storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
        welcomeVC.delegate = self;
        [self presentViewController:welcomeVC animated:YES completion:nil];
    }
    
    
}

-(void)userIsAuthenticatedFromAppDelegateOnLaunch{
    //User was autologged in. Call methods responsible for refreshing table data
    
    
}

-(void)userDidAuthenticate{
    
}

- (IBAction)logoutPressed:(id)sender {
    [[FatFractal main] logout];
    [AppDelegate userLogout];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WelcomeViewController *welcomeVC = [storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    welcomeVC.delegate = self;
    [self presentViewController:welcomeVC animated:YES completion:nil];
}

- (IBAction)addButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Type of Post:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open Challenge", @"Trash Talk", @"Practice request", @"Match Result", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // OPen challenge pressed
    } else if (buttonIndex == 1) {
        //Trash talk
    } else if (buttonIndex == 2) {
        //Practice request
    } else if (buttonIndex == 3) {
        // Match Result
    }
    
    
    
}
@end
