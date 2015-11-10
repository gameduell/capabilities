/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package capabilities;

import hxjni.JNI;
import capabilities.Platform;

@:keep
class Capabilities
{
    private static var retrieveAdvertisementIdNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "retrieveAdvertisementId", "(Lorg/haxe/duell/hxjni/HaxeObject;)V");
    private static var getDeviceModelNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getDeviceModel", "()Ljava/lang/String;");
    private static var getSystemVersionNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getSystemVersion", "()Ljava/lang/String;");
    private static var getSerialNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getSerial", "()Ljava/lang/String;");
    private static var getResolutionXNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getResolutionX", "()I");
    private static var getResolutionYNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getResolutionY", "()I");
    private static var getDensityNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getDensity", "()D");
    private static var isLandscapeNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "isLandscape", "()Z");
    private static var isRootedDevice = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "isRootedDevice", "()Z");
    private static var isPhoneNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "isPhone", "()Z");
    private static var getPreferredLanguageNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getPreferredLanguage", "()Ljava/lang/String;");

    private static var psInstance: Capabilities;

    private var onInitializedCallback: Void -> Void;

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
	public var platform(get, never): Platform;

    public var advertisingIdentifier(default, null): String;

	public var buildInfo(get, never): BuildInfo;
    public var deviceType(get, never): DeviceType;

    public var preferredLanguage(get, never): String;
    public var isRooted(get, never): Bool;

    private function new(callback: Void -> Void)
    {
        onInitializedCallback = callback;

        retrieveAdvertisementIdNative(this);
    }

    public static function initialize(callback: Void -> Void): Void
    {
        if (psInstance == null)
        {
            psInstance = new Capabilities(callback);
        }
        else
        {
            // if it is already initialized, call the callback directly
            if (callback != null)
            {
                callback();
            }
        }
    }

    public function onDataReceived(data: Dynamic): Void
    {
        advertisingIdentifier = data;

        if (onInitializedCallback != null)
        {
            onInitializedCallback();
        }

        onInitializedCallback = null;
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
        var osName: String = "Android";
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
        return getSerialNative();
	}

    private function get_platform(): Platform
	{
		return Platform.ANDROID;
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

    private inline function get_deviceName(): String
    {
        return os.name;
    }

    private function get_deviceType(): DeviceType
    {
        return isPhoneNative() ? DeviceType.PHONE : DeviceType.TABLET;
    }

    private function get_preferredLanguage(): String
    {
        return getPreferredLanguageNative();
    }

    private function get_isRooted(): Bool
    {
        return isRootedDevice();
    }
}