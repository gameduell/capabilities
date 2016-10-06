package org.haxe.duell.capabilities;

import org.haxe.duell.DuellActivity;

import android.Manifest;
import android.app.Activity;
import android.app.Application;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

public final class DeviceUID
{
    // Storage Permissions
    private static final int REQUEST_EXTERNAL_STORAGE = 1;
    private static String[] PERMISSIONS_STORAGE = {
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
    };

    private static final String PREF_NAME = "cap_internal";
    private static final String UUID_KEY = "cap_id";

    private DeviceUID()
    {
        // can't be instantiated
    }

    public static String readIdFromStorage()
    {
        FileUtils.setContext(DuellActivity.getInstance());

        String id = FileUtils.readFromExternalFileRoot(UUID_KEY);

        if (id == null || id.isEmpty())
        {
            id = FileUtils.readFromInternalFile(UUID_KEY);
        }

        return id;
    }

    public static String readIdFromPreferences()
    {
        SharedPreferences prefs = DuellActivity.getInstance().getSharedPreferences(PREF_NAME, Application.MODE_PRIVATE);
        return prefs.getString(UUID_KEY, null);
    }

    public static void saveId(String id)
    {
        verifyStoragePermissions(DuellActivity.getInstance());

        FileUtils.setContext(DuellActivity.getInstance());

        SharedPreferences prefs = DuellActivity.getInstance().getSharedPreferences(PREF_NAME, Application.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(UUID_KEY, id);
        editor.commit();

        FileUtils.writeToExternalFileRoot(UUID_KEY, id);
        FileUtils.writeToInternalFile(UUID_KEY, id);
    }

    private static void verifyStoragePermissions(Activity activity) {
        if (ContextCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            // We don't have permission so prompt the user
            ActivityCompat.requestPermissions(activity, PERMISSIONS_STORAGE, REQUEST_EXTERNAL_STORAGE);
        }
    }
}
