/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package capabilities;

import capabilities.Platform;

extern class Capabilities
{
	/**
	* applicationName the application name specefied in the duell_project.xml
	*/
	public var applicationName(get, never): String;

	/**
	* applicationVersion the application version specefied in the duell_project.xml
	*/
	public var applicationVersion(get, never): String;

	/**
	* os the current operating system of the application
	*/
	public var os(get, never): OS;

	/**
	* isDebug if the current app is running in debug or not
	*/
	public var isDebug(get, never): Bool;

	/**
	* resolutionX the screen resolution width of the current device the app running on
	*/
	public var resolutionX(get, never): Int;

	/**
	* resolutionY the screen resolution height of the current device the app running on
	*/
	public var resolutionY(get, never): Int;

	/**
        Returns 1.0 for a screen pixel density of 160dpi.
     */
	public var density(get, never): Float;

	/**
	* deviceOrientation the device orientation of mobile device
	* WARNING : this can be null in FLASH or HTML5
	* the result will be DeviceOrientation.Landscape or DeviceOrientation.Portrait
	*/
	public var deviceOrientation(get, never): DeviceOrientation;

	/**
	* deviceName the device name the application running on
	* WARNING : this can be null in FLASH or HTML5
	*/
	public var deviceName(get, never): String;

	/**
	* deviceID the device vendor ID the application running on
	* WARNING : this can be null in FLASH or HTML5
	*/
	public var deviceID(get, never): String;

    /**
	* Apple's advertising identifier or Google's Android ID, or `null` if it's not available but might be in the future.

 	* WARNING : for FLASH or HTML5 it will return the `deviceID`.
	*/
    public var advertisingIdentifier(get, never): String;

	/**
	* platform the application running on
	* result will be  Platform.FLASH , Platform.HTML5, Platform.ANDROID or Platform.IOS
	*/
	public var platform(get, never): Platform;

	/**
	* buildInfo the build info collected while building the app
	* containing build number, version, haxe arguments etc...
	*/
	public var buildInfo(get, never): BuildInfo;

    /**
        Retrieves the device type (i.e. phone, tablet or browser).
     */
    public var deviceType(get, never): DeviceType;

    /**
        Retrieves the user's preferred language in this device.
     */
    public var preferredLanguage(get, never): String;

	/**
	* get the Capabilities instance
	*/
	public static function instance(): Capabilities;

    /**
        Initialization of the library, should be called before anything else
     */
    public static function initialize(callback: Void -> Void): Void;
}