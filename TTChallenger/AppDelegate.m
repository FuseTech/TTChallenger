//
//  AppDelegate.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "AppDelegate.h"
#import "PostsViewController.h"
#import "WelcomeViewController.h"

static NSString *baseUrl = @"http://wchambers.fatfractal.com/TTChallenger";
static NSString *sslUrl = @"https://wchambers.fatfractal.com/TTChallenger";
static FatFractal *_ff;
static KeychainItemWrapper *_keychainItem;
static NSString *keychainIdentifier = @"TTChallengerAppKeychain";

@interface AppDelegate ()
@property PostsViewController *postsVC;

@end
@implementation AppDelegate

+(FatFractal *)ff {
    return  _ff;
}

+ (KeychainItemWrapper *)keychainItem {
    return _keychainItem;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _ff = [[FatFractal alloc] initWithBaseUrl:baseUrl sslUrl:sslUrl];
    _ff.debug = YES;
    
    _keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:keychainIdentifier accessGroup:nil];
    
    /* If Keychain Item exists, attempt login */
    if ([_keychainItem objectForKey:(__bridge id)(kSecAttrAccount)] != nil && ![[_keychainItem objectForKey:(__bridge id)(kSecAttrAccount)] isEqual:@""]) {
        NSLog(@"_keychainItem username exists, attempting login in background.");
        
        NSString *username = [_keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
        NSString *password = [_keychainItem objectForKey:(__bridge id)(kSecValueData)];
        
        /* Login with FatFractal by initiating connection with server */
        // Step 1
        [_ff loginWithUserName:username andPassword:password onComplete:^(NSError *theErr, id theObj, NSHTTPURLResponse *theResponse) {
            
            // Step 2
            if (theErr) {
                NSLog(@"Error trying to log in from AppDelegate: %@", [theErr localizedDescription]);
                // Probably keychain item is corrupted, reset the keychain and force user to sign up/ login again.
                // Better error handling can be done in a production application.
                [_keychainItem resetKeychainItem];
                return ;
            }
            
            // Step 3
            if (theObj) {
                NSLog(@"Login from AppDelegate using keychain successful!");
                [self userSuccessfullyAuthenticated];
            }
        }];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
+(BOOL)checkForAuthentication {
    if ([_ff loggedIn] || ([_keychainItem objectForKey:(__bridge id)(kSecAttrAccount)] != nil && ![[_keychainItem objectForKey:(__bridge id)(kSecAttrAccount)] isEqual:@""])) {
        NSLog(@"Logged in");
        return YES;
    } else {
        return NO;
    }
}
+(void)userLogout {
    [_keychainItem resetKeychainItem];
}

-(void)userSuccessfullyAuthenticated {
    [self.postsVC userIsAuthenticatedFromAppDelegateOnLaunch];
}

@end
