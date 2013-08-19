//
//  AppDelegate.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MCSession *session;

+(FatFractal *)ff;
+(KeychainItemWrapper *)keychainItem;
+(BOOL)checkForAuthentication;
+(void)userLogout;
-(void)startAdvertising;
-(void)stopAdvertising;


@end
