package capabilities;
/**
 * @author kgar
 * @date  16/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
import js.Browser;
import js.Cookie;
import capabilities.Platform;

typedef OSData = {
os: String,
osVersion: String,
};
enum PersistanceMethod = {Cookie;LocalStorage;};

class Capabilities
{
    private static var instance: Capabilities;

    private var osData: OSData;
    private function new()
    {}
    public var applicationName(get, null): String;
    public var applicationVersion(get, null): String;

    public var os(get, null): OS;
    public var isDebug(get, null): Bool;

    public var screenDPI(get, null): Float;
    public var resolutionX(get, null): Int;
    public var resolutionY(get, null): Int;

    public var deviceOrientation(get, null): DeviceOrientation;
    public var deviceName(get, null): String;
    public var deviceID(get, null): String;
    public var platform(get, null): Platform;

    private var uniqueID: String;
    private static inline var KEY: String = "persistant_capabilities_visitor_id";
    public static function instance(): Capabilities
    {
        if (instance == null)
        {
            instance = new Capabilities();
            parseOS();
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
        return BuildInfo.getInstance().APPLICATION_VERSION;
    }

    public function get_os(): OS
    {
        var os:OS = {};
        os.name = osData.os;
        os.version = osData.osVersion;
        return os;
    }

    public function get_screenDPI(): Float
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
        return uniqueID;
    }

    public function get_platform(): Platform
    {
        return Platform.HTML5;
    }

    public function get_builInfo(): BuildInfo
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

    private function generateAndStoreUniqueID(): Void
    {
        var method = allowsThirdPartyCookies() ? PersistanceMethod.Cookie : PersistanceMethod.LocalStorage;
        uniqueID = guid();
        sotreUID(method, uniqueID);
    }
    private function parseOS(): Void
    {
        var nAgt = Browser.navigator.userAgent;
        var nVer = Browser.navigator.appVersion;
        // system
        var os = "unknown";
        var clientStrings = [
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
        for (client in clientStrings) {
            if (client.r.match(nAgt)) {
                os = client.s;
                break;
            }
        }

        var osVersion = "unknown";

        if (~/Windows/.match(os)) {
            osVersion = ~/Windows (.*)/.split(os)[1];
            os = 'Windows';
        }

        switch (os) {
            case 'Mac OS X':
                osVersion = ~/Mac OS X (10[._\d]+)/.split(nAgt)[1];
            case 'Android':
                osVersion = ~/Android ([._\d]+)/.split(nAgt)[1];
            case 'iOS':
                var osVersionArray = ~/OS (\d+)_(\d+)_?(\d+)?/.split(nVer);
                osVersion = osVersionArray[1] + '.' + osVersionArray[2] + '.' + "x";

        }
        osData = {os: os, osVersion:osVersion};
    }
    private function allowsThirdPartyCookies() {
        var re = ~/Version\/\d+.\d+(\.\d+)?.*Safari/;

        return !re.match(Browser.navigator.userAgent);
    }
    private function function guid() 
    {
        function s4() {
          return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
        };
     
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
               s4() + '-' + s4() + s4() + s4();
    }
    private function sotreUID(storeType: PersistanceMethod, uid: String):Void
    {
        if(storeType == PersistanceMethod.LocalStorage)
        {
            var store = Browser.getLocalStorage();
            if(store != null)
            {
                store.set(KEY, uid);
            }
        }
        else if(storeType == PersistanceMethod.Cookie)
        {
            Cookie.set(KEY, uid, 7);
        }
    }
    private function grabUID(storeType: PersistanceMethod):Void
    {
        if(storeType == PersistanceMethod.LocalStorage)
        {
            var store = Browser.getLocalStorage();
            if(store != null)
            {
               return store.get(KEY);
            }
            return null;
        }
        else if(storeType == PersistanceMethod.Cookie)
        {
            return Cookie.get(KEY);
        }
        return null;
    }
}