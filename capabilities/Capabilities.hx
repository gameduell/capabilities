/*
 * Copyright (c) 2003-2016, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
		Returns the amount of physical memory in bytes.
 	*/
	public var totalMemory(get, never): Float;

	/**
	* deviceOrientation the device orientation of mobile device
	* WARNING : this can be null in FLASH or HTML5
	* the result will be DeviceOrientation.Landscape or DeviceOrientation.Portrait
	*/
	public var deviceOrientation(get, never): DeviceOrientation;

    /**
	* deviceName the device model the application running on
	*/
    public var deviceModel(get, never): String;

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
    * environment where the application is running in.
    * result will be Environment.NATIVE (default) or Environment.GAMEROOM
    */
    public var environment(get, never):Environment;

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
		Retrieves an ID which should be persistent for the current platform under most circumstances (i.e. good to use
		for user identification).
     */
	public var persistentID(get, never): String;

	/**
	* Returns true if the device is rooted/jailbroken
	* On HTML5 it returns false anyway.
	* **/
	public var isRooted(get, never): Bool;

	/**
	* get the Capabilities instance
	*/
	public static function instance(): Capabilities;

    /**
        Initialization of the library, should be called before anything else
     */
    public static function initialize(callback: Void -> Void): Void;
}