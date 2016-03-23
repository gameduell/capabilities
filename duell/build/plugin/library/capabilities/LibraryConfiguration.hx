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
 
package duell.build.plugin.library.capabilities;

typedef LibraryInfo =
{
    NAME: String,
    VERSION: String,
    COMMIT: String
}

typedef LibraryConfigurationData =
{
    HAXE_COMPILE_ARGS : Array<String>,

    DEPENDENCIES :
    {
        DUELLLIBS : Array<{name : String, version : String}>,
        HAXELIBS : Array<{name : String, version : String}>
    }
}

class LibraryConfiguration
{
    public static var _configuration: LibraryConfigurationData = null;
    private static var _parsingDefines: Array<String> = ["capabilities"];

    public static function getData(): LibraryConfigurationData
    {
        if (_configuration == null)
        {
            initConfig();
        }

        return _configuration;
    }

    public static function getConfigParsingDefines(): Array<String>
    {
        return _parsingDefines;
    }

    public static function addParsingDefine(str: String)
    {
        _parsingDefines.push(str);
    }

    private static function initConfig()
    {
        _configuration =
        {
            HAXE_COMPILE_ARGS : [],

            DEPENDENCIES :
            {
                DUELLLIBS : [],
                HAXELIBS : []
            }
        };
    }
}
