---
layout: post
categories: [javascript, code-style]
title: Twitter Plugin for Django CMS
keywords: twitter, python, Django
summary: javascript styling guide I follow for node.js. Other style guide references
author: vinitcool76
---

Last week, We came across an issue that Twitter removed support for v1.0 of its REST API. As a result, all sites using Django CMS twitter plugin had no longer access to twitter stream.It was a problem because we used it in couple of our sites. Since there was no fix available at that time, we decided to come up with a new plugin.

### Design

Twitter has an option to generate timeline widgets for user's profile which run as iframes injected. These widgets are customizable and has some fields which could be be changed to modify look and feel of widgets.

So we decided to use those fields in plugin's model. 

You could browse the code in our repo [here](https://github.com/changer/cmsplugin-twitter).

In order to use this plugin, do:

```
$ pip install cmsplugin-twitter
$ python manage.py syncdb
$ python manage.py migrate
```
Once installed, you need to fill out username, widget-id, height, width in the plugin form. Fill those fields and save it. It will just work.

### Benefits

This is from Twitter developers blog. 
> Embedded timelines are not subject to traditional Twitter API rate limits, and are designed to scale with your site as your traffic and audience grows.


The plugin is also added in the Django CMS Official add-ons site. [Link Page](https://www.django-cms.org/en/add-ons/?page=3)
