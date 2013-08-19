//
//  PlayNowViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/16/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "PlayNowViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"

@interface PlayNowViewController () < MCBrowserViewControllerDelegate, MCSessionDelegate>
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCAdvertiserAssistant *assistant;
@property (nonatomic, strong) MCBrowserViewController *browserVC;
- (IBAction)challengePressed:(id)sender;



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
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.session = delegate.session;
    self.session.delegate = self;
    
    self.browserVC = nil;
    self.peerID = [[MCPeerID alloc] initWithDisplayName:[[FatFractal main] loggedInUser].userName];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    if (!self.browserVC) {
        self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:@"TTC" session:self.session];
        self.browserVC.delegate = self;
    }
    [self presentViewController:self.browserVC animated:NO completion:nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)lookingForChallengeSwitch:(UISwitch *)theSwitch {
//    if (theSwitch.isOn) {
//        [self setUpAdvertiser];
//    } else if (!theSwitch.isOn) {
//        [self turnOffAdvertiser];
//        
//    }
//}

//-(void)setUpAdvertiser {
//    self.peerID = [[MCPeerID alloc] initWithDisplayName:[[FatFractal main] loggedInUser].userName];
//    self.session = [[MCSession alloc] initWithPeer:self.peerID];
//    self.session.delegate = self;
//    
//    self.assistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"TTC" discoveryInfo:nil session:self.session];
//    [self.assistant start];
//    
//}
//
//-(void)turnOffAdvertiser {
//    [self.assistant stop];
//    
//}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}
-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    if ([peerID.displayName isEqualToString:self.peerID.displayName]) {
        return NO;
    } else {
        return YES;
    }
}




-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    if (state == MCSessionStateConnected) {
        //Challenge was accepted. Create Match, schedule local notification
        //Stop advertising
        [self.browserVC dismissViewControllerAnimated:YES completion:nil];
        NSArray *opponentArray = [self.session connectedPeers];
        NSString *opponent = [opponentArray objectAtIndex:0];
        
        [self createMatchBetween:[[FatFractal main]loggedInUser].userName andOpponent:opponent];
        
        
    } else if (state == MCSessionStateNotConnected) {
        
    }
    
}





-(void)createMatchBetween:(NSString *)challenger andOpponent:(NSString *)opponent {
    NSLog(@"Stop");
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
- (IBAction)challengePressed:(id)sender {
    self.browserVC = nil;
    self.peerID = [[MCPeerID alloc] initWithDisplayName:[[FatFractal main] loggedInUser].userName];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    if (!self.browserVC) {
        self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:@"TTC" session:self.session];
        self.browserVC.delegate = self;
    }
    [self presentViewController:self.browserVC animated:YES completion:nil];
}
@end
