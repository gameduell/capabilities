//
//  Capabilities.java
//
//  Created by kgar.
//  Copyright (c) 2015 Gameduell Inc. All rights reserved.
//

package org.haxe.duell.capabilities;

import android.annotation.TargetApi;
import android.content.res.Configuration;
import android.os.Build;
import android.provider.Settings;
import android.util.DisplayMetrics;
import org.haxe.duell.DuellActivity;
import org.haxe.duell.hxjni.HaxeObject;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;

import java.io.IOException;
import java.util.Locale;

@TargetApi(Build.VERSION_CODES.GINGERBREAD)
public final class Capabilities
{
    private Capabilities()
    {
        // can't be instantiated
    }

    public static int getResolutionX()
    {
        DisplayMetrics metrics = DuellActivity.getInstance().getResources().getDisplayMetrics();
        return metrics.widthPixels;
    }

    public static int getResolutionY()
    {
        DisplayMetrics metrics = DuellActivity.getInstance().getResources().getDisplayMetrics();
        return metrics.heightPixels;
    }

    public static double getDensity()
    {
        DisplayMetrics metrics = DuellActivity.getInstance().getResources().getDisplayMetrics();
        return metrics.density;
    }

    public static boolean isLandscape()
    {
        return DuellActivity.getInstance().getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE;
    }

    public static boolean isPhone()
    {
        int screenLayout = DuellActivity.getInstance().getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK;

        // if the layout is small or normal, it's a phone. tablet otherwise
        switch (screenLayout)
        {
            case Configuration.SCREENLAYOUT_SIZE_SMALL:
            case Configuration.SCREENLAYOUT_SIZE_NORMAL:
                return true;

            default:
                return false;
        }
    }

    public static void retrieveAdvertisementId(final HaxeObject haxeObject)
    {
        new Thread(new Runnable()
        {
            @Override
            public void run()
            {
                String id = getAndroidId();

                try
                {
                    AdvertisingIdClient.Info adInfo = AdvertisingIdClient.getAdvertisingIdInfo(DuellActivity.getInstance());
                    id = adInfo.getId();
                }
                catch (IOException e) {}
                catch (GooglePlayServicesNotAvailableException e) {}
                catch (GooglePlayServicesRepairableException e) {}
                catch (NullPointerException e) {}

                haxeObject.call1("onDataReceived", id);
            }
        }).start();
    }

    private static String getAndroidId()
    {
        return Settings.Secure.getString(DuellActivity.getInstance().getContentResolver(), Settings.Secure.ANDROID_ID);
    }

    public static String getSerial()
    {
        return Build.SERIAL;
    }

    /**
     * Retrieves the Android system version, under the RELEASE flag.
     *
     * @return the user-visible Android system version name
     */
    public static String getSystemVersion()
    {
        return Build.VERSION.RELEASE;
    }

    /**
     * Retrieves the device name, with manufacturer and model.
     *
     * @return the pretty-print of the device name
     */
    public static String getDeviceName()
    {
        String manufacturer = Build.MANUFACTURER;
        String model = Build.MODEL;

        if (model.startsWith(manufacturer))
        {
            return capitalize(model);
        }
        else
        {
            return String.format("%s %s", capitalize(manufacturer), model);
        }
    }

    public static String getPreferredLanguage()
    {
        return Locale.getDefault().getLanguage();
    }

    private static String capitalize(final String s)
    {
        if (s == null || s.length() == 0)
        {
            return "";
        }

        char first = s.charAt(0);

        if (Character.isUpperCase(first))
        {
            return s;
        }
        else
        {
            return Character.toUpperCase(first) + s.substring(1);
        }
    }
}
