= Description =

The Capabilities Library provides properties that describe the system and runtime that are hosting the application.


= Release Log =

== 6.0.0 ==

- updated to the latest android build plugin

== 4.1.0 ==

- Added device model
- DCE compatibility

== 4.1.0 ==

- Added device model
- DCE compatibility

== 1.0.0 ==

- Changed the API to require the use of an initialize() method before accessing the instance
- Removed screenDPI feature
- Added advertisingIdentifier
- Added deviceType (enum)
- Added preferredLanguage

== 0.8.0 ==

- Added README FILE
- Added Library Plugin that collect all the buildInfo while building
- Added BuildInfo Class
- Capabilities class provide the following infos
-- applicationName of type String.
-- applicationVersion of type String.
-- os of type OS {name: String, fullName: String, version: String}.
-- isDebug of type Bool.
-- screenDPI of type Float.
-- resolutionX of type Int.
-- resolutionY of type Int.
-- deviceOrientation of type DeviceOrientation (enum).
-- deviceName of type String, Maybe null in flash or html5.
-- deviceID of type String, Maybe null in flash or html5.
-- platform of type Platform (HTML5, ANDROID, IOS or FLASH).
-- buildInfo of type BuildInfo provides the info collecting in the build process.
