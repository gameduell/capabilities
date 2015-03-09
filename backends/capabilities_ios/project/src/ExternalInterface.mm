//
//  ExternalInterface.mm
//
//  Created by kgar.
//  Copyright (c) 2015 Gameduell Inc. All rights reserved.
//

#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#include <hx/CFFI.h>

///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getDeviceOrientation()
{
    UIDeviceOrientation dOrientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    bool landscape;
	if (dOrientation == UIDeviceOrientationUnknown
	    || dOrientation == UIDeviceOrientationFaceUp
	    || dOrientation == UIDeviceOrientationFaceDown)
	{
		/// If the device is laying down, use the UIInterfaceOrientation based on the status bar.
		landscape = UIInterfaceOrientationIsLandscape(iOrientation);
	}
	else
	{
		/// If the device is not laying down, use UIDeviceOrientation.
		landscape = UIDeviceOrientationIsLandscape(dOrientation);
	}

	if (landscape)
	{
		return alloc_int(0);
	}

    return alloc_int(1);
}
DEFINE_PRIM(ioscapabilities_getDeviceOrientation,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getDeviceID()
{
    UIDevice *device = [UIDevice currentDevice];

    NSString *currentDeviceId = [[device identifierForVendor] UUIDString];

    if (currentDeviceId)
    {
        return alloc_string(currentDeviceId.UTF8String);
    }
    else
    {
        return alloc_null();
    }
}
DEFINE_PRIM(ioscapabilities_getDeviceID,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getAdvertisingIdentifier()
{
    ASIdentifierManager *identifierManager = [ASIdentifierManager sharedManager];
    NSString *advertisingIdentifier = [[identifierManager advertisingIdentifier] UUIDString];

    if (advertisingIdentifier)
    {
        return alloc_string(advertisingIdentifier.UTF8String);
    }
    else
    {
        return alloc_null();
    }
}
DEFINE_PRIM(ioscapabilities_getAdvertisingIdentifier,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getDeviceName()
{
    NSString *currentDeviceName = [[UIDevice currentDevice] name];
    return alloc_string(currentDeviceName.UTF8String);
}
DEFINE_PRIM(ioscapabilities_getDeviceName,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_isIPhone()
{
    BOOL isIPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    return alloc_bool(isIPhone);
}
DEFINE_PRIM(ioscapabilities_isIPhone,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getSystemName()
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *systemName = [device systemName];

    return alloc_string(systemName.UTF8String);
}
DEFINE_PRIM(ioscapabilities_getSystemName,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getSystemVersion()
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *systemVersion = [device systemVersion];

    return alloc_string(systemVersion.UTF8String);
}
DEFINE_PRIM(ioscapabilities_getSystemVersion,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getResolutionX()
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];

    int width = screenBounds.size.width * screenScale;

    return alloc_int(width);
}
DEFINE_PRIM(ioscapabilities_getResolutionX,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getResolutionY()
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];

    int height = screenBounds.size.height * screenScale;

    return alloc_int(height);
}
DEFINE_PRIM(ioscapabilities_getResolutionY,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getPreferredLanguage()
{
    NSString *preferredLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    return alloc_string(preferredLanguage.UTF8String);
}
DEFINE_PRIM(ioscapabilities_getPreferredLanguage,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

extern "C" int ioscapabilities_register_prims () { return 0; }
