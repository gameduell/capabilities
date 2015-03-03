package capabilities;

/**
 * @author kgar
 * @date  19/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
class BuildInfo
{
    private static var psInstance: BuildInfo;

    public var APPLICATION_NAME(default, never): String = "::LIBRARY.CAPABILITIES.APPLICATION_NAME::";
    public var APPLICATION_BUNDLE(default, never): String = "::LIBRARY.CAPABILITIES.APPLICATION_BUNDLE::";
    public var COMPANY_NAME(default, never): String = "::LIBRARY.CAPABILITIES.COMPANY_NAME::";
    public var APPLICATION_VERSION(default, never): String = "::LIBRARY.CAPABILITIES.APPLICATION_VERSION::";
    public var APPLICATION_BUILD_NUMBER(default, never): String = "::LIBRARY.CAPABILITIES.APPLICATION_BUILD_NUMBER::";

    private function new()
    {}

    public static function instance(): BuildInfo
    {
        if (psInstance == null)
        {
            psInstance = new BuildInfo();
        }

        return psInstance;
    }
}
