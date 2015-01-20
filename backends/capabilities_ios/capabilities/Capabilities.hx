package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import capabilities.Platform;
import cpp.Lib;
class Capabilities
{
	private static var psInstance: Capabilities;
	private static var getDeviceOrientationNative = Lib.load("ioscapabilities","ioscapabilities_getDeviceOrientation",0);
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
		return false;
	}

	public function get_applicationVersion(): String
	{
		return BuildInfo.getInstance().APPLICATION_VERSION;
	}

	public function get_os(): OS
	{
		return null;
	}

	public function get_screenDPI(): Float
	{
		return 0;
	}

	public function get_resolutionX(): Int
	{
		return 0;
	}

	public function get_resolutionY(): Int
	{
		return 0;
	}

	public function get_deviceOrientation(): DeviceOrientation
	{
		return getDeviceOrientationNative() == 0 ? DeviceOrientation.Portrait : DeviceOrientation.Landscape;
	}

	public function get_deviceID(): String
	{
		return null;
	}

	public function get_platform(): Platform
	{
		return Platform.IOS;
	}

	public function get_buildInfo(): BuildInfo
	{
		return BuildInfo.getInstance();
	}

	public function get_applicationName(): String
	{
		return BuildInfo.getInstance().APPLICATION_NAME;
	}

	public function get_deviceName(): String
	{
		return null;
	}
}