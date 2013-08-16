//
//  PostsViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "PostsViewController.h"
#import "AppDelegate.h"

@interface PostsViewController ()

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

@end
