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

            assertEquals(buildInfo.applicationName,"Capabilities App");
            assertEquals(buildInfo.applicationBundle, "com.gameduell.tests.capabilities");
            assertEquals(buildInfo.companyName, "GameDuell GmbH");
            assertEquals(buildInfo.applicationVersion, "0.0.1");

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