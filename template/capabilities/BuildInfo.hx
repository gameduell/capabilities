/**
 * @author kgar
 * @date  19/01/15 
 * Copyright (c) 2014 GameDuell GmbH
 */
package capabilities;
class BuildInfo
{
    private static var psInstance: BuildInfo;

    public  var APPLICATION_NAME: String = "::LIBRARY.CAPABILITIES.APPLICATION_NAME::";
    public  var APPLICATION_BUNDLE: String = "::LIBRARY.CAPABILITIES.APPLICATION_BUNDLE::";
    public  var COMPANY_NAME: String = "::LIBRARY.CAPABILITIES.COMPANY_NAME::";
    public  var APPLICATION_VERSION: String = "::LIBRARY.CAPABILITIES.APPLICATION_VERSION::";
    public  var APPLICATION_BUILD_NUMBER: String = "::LIBRARY.CAPABILITIES.APPLICATION_BUILD_NUMBER::";
    //public  var HAXE_COMPILE_ARGS: Array<String> = ::LIBRARY.CAPABILITIES.HAXE_COMPILE_ARGS::;
    //public  var DEPENDENCIES: String = "::LIBRARY.CAPABILITIES.DEPENDENCIES::";

    private  function new()
    {
    }

    public static function getInstance(): BuildInfo
    {
        if(psInstance == null)
        {
            psInstance =  new BuildInfo();
        }
        return psInstance;
    }
}
