package capabilities;

import hxjni.JNI;
import capabilities.Platform;

/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
class Capabilities
{
    private static var getDeviceNameNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getDeviceName", "()Ljava/lang/String;");
    private static var getSystemVersionNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getSystemVersion", "()Ljava/lang/String;");
    private static var getAndroidIdNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getAndroidId", "()Ljava/lang/String;");
    private static var getSerialNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getSerial", "()Ljava/lang/String;");
    private static var getResolutionXNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getResolutionX", "()I");
    private static var getResolutionYNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getResolutionY", "()I");
    private static var getDensityDpiNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "getDensityDpi", "()F");
    private static var isLandscapeNative = JNI.createStaticMethod("org/haxe/duell/capabilities/Capabilities",
    "isLandscape", "()Z");

    private static var psInstance: Capabilities;

	public var applicationName(get, null): String;
	public var applicationVersion(get, null): String;

	public var os(get, null): OS;
	public var isDebug(get, null): Bool;

	public var screenDPI(get, null): Float;
	public var resolutionX(get, null): Int;
	public var resolutionY(get, null): Int;

	public var deviceOrientation(get, null): DeviceOrientation;
	public var deviceName(get, null): String;
	public var deviceID(get, null): String;
	public var platform(get, null): Platform;

	public var buildInfo(get, null): BuildInfo;

    private function new()
    {}

	public static function instance(): Capabilities
	{
		if (psInstance == null)
		{
            psInstance = new Capabilities();
		}

		return psInstance;
	}

	public function get_isDebug(): Bool
	{
    #if debug
        return true;
    #else
        return false;
    #end
	}

	public function get_applicationVersion(): String
	{
        return BuildInfo.instance().APPLICATION_VERSION;
	}

	public function get_os(): OS
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

	public function get_screenDPI(): Float
	{
        return getDensityDpiNative();
	}

	public function get_resolutionX(): Int
	{
        return getResolutionXNative();
	}

	public function get_resolutionY(): Int
	{
        return getResolutionYNative();
	}

	public function get_deviceOrientation(): DeviceOrientation
	{
        return isLandscapeNative ? DeviceOrientation.Landscape : DeviceOrientation.Portrait;
	}

	public function get_deviceID(): String
	{
        return getSerialNative();
	}

	public function get_platform(): Platform
	{
		return Platform.ANDROID;
	}

	public function get_buildInfo(): BuildInfo
	{
		return BuildInfo.instance();
	}

	public function get_applicationName(): String
	{
		return BuildInfo.instance().APPLICATION_NAME;
	}

	public function get_deviceName(): String
	{
		return getDeviceNameNative();
	}
}