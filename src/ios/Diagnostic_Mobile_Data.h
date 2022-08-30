/*
 *  Diagnostic_Mobile_Data.h
 *  Diagnostic Plugin - Mobile Data Module
 *
 *  Copyright (c) 2018 Working Edge Ltd.
 *  Copyright (c) 2012 AVANTIC ESTUDIO DE INGENIEROS
 */

#import <CoreTelephony/CTCellularData.h>

#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>
#import "Diagnostic.h"


@interface Diagnostic_Mobile_Data : CDVPlugin

@property (nonatomic) CTCellularData* cellularInfo;

- (void) isMobileDataAuthorized: (CDVInvokedUrlCommand*)command;

@end
