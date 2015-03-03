//
//  Capabilities.java
//
//  Created by kgar.
//  Copyright (c) 2015 Gameduell Inc. All rights reserved.
//

package org.haxe.duell.capabilities;

public class Capabilities
{
    private static final String TAG = Capabilities.class.getSimpleName();
    private org.haxe.duell.hxjni.HaxeObject haxeObject;
    private org.haxe.duell.capabilities.events.CentralHaxeDispatcher dispatcher;

    public static Capabilities create(org.haxe.duell.hxjni.HaxeObject object)
    {
        return new Capabilities(object);
    }

    private Capabilities(org.haxe.duell.hxjni.HaxeObject object)
    {
        haxeObject = object;
        dispatcher = new org.haxe.duell.capabilities.events.CentralHaxeDispatcher(haxeObject);
    }

    public String getDeviceName()
    {
        return android.os.Build.MODEL;
    }

    public String getDeviceID()
    {
        String m_szDevIDShort = "35" + (Build.BOARD.length() % 10) + (Build.BRAND.length() % 10) +
                                (Build.CPU_ABI.length() % 10) + (Build.DEVICE.length() % 10) +
                                (Build.MANUFACTURER.length() % 10) + (Build.MODEL.length() % 10) +
                                (Build.PRODUCT.length() % 10);
        String serial = null;
        try
        {
            serial = android.os.Build.class.getField("SERIAL").get(null).toString();

            // Go ahead and return the serial for api => 9
            return new UUID(m_szDevIDShort.hashCode(), serial.hashCode()).toString();
        }
        catch (Exception exception)
        {
            // String needs to be initialized
            serial = "serial"; // some value
        }

        return new UUID(m_szDevIDShort.hashCode(), serial.hashCode()).toString();
    }
}
