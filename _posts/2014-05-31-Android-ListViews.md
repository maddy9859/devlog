---
layout: post
categories: [android, programming]
title: Android Listview Best Practices
keywords: android, programming, user-interface
summary: Tips, tricks and best practices when implementing ListView control on Android.
author: jaydeepw
---


Android [ListViews](http://developer.android.com/reference/android/widget/ListView.html), so far, are the most efficient and smart, yet quite complex view controls in Android. Every now and then we come across using them in our Android apps. Recently Android team at Changer is working on a project that involves using many such listviews. Let me present our learning about implementation of listviews on Android.

1. #### `position` variable refers to index in backing array or arraylist
    The position variable that we receive in callbacks or other methods refers to the index in the array that backs the list. This implies that the position variable in following
    methods does not bear any relation to the index of listitems currently displayed in the UI. Simply put, position variable is from the perspective of Adapter.

    For instance, the position variable in the following methods refers to the index in the array or the data structure backing the
    list Adapter.
    
    ```java
    public View getView( int position, View convertView, ViewGroup parent ) {

    }

    mAdapter.getItem(position);

    mListView.getFirstVisiblePosition();

    mListView.getSelectedItemPosition();
    ```
2. #### 'index' variable refers to index in the visible list view items
    'index' is a variable from perspective of the listview items that are being displayed in the UI. 

    For instance, the index variable in the following methods refers to the index in the visible items in the listview.
    
    ```java
    mListView.getChildAt(index);

    mListView.indexOfChild(child);
    ```
3. #### No matter what, make use 'convertView'
    In the 'getView()' callback shown below

    ```java
    public View getView( int position, View convertView, ViewGroup parent ) {

    }
    ```
    convertView is the recycled view object that has been scrolled out of the screen and is given back to the adapter to re-use. 
    Many times the developers fail to understand its importance and recreate the views even when not required. The best practice here is
    to always check if the convertView is valid(not-null) yet and if it is, inflate a view from your XML layout file. 
4. #### Dont take 'getView()' callback for granted

    It is advocated by Google Android Developers Relations team that the getView() callback is not gauranteed to fire everytime it is expected.
    There are a lot of smart things being done internally in the listview for performance reasons which does not gaurantee getView being called.
    So do not make any assumptions about getView() callback.
5. #### Use ViewHolder pattern for faster rendering of ListViews

    Back in the days when Android ListViews were being tested on HTC G1, the first ever Android smartphone, the ListView had performance issues.
    Using something like ViewHolder in the Adapter was an easy way to address performance issue. The following code explains what I am trying to say.
    
    ```java
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
    ```
    Using ViewHolder ensures that memory allocated to the Views is only as much as required to show up
    the list items that will just fill up the screen.
6. #### List items not clickable

    As experienced programmers among us might already be knowing the issue with having a TextView or EditText in the view heirarchy of the list item. As mentioned [here](https://code.google.com/p/android/issues/detail?id=3414) for some sane reasons the list item is not clickable if its view heirarchy has TextView or EditText views. But Android provides an API for making this work.

    Refer [this](https://code.google.com/p/android/issues/detail?id=3414#c27) comment for more details.

    You can use the following API provided by ListView to fix the issue with TextView and EditText views.

    ```java

    ListView.setDescendantFocusability(FOCUS_BLOCK_DESCENDANTS);
    ```

    Alternatively, you can declare following attribute for the rootview of the list item layout XML.

    ```xml

    android:descendantFocusability="blocksDescendants"
    ```
7. #### Avoid heavy-lifting work in `getView()` callback

    `getView()` creates a view object and returns it back to the listview to display. This operation is synchronous to the main thread of the application. It is not recommented and generally considered as bad practice to
    
    * look up views using `findViewById()` unless really required.
    * do database, network or disk IO. For instance downloading the image or storing the image.
    * inflate views unnecessarily.