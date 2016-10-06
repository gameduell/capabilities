package org.haxe.duell.capabilities;

import android.content.Context;
import android.os.Environment;
import android.util.Log;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.lang.ref.WeakReference;
import java.util.List;

public final class FileUtils {
    public static final Object DATA_LOCK = new Object();
    private static final String TAG = FileUtils.class.getSimpleName();
    private static String cacheFolder = "capabilities";
    private static WeakReference<Context> context = new WeakReference(null);

    private FileUtils() {
    }

    public static void setContext(Context ctx) {
        context = new WeakReference(ctx);
    }

    public static void setCacheFolderName(String cacheFolderName) {
        cacheFolder = cacheFolderName;
    }

    public static boolean isExternalMediaAvailable(boolean needsWritePermissions) {
        String state = Environment.getExternalStorageState();
        if ("mounted".equals(state)) {
            return true;
        }
        if (!"mounted_ro".equals(state)) {
            return false;
        }
        if (needsWritePermissions) {
            return false;
        }
        return true;
    }

    public static void writeToExternalFile(File root, String filename, String data) {
        if (isExternalMediaAvailable(true)) {
            try {
                writeToFile(new FileOutputStream(new File(root, filename)), data);
                return;
            } catch (IOException e) {
                Log.e(TAG, "Problem writing storage key to external media: " + e.getMessage());
                return;
            }
        }
        Log.e(TAG, "External media not available for writing.");
    }

    public static void writeToExternalFile(File root, String filename, InputStream data) {
        if (isExternalMediaAvailable(true)) {
            try {
                writeToFile(new FileOutputStream(new File(root, filename)), data);
                return;
            } catch (IOException e) {
                Log.e(TAG, "Problem writing storage key to external media: " + e.getMessage());
                return;
            }
        }
        Log.e(TAG, "External media not available for writing.");
    }

    public static void writeToExternalFileRoot(String filename, String data) {
        writeToExternalFile(Environment.getExternalStorageDirectory(), filename, data);
    }

    public static String readFromExternalFile(File root, String filename) {
        if (isExternalMediaAvailable(false)) {
            try {
                return readFromFile(new FileInputStream(new File(root, filename)));
            } catch (IOException e) {
            }
        } else {
            Log.e(TAG, "External media not available for reading.");
        }

        return null;
    }

    public static String readFromExternalFileRoot(String filename) {
        return readFromExternalFile(Environment.getExternalStorageDirectory(), filename);
    }

    public static InputStream readStreamFromExternalFileCache(String folder, String filename) {
        if (isExternalMediaAvailable(false)) {
            try {
                return new FileInputStream(new File(new File(new File(Environment.getExternalStorageDirectory(), cacheFolder), folder), filename));
            } catch (IOException e) {
            }
        } else {
            Log.e(TAG, "External media not available for reading.");
        }

        return null;
    }

    public static void writeToInternalFile(String filename, String data) {
        try {
            Context ctx = (Context) context.get();
            if (ctx != null) {
                writeToFile(ctx.openFileOutput(filename, 0), data);
            }
        } catch (IOException e) {
            Log.e(TAG, "Problem writing storage key to file: " + e.getMessage());
        }
    }

    public static String readFromInternalFile(String filename) {
        try {
            Context ctx = (Context) context.get();
            if (ctx != null) {
                return readFromFile(ctx.openFileInput(filename));
            }
        } catch (IOException e) {
        }
        return null;
    }

    public static void writeToFile(OutputStream os, String data) throws IOException {
        synchronized (DATA_LOCK) {
            OutputStreamWriter outputStreamWriter = new OutputStreamWriter(os);
            outputStreamWriter.write(data);
            outputStreamWriter.close();
        }
    }

    public static void writeToFile(OutputStream os, InputStream stream) throws IOException {
        byte[] buffer = new byte[8192];
        synchronized (DATA_LOCK) {
            while (true) {
                int bytesRead = stream.read(buffer);
                if (bytesRead != -1) {
                    os.write(buffer, 0, bytesRead);
                } else {
                    os.close();
                }
            }
        }
    }

    public static String readFromFile(InputStream is) throws IOException {
        StringBuilder stringBuilder = new StringBuilder();
        synchronized (DATA_LOCK) {
            if (is != null) {
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(is));
                while (true) {
                    String line = bufferedReader.readLine();
                    if (line == null) {
                        break;
                    }
                    stringBuilder.append(line);
                }
                is.close();
            }
        }
        return stringBuilder.toString();
    }

    public static synchronized File createExternalCacheFolder(String folder) {
        File cacheSubfolder;
        synchronized (FileUtils.class) {
            if (isExternalMediaAvailable(true)) {
                cacheSubfolder = new File(new File(Environment.getExternalStorageDirectory(), cacheFolder), folder);
                cacheSubfolder.mkdirs();
            } else {
                cacheSubfolder = null;
            }
        }
        return cacheSubfolder;
    }

    public static synchronized void deleteExternalCacheFiles(List<String> files) {
        synchronized (FileUtils.class) {
            if (isExternalMediaAvailable(true)) {
                File rootCacheFolder = new File(Environment.getExternalStorageDirectory(), cacheFolder);
                if (rootCacheFolder.exists()) {
                    for (String fileToDelete : files) {
                        File filePath = new File(rootCacheFolder, fileToDelete);
                        if (filePath.canWrite() && filePath.exists()) {
                            if (filePath.isDirectory()) {
                                deleteFilesInFolder(filePath);
                            }
                            filePath.delete();
                        }
                    }
                }
            }
        }
    }

    public static synchronized void deleteExternalCacheFilesWithExceptions(List<String> exceptionFiles) {
        synchronized (FileUtils.class) {
            if (isExternalMediaAvailable(true)) {
                File rootCacheFolder = new File(Environment.getExternalStorageDirectory(), cacheFolder);
                if (rootCacheFolder.exists()) {
                    for (String existingFile : rootCacheFolder.list()) {
                        if (!exceptionFiles.contains(existingFile)) {
                            File filePath = new File(rootCacheFolder, existingFile);
                            if (filePath.canWrite() && filePath.exists()) {
                                if (filePath.isDirectory()) {
                                    deleteFilesInFolder(filePath);
                                }
                                filePath.delete();
                            }
                        }
                    }
                }
            }
        }
    }

    private static void deleteFilesInFolder(File folder) {
        for (String entry : folder.list()) {
            File currentFile = new File(folder, entry);
            if (currentFile.isDirectory()) {
                deleteFilesInFolder(currentFile);
            }
            currentFile.delete();
        }
    }

    public static boolean isExternalFileAvailableInCache(String folder, String fileName) {
        if (isExternalMediaAvailable(false)) {
            return new File(new File(new File(Environment.getExternalStorageDirectory(), cacheFolder), folder), fileName).exists();
        }
        return false;
    }
}
