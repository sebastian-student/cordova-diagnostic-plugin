/*
 *  Diagnostic_Mobile_Data.m
 *  Diagnostic Plugin - Mobile Data Module
 *
 *  Copyright (c) 2018 Working Edge Ltd.
 *  Copyright (c) 2012 AVANTIC ESTUDIO DE INGENIEROS
 */

#import <CoreTelephony/CTCellularData.h>
#import <ifaddrs.h>

#import "Diagnostic_Mobile_Data.h"

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

- (void) isMobileDataAuthorized: (CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        @try {
            bool authorized = [self isMobileDataAuthorized] || ![self hasCellular];
            [diagnostic sendPluginResultBool:authorized :command];
        }
        @catch (NSException *exception) {
            [diagnostic handlePluginException:exception :command];
        }
    }];
}

/********************************/
#pragma mark - Internals
/********************************/

- (BOOL) isMobileDataAuthorized {
    return _cellularInfo.restrictedState == kCTCellularDataNotRestricted;
}

- (bool) hasCellular {
    // implementation from https://stackoverflow.com/a/14507324
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    bool found = false;
    if (getifaddrs(&addrs) == 0) {
        cursor = addrs;
        while (cursor != NULL) {
            NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
            if ([name isEqualToString:@"pdp_ip0"]) {
                found = true;
                break;
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return found;
}

@end
