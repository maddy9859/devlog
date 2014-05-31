---
layout: post
categories: [android, programming]
title: Android ListView Best Practices
keywords: android, programming, user-interface
summary: Tips, tricks and best practices when implementing ListView control on Android.
author: jaydeepw
---

* position refers to index in backing array or arraylist
* index refers to index in the listview children
* Use convertview for the greater good. Inflating views is costly
* Dont take getView() call for granted.
* User ViewHolder pattern. View look-ups are costly.    http://developer.android.com/training/improving-layouts/smooth-scrolling.html#ViewHolder
* Minimize heavylifting work in getView().
* http://developer.android.com/training/improving-layouts/smooth-scrolling.html
* ListView items not clickable issue. https://code.google.com/p/android/issues/detail?id=3414#c27


Android [ListViews](http://developer.android.com/reference/android/widget/ListView.html), so far, are the most efficient and smart yet quite complex view controls in android. Every now and then we come across using them in our Android apps. Recently Android team at Changer is working on a project that involves using many such listviews. Let me present our learning about implementation of listviews on Android.

## 'position' variable refers to index in backing array or arraylist

The position variable that we receive in callbacks or methods is refering to the index in the array that backs the list. This implies that the position variable in following
methods does not bear any relation to the index of listitems currently displayed in the UI. Position variable is from the perspective of Adapter

    public View getView( int position, View convertView, ViewGroup parent ) {

    }

    mAdapter.getItem(position);

    mListView.getFirstVisiblePosition();

    mListView.getSelectedItemPosition();

## 'index' variable refers to index in the visible list view items

'index' is a variable from perspective of the listview items that are being displayed in the UI. 

    mListView.getChildAt(index);

    mListView.indexOfChild(child);

## No matter what, use 'convertView'

In the 'getView()' callback show below

    public View getView( int position, View convertView, ViewGroup parent ) {

    }

convertView is the recycled view object that has been scrolled out of the screen and is given back to us to re-use. 
Many times the developers fail to understand its importance and recreate the views even when not required. The best practice here is
to always check if the convertView is valid(not-null) yet and if it is, inflate a view from your UI XML file. This can be explained better
by the 3 ways shown to implement the listviews on Android towards the end of this post.

## Dont take 'getView()' callback for granted

It is advocated by Google Android developers that the getView() callback is not gauranteed to fire everytime it is expected.
There are a lot of smart things being done internally in the listview for performance reasons which does not gaurantee getView being called.

## User ViewHolder pattern for faster rendering of ListViews

Back in the days when Android ListViews were being tested on HTC G1, the first ever Android smartphone, the ListView had performance issues.
Using something like ViewHolder in the Adapter was an easy way to address performance issue. The following code explains what I am trying to say.

    private static class ViewHolder {
        public TextView text;
        public ImageView image;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        View view = convertView;
        final ViewHolder holder;
        if (convertView == null) {
            view = getLayoutInflater().inflate(R.layout.item_list_image, parent, false);
            holder = new ViewHolder();
            holder.text = (TextView) view.findViewById(R.id.text);
            holder.image = (ImageView) view.findViewById(R.id.image);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
            // performance gain as findViewById() need not be called
        }

        holder.text.setText("Item " + (position + 1));

        return view;
    }

Using ViewHolder ensures that memory allocated to the Views is only as much as required to just show up
the list items that fill the screen. On a Nexus 4 device memory of about 7-8 views is allocated.


## Avoid heavylifting work in getView() callback

getView() creates a view object and returns is back to the listview to display. This is operation is synchronous to the main
thread of the application. It is not recommented and generally considered as bad practice to

* look up views using findViewById() unless really required.
* do database or network IO. For instance downloading the image.
* inflate views unnecessarily.




==============================

Yo mama so fat, we follow a great way of working. We reuse code as much as possible and leverage use of open source technologies. We also like to give back to the community by open sourcing our code. When we started out working on Android clients for our existing products, we decided to build an open source library. It has been a while we released the [Android Utilities library](https://github.com/jaydeepw/android-utils) out into the wild on Github. Please follow the "Getting Started" section below to integrate and use the library in your project.

Feel free to use, copy or contribute to our work.

## Getting started to use the library

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
