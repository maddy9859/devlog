---
layout: post
categories: [android, programming]
title: Android Utilities
keywords: android, programming
summary: A word about recently released Android Utilities library.
author: jaydeepw
---

At Changer, we follow a great way of working. We reuse code as much as possible and leverage use of open source technologies. We also like to give back to the community by open sourcing our code. When we started out working on Android clients for our existing products, we decided to build an open source library. It has been a while we released the [Android Utilities library](https://github.com/jaydeepw/android-utils) out into the wild on Github. Please follow the "Getting Started" section below to integrate and use the library in your project.

Feel free to use, copy or contribute to our work.

----

Getting started to use the library
=============

**Step 1**: Download the zip file of this project and unzip it.

**Step 2**: Import the project into your eclipse Android development enviornment. 

If you dont know how to import a project, follow the instructions at the link given below.
http://help.eclipse.org/helios/index.jsp?topic=%2Forg.eclipse.platform.doc.user%2Ftasks%2Ftasks-importproject.htm

**Step 3**: Link this library project with your project from Properties -> Android -> Library -> Add

If you are not familiar with this, here you have to link the project imported in Step 1 with your own application.
You can follow the link below to understand how you link a particular project with this library project.
http://www.vogella.com/articles/AndroidLibraryProjects/article.html#tutorial_library_usage

And there you are good to go with the project.

----

Helper method available in the library
=============

```java

  // Check availablility of internet connection on the device.
  Toast toast = showToast( activityContext, msgToShow );

```