//
//  AppDelegate.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(FatFractal *)ff;
+(KeychainItemWrapper *)keychainItem;
+(BOOL)checkForAuthentication;

@end
