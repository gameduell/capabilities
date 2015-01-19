package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import capabilities.Platform;
extern class Capabilities
{
	/**
	* @private
	*/
	private static var psInstance: Capabilities;

	/**
	* applicationName the application name specefied in the duell_project.xml
	*/
	public var applicationName(get, null): String;

	/**
	* applicationVersion the application version specefied in the duell_project.xml
	*/
	public var applicationVersion(get, null): String;
	/**
	* applicationPackage the application package specefied in the duell_project.xml
	*/
	public var applicationPackage(get, null): String;

	/**
	* os the current operating system of the application
	*/
	public var os(get, null):OS;

	/**
	* isDebug if the current app is running in debug or not
	*/
	public var isDebug(get, null): Bool;

	/**
	* screenDPI the screen density of the current device the app running on
	*/
	public var screenDPI(get, null): Float;

	/**
	* resolutionX the screen resolution width of the current device the app running on
	*/
	public var resolutionX(get, null): Int;

	/**
	* resolutionY the screen resolution height of the current device the app running on
	*/
	public var resolutionY(get, null): Int;

	/**
	* deviceOrientation the device orientation of mobile device
	* WARNING : this can be null in FLASH or HTML5
	* the result will be DeviceOrientation.Landscape or DeviceOrientation.Portrait
	*/
	public var deviceOrientation(get, null): DeviceOrientation;
	/**
	* deviceName the device name the application running on
	* WARNING : this can be null in FLASH or HTML5
	*/
	public var deviceName(get, null): String;
	/**
	* deviceID the device vendor ID the application running on
	* WARNING : this can be null in FLASH or HTML5
	*/
	public var deviceID(get, null): String;
	/**
	* platform the application running on
	* result will be  Platform.FLASH , Platform.HTML5, Platform.ANDROID or Platform.IOS
	*/
	public var platform(get, null): Platform;

	/**
	* buildInfo the build info collected while building the app
	* containing build number, version, haxe arguments etc...
	*/
	public var buildInfo(get, null): BuildInfo;

	/**
	* get the Capabilities instance
	*/
	public static function instance(): Capabilities;
	private function new();
}