/*
 *  Diagnostic_Mobile_Data.m
 *  Diagnostic Plugin - Mobile Data Module
 *
 *  Copyright (c) 2018 Working Edge Ltd.
 *  Copyright (c) 2012 AVANTIC ESTUDIO DE INGENIEROS
 */

#import <CoreTelephony/CTCellularData.h>

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
            [diagnostic sendPluginResultBool:[self isMobileDataAuthorized] :command];
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

@end
