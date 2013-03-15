## Changer developers

Blog for developers


## Installation

Install jekyll and other gems using

```sh
$ gem install jekyll
$ ...
```

## Setup

```sh
$ make setup
```

## Usage

Start the server

```sh
$ make server
```

You should be on `master` branch when you are making changes or writing posts.

To make a new post just create a file inside `_posts`. For example `2013-01-20-localstorage-manager.md`

All the posts are written in markdown. Make sure all the posts have these at the beginning

```
---
layout: post
categories: [javascript, localstorage]
title: localStorage manager (lm.js)
keywords: javascript, localStorage
summary: localStorage manager (lm.js) - A simple wrapper around `localStorage` with which you can store, query and perform CRUD operations on collections and documents.
authorLink: http://madhums.me
author: Madhusudhan Srinivasa
---
```

Change the attributes as required.

To push/deploy changes

```sh
$ make deploy
```

Fork it and follow markdown or github style of documenting your stuff. Send PL's
