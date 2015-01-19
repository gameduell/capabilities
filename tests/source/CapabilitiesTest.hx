/*
 *
 * @author kgar
 * copyright (c) 2015 Gameduell GmbH
 */
import capabilities.Platform;
import capabilities.BuildInfo;
import capabilities.Capabilities;
class CapabilitiesTest extends unittest.TestCase
{
	public function testBuildInfo(): Void
	{
		var buildInfo: BuildInfo =  Capabilities.instance().buildInfo;
		assertTrue(buildInfo != null);
		assertEquals(buildInfo.APPLICATION_NAME,"Capabilities App");
		assertEquals(buildInfo.APPLICATION_BUNDLE, "com.gameduell.tests.capabilities");
		assertEquals(buildInfo.COMPANY_NAME, "GameDuell GmbH");
		assertEquals(buildInfo.APPLICATION_VERSION, "0.0.1");
	}

	public function testPlatform(): Void
	{
		#if flash
			assertEquals(Capabilities.instance().platform, Platform.FLASH);
		#end
	}
}