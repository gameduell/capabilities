/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package capabilities;

import flash.external.ExternalInterface;
import flash.xml.XML;
import preferences.Editor;
import preferences.Preferences;
import capabilities.Platform;

typedef BrowserData =
{
    name: String,
    fullVersion: String,
    majorVersion: String,
    userAgent : String
}

class Capabilities
{
    private static inline var JS_CODE: String = '<![CDATA[
     function()
     {
        var nVer = navigator.appVersion;
        var nAgt = navigator.userAgent;
        var browserName  = navigator.appName;
        var fullVersion  = "" + parseFloat(navigator.appVersion);
        var majorVersion = parseInt(navigator.appVersion, 10);
        var nameOffset, verOffset, ix;

        // In Opera, the true version is after "Opera" or after "Version"
        if ((verOffset=nAgt.indexOf("Opera")) != -1)
        {
            browserName = "Opera";
            fullVersion = nAgt.substring(verOffset + 6);
            if ((verOffset = nAgt.indexOf("Version")) != -1)
            {
                fullVersion = nAgt.substring(verOffset + 8);
            }
        }
        // Opera, again
        else if ((verOffset=nAgt.indexOf("OPR")) != -1)
        {
            browserName = "Opera";
            fullVersion = nAgt.substring(verOffset + 4);
            if ((verOffset = nAgt.indexOf("Version")) != -1)
            {
                fullVersion = nAgt.substring(verOffset + 6);
            }
        }
        // In MSIE, the true version is after "MSIE" in userAgent
        else if ((verOffset=nAgt.indexOf("MSIE")) != -1)
        {
            browserName = "Microsoft Internet Explorer";
            fullVersion = nAgt.substring(verOffset + 5);
        }
        // In Chrome, the true version is after "Chrome"
        else if ((verOffset = nAgt.indexOf("Chrome")) != -1)
        {
            browserName = "Chrome";
            fullVersion = nAgt.substring(verOffset + 7);
        }
        // In Safari, the true version is after "Safari" or after "Version"
        else if ((verOffset = nAgt.indexOf("Safari")) != -1)
        {
            browserName = "Safari";
            fullVersion = nAgt.substring(verOffset + 7);
            if ((verOffset = nAgt.indexOf("Version")) != -1)
            {
                fullVersion = nAgt.substring(verOffset + 8);
            }
        }
        // In Firefox, the true version is after "Firefox"
        else if ((verOffset = nAgt.indexOf("Firefox")) != -1)
        {
            browserName = "Firefox";
            fullVersion = nAgt.substring(verOffset + 8);
        }
        // In most other browsers, "name/version" is at the end of userAgent
        else if ( (nameOffset=nAgt.lastIndexOf(\' \') + 1) < (verOffset = nAgt.lastIndexOf(\'/\')) )
        {
            browserName = nAgt.substring(nameOffset,verOffset);
            fullVersion = nAgt.substring(verOffset + 1);

            if (browserName.toLowerCase() == browserName.toUpperCase())
            {
               browserName = navigator.appName;
            }
        }
        // trim the fullVersion string at semicolon/space if present
        if ((ix = fullVersion.indexOf(";")) != -1)
        {
            fullVersion=fullVersion.substring(0, ix);
        }

        if ((ix = fullVersion.indexOf(" ")) != -1)
        {
            fullVersion = fullVersion.substring(0, ix);
        }

        majorVersion = parseInt("" + fullVersion, 10);
        if (isNaN(majorVersion))
        {
            fullVersion  = "" + parseFloat(navigator.appVersion);
            majorVersion = parseInt(navigator.appVersion, 10);
        }

        browserData =
        {
            name: browserName,
            fullVersion: fullVersion,
            majorVersion: majorVersion,
            userAgent : navigator.userAgent
        };

        return browserData;
     }
     ]]>';

  private static inline var KEY: String = "capabilities_visitor_id";

	private static var psInstance: Capabilities;

	private var uniqID: String;

	public var applicationName(get, never): String;
	public var applicationVersion(get, never): String;

	@:isVar public var os(get, null): OS;
	public var isDebug(get, never): Bool;

	public var resolutionX(get, never): Int;
	public var resolutionY(get, never): Int;
    public var density(get, never): Float;

	public var deviceOrientation(get, never): DeviceOrientation;
    public var deviceModel(get, never): String;
	public var deviceName(get, never): String;
	public var deviceID(get, never): String;
	public var platform(get, never): Platform;

  public var advertisingIdentifier(get, never): String;

  public var buildInfo(get, never): BuildInfo;
  public var deviceType(get, never): DeviceType;
  public var preferredLanguage(get, never): String;

  private var browserData: BrowserData;

  public static function initialize(callback: Void -> Void): Void
  {
      if (psInstance == null)
      {
          psInstance = new Capabilities();
      }

      if (callback != null)
      {
          callback();
      }
  }

  public static function instance(): Capabilities
  {
      if (psInstance == null)
      {
          throw '"initialize()" should be called first before acessing the instance';
      }

      return psInstance;
  }

  private function new()
  {
      generateUID();
      parseBrowserData();
  }

  private function parseBrowserData(): Void
  {
      browserData = ExternalInterface.call(untyped new XML(JS_CODE));
  }

  public function get_isDebug(): Bool
  {
  return flash.system.Capabilities.isDebugger;
  }

  public function get_applicationVersion(): String
  {
  return BuildInfo.instance().applicationVersion;
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

    private function get_density(): Float
    {
        return 1.0; // TODO Find out if we are running in a retina browser
    }

  public function get_deviceOrientation(): DeviceOrientation
  {
  return DeviceOrientation.UNKNOWN;
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
  return BuildInfo.instance().applicationName;
  }

  public function get_deviceModel(): String
  {
      return browserData.name;
  }

  public function get_deviceName(): String
  {
      return os.name;
  }

  public function get_deviceType(): DeviceType
  {
      return DeviceType.BROWSER;
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
