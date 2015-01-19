package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
extern class Capabilities
{
	private static var psInstance: Capabilities;

	public var applicationName(get, null): String;
	public var applicationVersion(get, null): String;
	public var applicationPackage(get, null): String;

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


	public static function instance(): Capabilities;
	private function new();
}