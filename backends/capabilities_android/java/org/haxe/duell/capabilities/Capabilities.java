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

package org.haxe.duell.capabilities;

import android.app.ActivityManager;
import android.app.ActivityManager.MemoryInfo;
import android.content.Context;
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

import java.io.File;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Locale;
import java.lang.Process;
import android.util.Log;

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

    public static double getTotalMemory()
    {
        MemoryInfo mi = new MemoryInfo();
        ActivityManager activityManager = (ActivityManager) DuellActivity.getInstance().getSystemService(Context.ACTIVITY_SERVICE);
        activityManager.getMemoryInfo(mi);

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN)
        {
            return mi.totalMem;
        }
        else
        {
            return 0;
        }
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
    public static String getDeviceModel()
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

    public static boolean isRootedDevice()
    {
        return (hasBuildTag() || hasInvalidPaths() || hasSuPermission());
    }

    private static boolean hasBuildTag()
    {
        String buildTags = android.os.Build.TAGS;

        return buildTags != null && buildTags.contains("test-keys");
    }

    private static boolean hasInvalidPaths()
    {
        String[] paths = { "/system/app/Superuser.apk",
                "/sbin/su",
                "/system/bin/su",
                "/system/xbin/su",
                "/data/local/xbin/su",
                "/data/local/bin/su",
                "/system/sd/xbin/su",
                "/system/bin/failsafe/su",
                "/data/local/su" };

        for (String path : paths)
        {
            if (new File(path).exists())
            {
                return true;
            }
        }

        return false;
    }

    private static boolean hasSuPermission()
    {
        Process process = null;

        try
        {
            process = Runtime.getRuntime().exec(new String[] { "/system/xbin/which", "su" });
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));

            if (in.readLine() != null)
            {
                return true;
            }
            return false;

        }
        catch (Throwable t)
        {
            return false;
        }
        finally
        {
            if (process != null)
            {
                process.destroy();
            }
        }

    }
}
