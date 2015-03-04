package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import preferences.Editor;
import preferences.Preferences;
import Math;
import capabilities.Platform;

class Capabilities
{
    private static inline var KEY: String = "capabilities_visitor_id";

	private static var psInstance: Capabilities;

	private var uniqID: String;

	public var applicationName(get, never): String;
	public var applicationVersion(get, never): String;

	@:isVar public var os(get, null): OS;
	public var isDebug(get, never): Bool;

	public var resolutionX(get, never): Int;
	public var resolutionY(get, never): Int;

	public var deviceOrientation(get, never): DeviceOrientation;
	public var deviceName(get, never): String;
	public var deviceID(get, never): String;
	public var platform(get, never): Platform;

    public var advertisingIdentifier(get, never): String;

	public var buildInfo(get, never): BuildInfo;
    public var deviceType(get, never): DeviceType;
    public var preferredLanguage(get, never): String;

	public static function instance(): Capabilities
	{
		if (psInstance == null)
		{
			psInstance = new Capabilities();
		}

		return psInstance;
	}

    private function new()
    {
        generateUID();
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
		var pattern = ~/[^0-9.]+/; //get only digits out of a string

		if (os == null)
		{
            os =
            {
			    name : flash.system.Capabilities.os,
			    version : pattern.split(flash.system.Capabilities.os)[1],
                fullName : flash.system.Capabilities.os
            };
		}

		return os;
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
		return DeviceOrientation.Unknown;
	}

	public function get_deviceID(): String
	{
		return uniqID;
	}

    public function get_advertisingIdentifier(): String
    {
        return deviceID;
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
		return "Flash";
	}

    public function get_deviceType(): DeviceType
    {
        return DeviceType.UNKNOWN;
    }

    public function get_preferredLanguage(): String
    {
        return flash.system.Capabilities.language;
    }

    private function generateUID(): Void
    {
        uniqID = Preferences.getString(KEY);

        if (uniqID == null)
        {
            uniqID = guid();

            var editor: Editor = Preferences.getEditor();
            editor.putString(KEY, uniqID);
            editor.synchronize();
        }
    }

    private function guid(): String
    {
        inline function s4(): String
        {
            return untyped Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
        };
     
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
               s4() + '-' + s4() + s4() + s4();
    }
}