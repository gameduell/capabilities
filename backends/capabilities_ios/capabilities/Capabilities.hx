/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package capabilities;

import capabilities.Platform;
import cpp.Lib;

class Capabilities
{
    private static var getSystemNameNative = Lib.load("ioscapabilities","ioscapabilities_getSystemName",0);
    private static var getSystemVersionNative = Lib.load("ioscapabilities","ioscapabilities_getSystemVersion",0);
    private static var getDeviceIDNative = Lib.load("ioscapabilities","ioscapabilities_getDeviceID",0);
    private static var getDeviceModelNative = Lib.load("ioscapabilities","ioscapabilities_getDeviceModel",0);
    private static var getDeviceNameNative = Lib.load("ioscapabilities","ioscapabilities_getDeviceName",0);
    private static var getAdvertisingIdentifierNative = Lib.load("ioscapabilities","ioscapabilities_getAdvertisingIdentifier",0);
    private static var getResolutionXNative = Lib.load("ioscapabilities","ioscapabilities_getResolutionX",0);
    private static var getResolutionYNative = Lib.load("ioscapabilities","ioscapabilities_getResolutionY",0);
    private static var getDensityNative = Lib.load("ioscapabilities","ioscapabilities_getDensity",0);
    private static var getPreferredLanguageNative = Lib.load("ioscapabilities","ioscapabilities_getPreferredLanguage",0);
    private static var isLandscapeNative = Lib.load("ioscapabilities","ioscapabilities_isLandscapeNative",0);
    private static var isIPhoneNative = Lib.load("ioscapabilities","ioscapabilities_isIPhone",0);

	private static var psInstance: Capabilities = null;

	public var applicationName(get, never): String;
	public var applicationVersion(get, never): String;

	public var os(get, never): OS;
	public var isDebug(get, never): Bool;

	public var resolutionX(get, never): Int;
	public var resolutionY(get, never): Int;
    public var density(get, never): Float;

	public var deviceOrientation(get, never): DeviceOrientation;
    public var deviceModel(get, never): String;
	public var deviceName(get, never): String;
	public var deviceID(get, never): String;
    public var advertisingIdentifier(get, never): String;
	public var platform(get, never): Platform;
	public var buildInfo(get, never): BuildInfo;
    public var deviceType(get, never): DeviceType;
    public var preferredLanguage(get, never): String;

    private function new()
    {}

    public static function initialize(callback: Void -> Void): Void
    {
        if (psInstance == null)
        {
            psInstance = new Capabilities();
        }

        if (callback != null)
        {
            callback();
        }
    }

    public static function instance(): Capabilities
    {
        if (psInstance == null)
        {
            throw '"initialize()" should be called first before acessing the instance';
        }

        return psInstance;
    }

	private function get_isDebug(): Bool
	{
    #if debug
        return true;
    #else
		return false;
    #end
	}

	private function get_applicationVersion(): String
	{
		return BuildInfo.instance().applicationVersion;
	}

	private function get_os(): OS
	{
        var osName: String = getSystemNameNative();
        var osVersion: String = getSystemVersionNative();

        var os: OS =
        {
            name : osName,
            version : osVersion,
            fullName : '$osName $osVersion'
        };

        return os;
	}

	private function get_resolutionX(): Int
	{
        return getResolutionXNative();
	}

	private function get_resolutionY(): Int
	{
        return getResolutionYNative();
	}

    private function get_density(): Float
    {
        return getDensityNative();
    }

	private function get_deviceOrientation(): DeviceOrientation
	{
		return isLandscapeNative() ? DeviceOrientation.LANDSCAPE : DeviceOrientation.PORTRAIT;
	}

	private function get_deviceID(): String
	{
		return getDeviceIDNative();
	}

    private function get_advertisingIdentifier(): String
    {
        return getAdvertisingIdentifierNative();
    }

	private function get_platform(): Platform
	{
		return Platform.IOS;
	}

	private function get_buildInfo(): BuildInfo
	{
		return BuildInfo.instance();
	}

	private function get_applicationName(): String
	{
		return BuildInfo.instance().applicationName;
	}

    private function get_deviceModel(): String
    {
        return getDeviceModelNative();
    }

	private function get_deviceName(): String
	{
		return getDeviceNameNative();
	}

    private function get_deviceType(): DeviceType
    {
        return isIPhoneNative() ? DeviceType.PHONE : DeviceType.TABLET;
    }

    private function get_preferredLanguage(): String
    {
        return getPreferredLanguageNative();
    }
}