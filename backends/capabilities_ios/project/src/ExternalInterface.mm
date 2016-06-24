/*
 * Copyright (c) 2003-2016, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#include <hx/CFFI.h>

///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_isLandscapeNative()
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

	return alloc_bool(landscape);
}
DEFINE_PRIM(ioscapabilities_isLandscapeNative,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_isJailbroken()
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"])
    {
        return alloc_bool(YES);
    }
    else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"])
    {
        return alloc_bool(YES);
    }
    else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"])
    {
        return alloc_bool(YES);
    }

    /// Test for file write permission, maybe against apple rules
    /// TESTED (only on non rooted devices)
    //NSError *error;
    //NSString *stringToBeWritten = @"This is a test.";
    //
    //[stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    //
    //if(error==nil)
    //{
        //Device is jailbroken
    //    return alloc_bool(YES);
    //}
    //else
    //{
        //Device is not jailbroken
    //    [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    //}

    return alloc_bool(NO);
}
DEFINE_PRIM(ioscapabilities_isJailbroken,0);
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
static value ioscapabilities_getDeviceModel()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    deviceModel = [deviceModel stringByReplacingOccurrencesOfString:@"," withString:@"."];

    NSUInteger index = [deviceModel rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location;
    NSString *deviceNumber = [deviceModel substringFromIndex:index];
    deviceModel = [deviceModel substringToIndex:index];

    NSString *str = [NSString stringWithFormat:@"%@#%@", deviceModel, deviceNumber];
    return alloc_string(str.UTF8String);
}
DEFINE_PRIM(ioscapabilities_getDeviceModel,0);
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
static value ioscapabilities_getDensity()
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    return alloc_float(screenScale);
}
DEFINE_PRIM(ioscapabilities_getDensity,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getTotalMemory()
{
    return alloc_float([NSProcessInfo processInfo].physicalMemory);
}
DEFINE_PRIM(ioscapabilities_getTotalMemory,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
static value ioscapabilities_getPreferredLanguage()
{
    NSString *preferredLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    return alloc_string(preferredLanguage.UTF8String);
}
DEFINE_PRIM(ioscapabilities_getPreferredLanguage,0);
///+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

extern "C" int ioscapabilities_register_prims () { return 0; }
