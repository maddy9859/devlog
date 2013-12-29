---
layout: post
categories: [LESS, CSS, Chrome DevTools]
title: Grunt-cssrazor, How It Helped Us create Leaner CSS Files.
keywords: grunt, css, tools.
summary: Produces cleaned CSS based on actually used DOM
author: vinitkumar
---

At Changer, we are very passionate about our products and toolings.
Naturally we spend quite some time optimizing our apps
and tools. If you have done performance Audits for your App/Websites in Chrome
Devtools or similar applications you must have noticed it always
complains about the usused CSS rules.

Well this is annoying because of two reasons: 
- It consumes your bandwidth during network transfer and delays the
rendering of the webpage.
- There isn't much tooling available to solve this issue and with more use
of CSS frameworks like Bootstrap/Foundation this problem just
multiplies.

In order to solve that Issue, Ruben started working on a Grunt task
runner that basically takes your css file, crawl up your webpage url and
then filter the css rules that are present in that webpage.It uses
phantomjs to simulate the browsers interaction. In short, it produces
cleaned CSS based on actually used DOM.

For those of you who aren't aware about grunt, [Grunt](http://gruntjs.com/) is essentially a node based
taskrunner similar to Makefiles, plus you get
the support of all sweet modules in npm , is cross platform and you write it in JavaScript.
It is almost a must have in all the JavaScript based projects these days.

Here is a small demo about usage of our tool:

## Installation

In order to install, make sure you have node and npm install. The, do
the following steps:

```bash
$ npm install grunt-cli
$ npm install --save grunt-cssrazor
```

Write a gruntfile.js file in your project directory which looks
something similar to this:

```js
/*
 * grunt-cssrazor
 * https://github.com/changer/grunt-cssrazor
 *
 * Copyright (c) 2013 Changer
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {


  grunt.loadNpmTasks('grunt-contrib-cssmin');

  // Project configuration.
  grunt.initConfig({
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },

      gruntfile: 'Gruntfile.js',
      tasks: 'tasks/*.js',
      tests: '<%= nodeunit.tasks %>'
    },

    // Before generating any new files, remove any previously-created files.
    clean: {
      test: ['tmp']
    },

    cssmin: {
      release: {
        options: {
          keepSpecialComments: 0
        },
        files: {
          'release.css': ['release.css']
        },
      }
    },

    // Configuration to be run (and then tested).
    cssrazor: {
      release: {
        options: {
          urls: [  // Below are the list of urls in your
application/page
            'http://www.changer.nl/',
            'http://www.changer.nl/team.html',
            'http://www.changer.nl/products.html',
            'http://www.changer.nl/contact.html',
            'http://www.changer.nl/portfolio.html',
            'http://www.changer.nl/legal/'
          ],
          input: 'app.css', // this is the css file for your app
          output: 'release.css' // this is generated css files
        }
      }
    },

    // Unit tests.
    nodeunit: {
      tasks: ['test/*_test.js']
    }
  });

  // Load this plugin's task(s).
  grunt.loadTasks('tasks');

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');


  // Whenever the "test" task is run, first clean the "tmp" dir, then run this
  // plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'cssrazor', 'cssmin', 'nodeunit']);

  // By default, lint and run all tests.
  grunt.registerTask('default', ['jshint', 'test']);
};
```
After saving the file, run `grunt cssrazor`.

This would give you file name as 'release.css' or whatever you set in
the gruntfile.js.

Also, you would get a measure of how much thinner your new generated css
file is. It would look something like this.

```bash
λ ~/projects/javascript/grunt-cssrazor/ master* grunt cssrazor
Running "cssrazor:release" (cssrazor) task
Reduced your CSS by roughly 35%!

Done, without errors.
```
 
Voila and both of the above mentioned problems are solved and you have a
smaller css file and snappier website.

For contributing to the project, you could always go to the Github repo
for [grunt-cssrazor](https://github.com/changer/grunt-cssrazor).
