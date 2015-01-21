#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif
#import <UIKit/UIKit.h>
#include <hx/CFFI.h>


static value ioscapabilities_getDeviceOrientation()
{
    UIDeviceOrientation dOrientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation iOrientation = [UIApplication sharedApplication].statusBarOrientation;
    bool landscape;
	if (dOrientation == UIDeviceOrientationUnknown || dOrientation == UIDeviceOrientationFaceUp || dOrientation == UIDeviceOrientationFaceDown)
	{
		// If the device is laying down, use the UIInterfaceOrientation based on the status bar.
		landscape = UIInterfaceOrientationIsLandscape(iOrientation);
	} else
	{
		// If the device is not laying down, use UIDeviceOrientation.
		landscape = UIDeviceOrientationIsLandscape(dOrientation);
	}

	if (landscape)
	{
		return alloc_int(0);
	}

    return alloc_int(1);
}
DEFINE_PRIM(ioscapabilities_getDeviceOrientation,0);

extern "C" int ioscapabilities_register_prims () { return 0; }
