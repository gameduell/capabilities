package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import js.Browser;
import capabilities.Platform;
class Capabilities
{
	private static var instance: Capabilities;
	private function new()
	{}
	public var applicationName(get, never): String;
	public var applicationVersion(get, never): String;

	public var os(get, never): OS;
	public var isDebug(get, never): Bool;

	public var resolutionX(get, never): Int;
	public var resolutionY(get, never): Int;

	public var deviceOrientation(get, never): DeviceOrientation;
	public var deviceName(get, never): String;
	public var deviceID(get, never): String;
	public var platform(get, never): Platform;

    public var advertisingIdentifier(get, never): String;

    public var deviceType(get, never): DeviceType;
    public var preferredLanguage(get, never): String;

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

	}
	public function get_applicatonName(): String
	{

	}

	public function get_applicationVersion(): String
	{

	}

	public function get_os(): OS
	{

	}

	public function get_resolutionX(): Int
	{
        return Browser.window.screen.availWidth;
	}

	public function get_resolutionY(): Int
	{
        return Browser.window.screen.availHeight;
	}

	public function get_deviceOrientation(): DeviceOrientation
	{

	}

	public function get_deviceID(): String
	{

	}

    public function get_advertisingIdentifier(): String
    {
        return deviceID;
    }

	public function get_platform(): Platform
	{
		return Platform.HTML5;
	}

	public function get_builInfo(): BuildInfo
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

    public function get_preferredLanguage(): String
    {
        // TODO
        return "EN";
    }
}