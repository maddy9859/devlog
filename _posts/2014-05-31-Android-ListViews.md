---
layout: post
categories: [android, programming]
title: Android ListViews
keywords: android, programming, user-interface
summary: Tips, tricks and best practices when implementing ListView control on Android.
author: jaydeepw
---

1. position refers to index in backing array or arraylist
2. index refers to index in the listview children
3. Dont take getView() call for granted.
4. Use convertview for the greater good.

Yo mama so fat, we follow a great way of working. We reuse code as much as possible and leverage use of open source technologies. We also like to give back to the community by open sourcing our code. When we started out working on Android clients for our existing products, we decided to build an open source library. It has been a while we released the [Android Utilities library](https://github.com/jaydeepw/android-utils) out into the wild on Github. Please follow the "Getting Started" section below to integrate and use the library in your project.

Feel free to use, copy or contribute to our work.

### Getting started to use the library


1. Fork / Clone the repo or download the zip file of this project and unzip it.

2. Import the project into your eclipse Android development enviornment. If you dont know how to import a project, follow the instructions [here](http://help.eclipse.org/helios/index.jsp?topic=%2Forg.eclipse.platform.doc.user%2Ftasks%2Ftasks-importproject.htm)

3. Link this library project with your project from Properties -> Android -> Library -> Add. If you are not familiar with this, here you have to link the project imported in Step 2 with your own application.
You can follow this [link](http://www.vogella.com/articles/AndroidLibraryProjects/article.html#tutorial_library_usage) below to understand how you link a particular project with this library project.


### Helper methods available in the library


**Utils.java**

```java

    // Show a toast message in the UI
    Toast toast = showToast( activityContext, msgToShow );
  
    // Check availablility of internet connection on the device.
    boolean isAvailable = isInternetAvailable(context);
  
    // Check if the SD card on the device is mounted
    boolean isMounted = isSDCARDMounted();
    
    // Show an alert dialog with the OK button.
    showAlertDialog(context, msgTitle, msgBody);
    
    // Convert an image to Base64 string
    String base64Image = toBase64(bitmap);
    
    // Convert a drawable to a Bitmap
    Bitmap bitmap = drawableToBitmap( Drawable drawable );
    
    // Convert the given bitmap to InputStream
    InputStream is = bitmapToInputStream(bitmap);
    
    // Read input stream
    String str = readStream( inputStream );

    // Scale down bitmap by height
    Bitmap bmp = scaleDownBitmap( context, bitmap, newHeight );
    
    // Get the device screen density multiplier
    float densityMultiplier = getDensityMultiplier(context);
    
    // Show Yes/No confirmation dialog
    showConfirmDialog( context, message, yesListener, noListener );
    
    // Get application version number
    String appVersion = getApplicationVersionNumber( context );
    
    // Get application version code
    int appVersion = getApplicationVersionCode( context );
    
    // Get OS version
    String osVersion = getOSVersion();
    
    // Check if the service with the given name is running
    boolean isRunning = isServiceRunning( context, serviceName );
    
    // Get the IMEI of the device
    String imeiStr = getDeviceImei( context );
    
    // Show a social sharing modal in the application
    share( context, sharingMsg, emailSubject, title );
    
    // Get internet connection type
    int type = getDataConnectionType( context );
  
    // Check if the entered email id is valid
    boolean isValid = isValidEmail( email );
  
    // Capitalize the string
    String allCaps = capitalizeString( String string )
    
    // Set the backgroud drawable for a view
    setBackground(view, drawable);
    
    // Check if the database with a given name is present on the device
    boolean isPresent = isDatabasePresent( packageName, DBName );
    
    // Convert JSONArray to ArrayList<String>
    ArrayList<String> list = toStringArray( jsonArr );
    
    // Convert ArrayList<String> to JSONArray
    JSONArray arr = toJSONArray(stringArr);
    
    // Write an image onto the device or SD Card and get the path
    String filePath = writeImage( imageData );
    
    // Get the name of the current application
    String appName = getApplicationName();
    
    // Convert ISO String to Calendar
    Calendar cal = toCalendar( iso8601string );
    
    // Get elapsed time from ISO formatted time
    String elapsedTime = getElapsedTime( ISOTime );
  
```

**NetworkManager.java**

```java

    // Read the input stream to bytes
    byte[] bytes = readStreamToBytes(inputStream);
    
    // Read input stream
    String str = readStream( inputStream ); 
    
    // Make a HTTP GET request
    executeHttpGet( httpURLConnection );
    
    // Make a HTTP GET request with standard Content-Type header
    executeHttpGet( httpURLConnection, mimeType );

    // Make a HTTP POST request
    executeHttpPost( httpURLConnection );
    
    // Make a HTTP GET request with standard Content-Type header
    executeHttpPost( httpURLConnection, mimeType );
    
    // Make a HTTP PUT request
    executeHttpPut( httpURLConnection );
    
    // Make a HTTP PUT request with standard Content-Type header
    executeHttpPut( httpURLConnection, mimeType )
    
```
