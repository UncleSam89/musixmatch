//
//  deezerClass.m
//  mobiDev
//
//  Created by Samuele De Giuseppe on 28/11/13.
//  Copyright (c) 2013 Sam. All rights reserved.
//


#import "deezerClass.h"



#define kDeezerAppId @"128325"
#define DEEZER_TOKEN_KEY @"DeezerTokenKey"
#define DEEZER_EXPIRATION_DATE_KEY @"DeezerExpirationDateKey"
#define DEEZER_USER_ID_KEY @"DeezerUserId"



@implementation deezerClass


@synthesize deezerConnect;
@synthesize connectionDelegate;



- (id)init {
	if (!(self = [super init]))
		return nil;
    
    deezerConnect = [[DeezerConnect alloc] initWithAppId:kDeezerAppId andDelegate:self];
    [self retrieveTokenAndExpirationDate];

    /* List of permissions available from the Deezer SDK web site */
    NSMutableArray* permissionsArray = [NSMutableArray arrayWithObjects:@"basic_access", @"email", @"offline_access", @"manage_library", @"delete_library",@"listening_history", nil];
    //NSMutableArray* permissionsArray = [NSMutableArray arrayWithObjects:@"basic_access", nil];

    [deezerConnect authorize:permissionsArray];
    
    NSLog(@"DEEZER AUTORHIZE DONE");
    
    return self;
}



- (void)connectToDeezerWithPermissions:(NSArray*)permissionsArray {
    [deezerConnect authorize:permissionsArray];
}

- (void)disconnect {
    [deezerConnect logout];
}

- (BOOL)isSessionValid {
    return [deezerConnect isSessionValid];
}


//se ogga recupero token, user id e exp dat
- (void)deezerDidLogin {
    NSLog(@"Deezer did login");
    [self saveToken:[deezerConnect accessToken] andExpirationDate:[deezerConnect expirationDate] forUserId:[deezerConnect userId]];
    if ([connectionDelegate respondsToSelector:@selector(deezerSessionDidConnect)]) {
        [connectionDelegate deezerSessionDidConnect];
    }
    
    
    /*
    [usersData usersDataSession].myImageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.deezer.com/user/%@/image",[deezerConnect userId]]];
    
    [[deezerSearch deezerRequestSession] requestNickname];
    */
    
    
    
    
}

- (void)deezerDidLogout {
    NSLog(@"Deezer Did logout");
    [self clearTokenAndExpirationDate];
    if ([connectionDelegate respondsToSelector:@selector(deezerSessionDidDisconnect)]) {
        [connectionDelegate deezerSessionDidDisconnect];
    }
}

- (void)deezerDidNotLogin:(BOOL)cancelled {
    NSLog(@"Deezer Did not login %@", cancelled ? @"Cancelled" : @"Not Cancelled");
}


//metodo per recuperare token d exp data
- (void)retrieveTokenAndExpirationDate {
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [deezerConnect setAccessToken:[standardUserDefaults objectForKey:DEEZER_TOKEN_KEY]];
    [deezerConnect setExpirationDate:[standardUserDefaults objectForKey:DEEZER_EXPIRATION_DATE_KEY]];
    [deezerConnect setUserId:[standardUserDefaults objectForKey:DEEZER_USER_ID_KEY]];
}

//metodo per salvare token e exp date
- (void)saveToken:(NSString*)token andExpirationDate:(NSDate*)expirationDate forUserId:(NSString*)userId {
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:token forKey:DEEZER_TOKEN_KEY];
    [standardUserDefaults setObject:expirationDate forKey:DEEZER_EXPIRATION_DATE_KEY];
    [standardUserDefaults setObject:userId forKey:DEEZER_USER_ID_KEY];
    [standardUserDefaults synchronize];
}

//metodo per eliminare token e exp date
- (void)clearTokenAndExpirationDate {
    NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults removeObjectForKey:DEEZER_TOKEN_KEY];
    [standardUserDefaults removeObjectForKey:DEEZER_EXPIRATION_DATE_KEY];
    [standardUserDefaults removeObjectForKey:DEEZER_USER_ID_KEY];
    [standardUserDefaults synchronize];
}





//SINGLETON METHOD


+ (deezerClass *)deezerSession
{
    static deezerClass * shared;
    
    @synchronized(shared)
    {
        
        if ( !shared || shared == NULL ){
            
            // allocate the shared instance, because it hasn't been done yet
            shared = [[deezerClass alloc] init];
        }
    }
    
    return shared;
    
}


@end
