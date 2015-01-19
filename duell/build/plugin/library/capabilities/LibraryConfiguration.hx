/**
 * @author kgar
 * @date  16/01/15 
 * Copyright (c) 2014 GameDuell GmbH
 */
package duell.build.plugin.library.capabilities;
typedef LibraryInfo = { NAME:String, VERSION:String, COMMIT:String}

typedef LibraryConfigurationData = {
    LIBRARIES: Array<LibraryInfo>,
    APPLICATION_NAME: String,
    APPLICATION_BUNDLE: String,
    APPLICATION_VERSION : String,
    APPLICATION_BUILD_NUMBER: String,
    COMPANY_NAME: String,
    HAXE_COMPILE_ARGS : Array<String>,

    DEPENDENCIES : {
    DUELLLIBS : Array<{name : String, version : String}>,
    HAXELIBS : Array<{name : String, version : String}>
    }
}
class LibraryConfiguration
{
    public static var _configuration : LibraryConfigurationData = null;
    private static var _parsingDefines : Array<String> = ["capabilities"];
    public static function getData() : LibraryConfigurationData
    {
        if (_configuration == null)
            initConfig();
        return _configuration;
    }

    public static function getConfigParsingDefines() : Array<String>
    {
        return _parsingDefines;
    }

    public static function addParsingDefine(str : String)
    {
        _parsingDefines.push(str);
    }

    private static function initConfig()
    {
        _configuration =
        {
            LIBRARIES: [],
            APPLICATION_NAME: "NONE",
            APPLICATION_BUNDLE: "NONE",
            APPLICATION_VERSION: "NONE",
            APPLICATION_BUILD_NUMBER: "NONE",
            COMPANY_NAME: "NONE",
            HAXE_COMPILE_ARGS : [],
            DEPENDENCIES : {
                DUELLLIBS : [],
                HAXELIBS : []
            }
        };
    }
}
