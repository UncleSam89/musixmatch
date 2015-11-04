//
//  deezerClass.h
//  mobiDev
//
//  Created by Samuele De Giuseppe on 28/11/13.
//  Copyright (c) 2013 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeezerConnect.h"


@protocol DeezerSessionConnectionDelegate;


@interface deezerClass : NSObject <DeezerSessionDelegate>


+ (deezerClass *)deezerSession;



@property(nonatomic, strong) DeezerConnect *deezerConnect;
@property (nonatomic, assign)   id<DeezerSessionConnectionDelegate> connectionDelegate;




@end


@protocol DeezerSessionConnectionDelegate <NSObject>

@optional
- (void)deezerSessionDidConnect;
- (void)deezerSessionConnectionDidFailWithError:(NSError*)error;
- (void)deezerSessionDidDisconnect;




@end