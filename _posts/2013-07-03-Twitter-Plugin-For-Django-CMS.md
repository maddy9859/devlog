---
layout: post
categories: [javascript, code-style]
title: Twitter Plugin for Django CMS
keywords: twitter, python, Django
summary: javascript styling guide I follow for node.js. Other style guide references
author: vinitcool76
---

Last week, we came across an issue. Twitter removed support for v1.0 of its REST API. As a result, all of the sites using django CMS's twitter plugin broke.This was a problem because we also used it in some of our sites. Since there was no fix available at that time, I decided to create a new plugin on the latest API. 

### Design

Twitter has a new option of generating widgets for your profile. These run as iframes injected in your site and it is quite customizable. There were a lot of field that could be manipulated by the user. So i take a look at those fields and decided to use those fields as options and choices in model of my plugin. So all user needed to do was to specify his username, widget-id, background-color and size of the plugin and it was injected in the placeholder where he wished it to be.

### Advantages

It works out of box and you don't have to get into setting up an app and dealing with access tokens and as a result server side flow. Twitter also has promised a good support with scaling as well. This means you can just set it up and forget.

In order to use this plugin:

```
$ pip install cmsplugin-twitter
```

Then you might want to do a syncdb and migrate your database. Once done with that just insert the plugin in your desired place in the template and it will just work.

You might wanaa check this out in actions. Here it is on one of our sites. 

*Also the plugin has been added in the Django CMS Official addons list. Here is the Addon [Link Page](https://www.django-cms.org/en/add-ons/?page=3)*

<img src="http://i.imgur.com/0hVltHs.png">