package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import capabilities.Capabilities.OS;
class Capabilities
{
	private static var instance: Capabilities;
	private static var os: OS;
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


	public static function instance(): Capabilities
	{
		if(instance == null)
		{
			instance = new Capabilities();
		}
		return instance;
	}

	public function get_isDebug(): Bool
	{
		return Capabilities.isDebug;
	}
	public function get_applicatonName(): String
	{

	}

	public function get_applicationVersion(): String
	{

	}

	public function get_os(): OS
	{
		var pattern = ~/[^0-9.]+/;//get only digits out of a string
		if(os.name == null)
		{
			os.name = Capabilities.os;
			os.fullName = Capabilities.os;
			os.version = pattern.split(Capabilities.os)[1];
		}
		return os;
	}

	public function get_screenDPI(): Float
	{
		return Capabilities.screenDPI;
	}

	public function get_resolutionX(): Int
	{
		return Capabilities.resolutionX;
	}

	public function get_resolutionY(): Int
	{
		return Capabilities.resolutionY;
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
}