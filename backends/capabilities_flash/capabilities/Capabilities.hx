package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import Math;
import capabilities.Platform;
class Capabilities
{
	private static var psInstance: Capabilities;
	private static var __os: OS;
	private function new()
	{}
	public var applicationName(get, null): String;
	public var applicationVersion(get, null): String;

	public var os(get, null):OS;
	public var isDebug(get, null): Bool;

	public var screenDPI(get, null): Float;
	public var resolutionX(get, null): Int;
	public var resolutionY(get, null): Int;

	public var deviceOrientation(get, null): DeviceOrientation;
	public var deviceName(get, null): String;
	public var deviceID(get, null): String;
	public var platform(get, null): Platform;

	public var buildInfo(get, null): BuildInfo;
    public var deviceType(get, null): DeviceType;

	public static function instance(): Capabilities
	{
		if(psInstance == null)
		{
			psInstance = new Capabilities();
		}
		return psInstance;
	}

	public function get_isDebug(): Bool
	{
		return flash.system.Capabilities.isDebugger;
	}

	public function get_applicationVersion(): String
	{
		return BuildInfo.instance().APPLICATION_VERSION;
	}

	public function get_os(): OS
	{
		var pattern = ~/[^0-9.]+/;//get only digits out of a string
		if(__os.name == null)
		{
			__os.name = flash.system.Capabilities.os;
			__os.fullName = flash.system.Capabilities.os;
			__os.version = pattern.split(flash.system.Capabilities.os)[1];
		}
		return __os;
	}

	public function get_screenDPI(): Float
	{
		return flash.system.Capabilities.screenDPI;
	}

	public function get_resolutionX(): Int
	{
		return Math.ceil(flash.system.Capabilities.screenResolutionX);
	}

	public function get_resolutionY(): Int
	{
		return Math.ceil(flash.system.Capabilities.screenResolutionY);
	}

	public function get_deviceOrientation(): DeviceOrientation
	{
		return null;
	}

	public function get_deviceID(): String
	{
		return null;
	}

	public function get_platform(): Platform
	{
		return Platform.FLASH;
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
		return null;
	}

    public function get_deviceType(): DeviceType
    {
        // TODO
        return DeviceType.UNKNOWN;
    }
}