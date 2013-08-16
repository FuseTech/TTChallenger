//
//  PostsViewController.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UIKit;
#import "WelcomeViewController.h"

@interface PostsViewController : UIViewController <WelcomeViewControllerDelegate>

-(void)userIsAuthenticatedFromAppDelegateOnLaunch;

@end
