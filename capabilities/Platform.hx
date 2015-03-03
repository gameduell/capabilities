/**
 * @author kgar
 * @date  16/01/15 
 * Copyright (c) 2014 GameDuell GmbH
 */
package capabilities;

typedef OS =
{
    name: String,
    version: String,
    fullName: String
}

enum Platform
{
    HTML5;
    FLASH;
    IOS;
    ANDROID;
}