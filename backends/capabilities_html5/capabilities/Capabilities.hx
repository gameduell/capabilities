package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import preferences.Editor;
import preferences.Preferences;
import js.Browser;
import capabilities.Platform;

typedef OSData =
{
    os: String,
    osVersion: String,
};

typedef BrowserData =
{
    name: String,
    fullVersion: String,
    majorVersion: String,
    userAgent : String
};

class Capabilities
{
    private static inline var KEY: String = "capabilities_visitor_id";

    private static var psInstance: Capabilities;

    private var osData: OSData;
    private var browserData:BrowserData;

    public var applicationName(get, null): String;
    public var applicationVersion(get, null): String;

    public var os(get, null): OS;
    public var isDebug(get, null): Bool;

    public var resolutionX(get, null): Int;
    public var resolutionY(get, null): Int;

    public var deviceOrientation(get, null): DeviceOrientation;
    public var deviceName(get, null): String;
    public var deviceID(get, null): String;
    public var platform(get, null): Platform;
    public var advertisingIdentifier(get, never): String;

    public var buildInfo(get, never): BuildInfo;
    public var deviceType(get, never): DeviceType;
    public var preferredLanguage(get, never): String;

    private var uniqueID: String;

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
        parseOS();
        generateAndStoreUniqueID();
        parseBrowserData();
    }

    public function get_isDebug(): Bool
    {
    #if debug
        return true;
    #else
        return false;
    #end
    }

    public function get_applicationVersion(): String
    {
        return BuildInfo.instance().APPLICATION_VERSION;
    }

    public function get_os(): OS
    {
        var os:OS =
        {
            name: osData.os,
            fullName: osData.os,
            version:  osData.osVersion
        };

        return os;
    }

	public function get_resolutionX(): Int
	{
        return Browser.window.screen.availWidth;
    }

    public function get_resolutionY(): Int
    {
        return Browser.window.screen.availHeight;
    }

    public function get_deviceID(): String
    {
        return uniqueID;
    }

    private function generateAndStoreUniqueID(): Void
    {
        uniqueID = Preferences.getString(KEY);

        if (uniqueID == null)
        {
            uniqueID = guid();

            var editor: Editor = Preferences.getEditor();
            editor.putString(KEY, uniqueID);
            editor.synchronize();
        }
    }

    private function parseBrowserData(): Void
    {
        var nVer = Browser.navigator.appVersion;
        var nAgt = Browser.navigator.userAgent;
        var browserName  = Browser.navigator.appName;
        var fullVersion  = '' + Std.parseFloat(Browser.navigator.appVersion);
        var majorVersion = untyped parseInt(Browser.navigator.appVersion, 10);
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
            fullVersion = nAgt.substring(verOffset+8);
        }
        // In most other browsers, "name/version" is at the end of userAgent 
        else if ( (nameOffset=nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt.lastIndexOf('/')) )
        {
            browserName = nAgt.substring(nameOffset,verOffset);
            fullVersion = nAgt.substring(verOffset + 1);

            if (browserName.toLowerCase() == browserName.toUpperCase())
            {
               browserName = Browser.navigator.appName;
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

        majorVersion = untyped parseInt(''+fullVersion, 10);
        if (untyped isNaN(majorVersion)) 
        {
            fullVersion  = ''+Std.parseFloat(Browser.navigator.appVersion); 
            majorVersion = untyped parseInt(Browser.navigator.appVersion, 10);
        }

        browserData =
        {
            name: browserName,
            fullVersion: fullVersion,
            majorVersion: majorVersion,
            userAgent : Browser.navigator.userAgent
        };
    }

    private function parseOS(): Void
    {
        var nAgt = Browser.navigator.userAgent;
        var nVer = Browser.navigator.appVersion;
        // system
        var os = "unknown";
        var clientStrings =
        [
            {s:'Windows 3.11', r:~/Win16/},
            {s:'Windows 95', r:~/(Windows 95|Win95|Windows_95)/},
            {s:'Windows ME', r:~/(Win 9x 4.90|Windows ME)/},
            {s:'Windows 98', r:~/(Windows 98|Win98)/},
            {s:'Windows CE', r:~/Windows CE/},
            {s:'Windows 2000', r:~/(Windows NT 5.0|Windows 2000)/},
            {s:'Windows XP', r:~/(Windows NT 5.1|Windows XP)/},
            {s:'Windows Server 2003', r:~/Windows NT 5.2/},
            {s:'Windows Vista', r:~/Windows NT 6.0/},
            {s:'Windows 7', r:~/(Windows 7|Windows NT 6.1)/},
            {s:'Windows 8.1', r:~/(Windows 8.1|Windows NT 6.3)/},
            {s:'Windows 8', r:~/(Windows 8|Windows NT 6.2)/},
            {s:'Windows NT 4.0', r:~/(Windows NT 4.0|WinNT4.0|WinNT|Windows NT)/},
            {s:'Windows ME', r:~/Windows ME/},
            {s:'Android', r:~/Android/},
            {s:'Open BSD', r:~/OpenBSD/},
            {s:'Sun OS', r:~/SunOS/},
            {s:'Linux', r:~/(Linux|X11)/},
            {s:'iOS', r:~/(iPhone|iPad|iPod)/},
            {s:'Mac OS X', r:~/Mac OS X/},
            {s:'Mac OS', r:~/(MacPPC|MacIntel|Mac_PowerPC|Macintosh)/},
            {s:'QNX', r:~/QNX/},
            {s:'UNIX', r:~/UNIX/},
            {s:'BeOS', r:~/BeOS/},
            {s:'OS/2', r:~/OS\/2/},
            {s:'Search Bot', r:~/(nuhk|Googlebot|Yammybot|Openbot|Slurp|MSNBot|Ask Jeeves\/Teoma|ia_archiver)/}
        ];

        for (client in clientStrings)
        {
            if (client.r.match(nAgt))
            {
                os = client.s;
                break;
            }
        }

        var osVersion = "unknown";

        if (~/Windows/.match(os))
        {
            osVersion = ~/Windows (.*)/.split(os)[1];
            os = 'Windows';
        }

        switch (os)
        {
            case 'Mac OS X':
                osVersion = ~/Mac OS X (10[._\d]+)/.split(nAgt)[1];
            case 'Android':
                osVersion = ~/Android ([._\d]+)/.split(nAgt)[1];
            case 'iOS':
                var osVersionArray = ~/OS (\d+)_(\d+)_?(\d+)?/.split(nVer);
                osVersion = osVersionArray[1] + '.' + osVersionArray[2] + '.' + "x";
        }

        osData = { os : os, osVersion : osVersion };
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

	public function get_deviceOrientation(): DeviceOrientation
	{
        return DeviceOrientation.Unknown;
	}

    public function get_advertisingIdentifier(): String
    {
        return deviceID;
    }

	public function get_platform(): Platform
	{
		return Platform.HTML5;
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
		return browserData.name;
	}

    public function get_deviceType(): DeviceType
    {
        return DeviceType.UNKNOWN;
    }

    public function get_preferredLanguage(): String
    {
        var language: String = Browser.navigator.language;
        return language.substring(0,language.indexOf("-"));
    }
}