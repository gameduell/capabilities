package capabilities;

/**
 * @author kgar
 * @date  19/01/15
 * Copyright (c) 2014 GameDuell GmbH
 */
class BuildInfo
{
    private static var psInstance: BuildInfo;

    public var applicationName(default, never): String = "::APP.TITLE::";
    public var applicationBundle(default, never): String = "::APP.PACKAGE::";
    public var companyName(default, never): String = "::APP.COMPANY::";
    public var applicationVersion(default, never): String = "::APP.VERSION::";
    public var applicationBuildNumber(default, never): String = "::APP.BUILD_NUMBER::";

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
