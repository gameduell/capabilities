/*
 *
 * @author kgar
 * copyright (c) 2015 Gameduell GmbH
 */
import capabilities.DeviceOrientation;
import capabilities.Platform;
import capabilities.BuildInfo;
import capabilities.Capabilities;

class CapabilitiesTest extends unittest.TestCase
{
	public function testBuildInfo(): Void
	{
        assertAsyncStart("testBuildInfo");

        Capabilities.initialize(function(): Void
        {
            var buildInfo: BuildInfo = Capabilities.instance().buildInfo;

            assertTrue(buildInfo != null);

            assertEquals(buildInfo.APPLICATION_NAME,"Capabilities App");
            assertEquals(buildInfo.APPLICATION_BUNDLE, "com.gameduell.tests.capabilities");
            assertEquals(buildInfo.COMPANY_NAME, "GameDuell GmbH");
            assertEquals(buildInfo.APPLICATION_VERSION, "0.0.1");

            assertAsyncFinish("testBuildInfo");
        });
	}

	public function testPlatform(): Void
	{
        assertAsyncStart("testPlatform");

        Capabilities.initialize(function(): Void
        {
        #if flash
            assertEquals(Capabilities.instance().platform, Platform.FLASH);
        #elseif ios
            assertEquals(Capabilities.instance().platform, Platform.IOS);
        #elseif android
            assertEquals(Capabilities.instance().platform, Platform.ANDROID);
        #elseif html5
            assertEquals(Capabilities.instance().platform, Platform.HTML5);
        #end

            assertAsyncFinish("testPlatform");
        });
	}

    public function testDeviceID(): Void
    {
        assertAsyncStart("testDeviceID");

        Capabilities.initialize(function(): Void
        {
            assertTrue(Capabilities.instance().deviceID != null);

            assertAsyncFinish("testDeviceID");
        });
    }

    public function testDeviceName(): Void
    {
        assertAsyncStart("testDeviceName");

        Capabilities.initialize(function(): Void
        {
            assertTrue(Capabilities.instance().deviceName != null);

            assertAsyncFinish("testDeviceName");
        });
    }

	public function testDeviceOrientation(): Void
	{
        assertAsyncStart("testDeviceOrientation");

        Capabilities.initialize(function(): Void
        {
            assertTrue(Capabilities.instance().deviceOrientation != null);

            assertAsyncFinish("testDeviceOrientation");
        });
	}
}