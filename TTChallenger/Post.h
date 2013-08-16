//
//  Post.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/16/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString *postText;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSData *profileImage;
@property (nonatomic, strong) NSDate *timeOfPost;
@end
