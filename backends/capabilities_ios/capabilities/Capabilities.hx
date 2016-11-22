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
    private static var getTotalMemory = Lib.load("ioscapabilities","ioscapabilities_getTotalMemory",0);
    private static var getPreferredLanguageNative = Lib.load("ioscapabilities","ioscapabilities_getPreferredLanguage",0);
    private static var isLandscapeNative = Lib.load("ioscapabilities","ioscapabilities_isLandscapeNative",0);
    private static var isIPhoneNative = Lib.load("ioscapabilities","ioscapabilities_isIPhone",0);
    private static var isRootedDevice = Lib.load("ioscapabilities","ioscapabilities_isJailbroken",0);
    private static var getHardwareVersionNative = Lib.load("ioscapabilities","ioscapabilities_getHardwareVersion",0);
    private static var getPersistentIDNative = Lib.load("ioscapabilities","ioscapabilities_getPersistentID",0);

    private static var psInstance: Capabilities = null;

	public var applicationName(get, never): String;
	public var applicationVersion(get, never): String;

	public var os(get, never): OS;
	public var isDebug(get, never): Bool;

	public var resolutionX(get, never): Int;
	public var resolutionY(get, never): Int;
    public var density(get, never): Float;
    public var totalMemory(get, never): Float;

	public var deviceOrientation(get, never): DeviceOrientation;
    public var deviceModel(get, never): String;
	public var deviceName(get, never): String;
	public var deviceID(get, never): String;
    public var advertisingIdentifier(get, never): String;
	public var platform(get, never): Platform;
    public var environment(get, never):Environment;
	public var buildInfo(get, never): BuildInfo;
    public var deviceType(get, never): DeviceType;
    public var preferredLanguage(get, never): String;
    public var persistentID(get, never): String;

    public var isRooted(get, never): Bool;

    // ios-specific
    public var iOSHardwareVersion(get, never): String;

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

    private function get_totalMemory(): Float
    {
        return getTotalMemory();
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

    private function get_environment(): Environment
    {
        return Environment.NATIVE;
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

    private function get_persistentID(): String
    {
        return getPersistentIDNative();
    }

    private function get_isRooted(): Bool
    {
        return isRootedDevice();
    }

    private function get_iOSHardwareVersion(): String
    {
        return getHardwareVersionNative();
    }
}