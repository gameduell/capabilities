/**
 * @author kgar
 * @date  16/01/15 
 * Copyright (c) 2014 GameDuell GmbH
 */
package duell.build.plugin.library.capabilities;

import duell.build.objects.Configuration;

import duell.objects.DuellLib;
import duell.helpers.TemplateHelper;

class LibraryBuild
{
    public function new ()
    {
    }

    public function postParse() : Void
    {
        /// if no parsing is made we need to add the default state.
        if (Configuration.getData().LIBRARY.CAPABILITIES == null)
        {
            Configuration.getData().LIBRARY.CAPABILITIES = LibraryConfiguration.getData();
        }

        var haxeExtraSources = Path.join([Configuration.getData().OUTPUT,"haxe"]);

        if (Configuration.getData().SOURCES.indexOf(haxeExtraSources) == -1)
        {
            Configuration.getData().SOURCES.push(haxeExtraSources);
        }
    }

    public function preBuild() : Void
    {
        var libPath : String = DuellLib.getDuellLib("capabilities").getPath();

        var exportPath : String = Path.join([Configuration.getData().OUTPUT,"haxe","capabilities"]);

        var classSourcePath : String = Path.join([libPath,"template","capabilities"]);

        TemplateHelper.recursiveCopyTemplatedFiles(classSourcePath, exportPath, Configuration.getData(), Configuration.getData().TEMPLATE_FUNCTIONS);
    }

    public function postBuild() : Void
    {
    }
}
