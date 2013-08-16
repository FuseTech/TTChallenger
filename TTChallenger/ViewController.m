//
//  ViewController.m
//  TTChallenger
//
//  Created by Weston Chambers on 8/15/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import "ViewController.h"
#import "Post.h"

@interface ViewController ()
- (IBAction)postPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postPressed:(id)sender {
    Post *thePost = [[Post alloc] init];
    thePost.postText = self.textView.text;
    thePost.user = [[FatFractal main]loggedInUser].userName;
    thePost.timeOfPost = [NSDate date];
    thePost.profileImage = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"picture" ofType:@"png"]];
    
    
    [[FatFractal main] createObj:thePost atUri:@"/Micropost" onComplete:^(NSError *theErr, id theObj, NSHTTPURLResponse *theResponse) {
        if (theErr) {
            NSLog(@"Error, can't post at this time.");
        }
        
        if (theObj) {
            NSLog(@"Success! Micropost created: %@", theObj);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } onOffline:^(NSError *theErr, id theObj, NSHTTPURLResponse *theResponse) {
        FFQueuedOperation *operation = (FFQueuedOperation *)theObj;
    }];
}
@end
