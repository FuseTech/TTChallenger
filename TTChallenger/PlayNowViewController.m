//
//  PlayNowViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/16/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "PlayNowViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface PlayNowViewController () < MCBrowserViewControllerDelegate, MCSessionDelegate>
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCAdvertiserAssistant *assistant;


@end

@implementation PlayNowViewController

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lookingForChallengeSwitch:(UISwitch *)theSwitch {
    if (theSwitch.isOn) {
        [self setUpAdvertiser];
    } else if (!theSwitch.isOn) {
        [self turnOffAdvertiser];
        
    }
}

-(void)setUpAdvertiser {
    self.peerID = [[MCPeerID alloc] initWithDisplayName:[[FatFractal main] loggedInUser].userName];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    
    self.assistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"TTC" discoveryInfo:nil session:self.session];
    [self.assistant start];
    
}

-(void)turnOffAdvertiser {
    [self.assistant stop];
    
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}




-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    if (state == MCSessionStateConnected) {
        //Challenge was accepted. Create Match, schedule local notification
        //Stop advertising
        
    } else if (state == MCSessionStateNotConnected) {
        
    }
    
}

//To supress warnings
-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    return;
}
-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    return;
}
-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    return;
}
-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    
    
}
@end
