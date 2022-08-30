/*
 *  Diagnostic_Mobile_Data.m
 *  Diagnostic Plugin - Mobile Data Module
 *
 *  Copyright (c) 2018 Working Edge Ltd.
 *  Copyright (c) 2012 AVANTIC ESTUDIO DE INGENIEROS
 */

#import "Diagnostic_Mobile_Data.h"

#import <arpa/inet.h> // For AF_INET, etc.
#import <ifaddrs.h> // For getifaddrs()
#import <net/if.h> // For IFF_LOOPBACK

@implementation Diagnostic_Mobile_Data

// Internal reference to Diagnostic singleton instance
static Diagnostic* diagnostic;

// Internal constants
static NSString*const LOG_TAG = @"Diagnostic_Mobile_Data[native]";

- (void)pluginInitialize {
    
    [super pluginInitialize];

    diagnostic = [Diagnostic getInstance];
    _cellularInfo = [[CTCellularData alloc] init];
}

/********************************/
#pragma mark - Plugin API
/********************************/

- (void) isMobileDataAllowed: (CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        @try {
            [diagnostic sendPluginResultBool:[self isMobileDataAllowed] :command];
        }
        @catch (NSException *exception) {
            [diagnostic handlePluginException:exception :command];
        }
    }];
}

/********************************/
#pragma mark - Internals
/********************************/

- (BOOL) isMobileDataAllowed {
    return _cellularInfo.restrictedState == kCTCellularDataNotRestricted;
}

@end
