/**
 * @author kgar
 * @date  16/01/15 
 * Copyright (c) 2014 GameDuell GmbH
 */
package duell.build.plugin.library.capabilities;
import haxe.xml.Fast;
import duell.build.objects.DuellProjectXML;
import duell.build.objects.Configuration;
class LibraryXMLParser
{
    public function new()
    {
    }
    public static function parse(xml: Fast): Void
    {
        Configuration.getData().LIBRARY.CAPABILITIES = LibraryConfiguration.getData();

        LibraryConfiguration.getData().APPLICATION_NAME = Configuration.getData().APP.TITLE;
        LibraryConfiguration.getData().APPLICATION_BUNDLE = Configuration.getData().APP.PACKAGE;
        LibraryConfiguration.getData().COMPANY_NAME = Configuration.getData().APP.COMPANY;
        LibraryConfiguration.getData().APPLICATION_VERSION = Configuration.getData().APP.COMPANY;
        LibraryConfiguration.getData().APPLICATION_BUILD_NUMBER = Configuration.getData().APP.BUILD_NUMBER;
        LibraryConfiguration.getData().HAXE_COMPILE_ARGS = Configuration.getData().HAXE_COMPILE_ARGS;
        LibraryConfiguration.getData().DEPENDENCIES = Configuration.getData().DEPENDENCIES;
    }

}
