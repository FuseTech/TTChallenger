//
//  Match.h
//  TTChallenger
//
//  Created by Weston Chambers on 8/19/13.
//  Copyright (c) 2013 Weston Chambers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Match : NSObject

@property (nonatomic, strong) NSString *player1;
@property (nonatomic, strong) NSString *player2;
@property (nonatomic, strong) NSDate *dateOfMatch;
@property (nonatomic, strong) NSDate *reportScoreBy;
@property (nonatomic, strong) NSNumber *p1g1score;
@property (nonatomic, strong) NSNumber *p1g2score;
@property (nonatomic, strong) NSNumber *p1g3score;
@property (nonatomic, strong) NSNumber *p2g1score;
@property (nonatomic, strong) NSNumber *p2g2score;
@property (nonatomic, strong) NSNumber *p2g3score;
@property (nonatomic, strong) NSString *winner;


@end
