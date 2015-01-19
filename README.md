= Description =

The Capabilities Library provides properties that describe the system and runtime that are hosting the application.
= Release Log =

== 0.8.0 ==

- Added README FILE
- Added Library Plugin that collect all the buildInfo while building
- Added BuildInfo Class
- Capabilities class provide the following infos
    # applicationName of type String.
	# applicationVersion of type String.
	# os of type OS {name: String, fullName: String, version: String}.
	# isDebug of type Bool.
	# screenDPI of type Float.
	# resolutionX of type Int.
	# resolutionY of type Int.
	# deviceOrientation of type DeviceOrientation (typedef).
	# deviceName of type String, Maybe null in flash or html5.
	# deviceID of type String, Maybe null in flash or html5.
	# platform of type Platform (HTML5, ANDROID, IOS or FLASH).
	# buildInfo of type BuildInfo provides the info collecting in the build process.