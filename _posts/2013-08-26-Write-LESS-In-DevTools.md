---
layout: post
categories: [LESS, CSS, Chrome DevTools]
title: Write And Edit Less In Chrome DevTools
keywords: Less, Chrome, DevTools, CSS, Grunt
summary: Don't repeat urself while writing CSS Code
author: vinitkumar
---

At Changer, we always use LESS to write the stylesheets. Our
workflow comprises of these three steps:

- Debug CSS in Chrome Devtools as per the design.
- Then write it again in LESS in the project.
- Finally compile LESS to CSS for use in production.

Well, It is possible to avoid these three steps and write LESS directly in Chrome DevTools. Currently,DevTools provies built-in support for live editing CSS and SASS.

The latest versions of Chrome and Chrome Canary have the feature of Workspace. It means you can add your project directory to DevTools and it would have write access to your project. So whatever changes you do in the browser gets saved in the project directory.

- Add the project directory to Workspace.
- Install Nodejs, NPM and grunt if you don't have them already.
- Modify the package.json and gruntfile.js in order to work for your project.

You will require these two files to get this setup working:

`gruntfile.js`:

```js
module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    less: {
      debug: {
        src: 'assets/css/style.less',
        dest: 'assets/css/style.css'
      }
    },
    watch: {
      files: ['<%= less.debug.src %>'],
      tasks: ['less']
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-devtools');
  //css compilation from less and minification
  grunt.registerTask('css', ['less']);

};

```

`package.json`:


```js
{
  "name": "less-to-css",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "less": "1.3.3",
    "grunt-devtools": "0.1.0-7"
  },
  "devDependencies": {
    "grunt-contrib-watch": "~0.4.4",
    "grunt-contrib-less": "~0.6.2"
  }
}

```

- Once done with this setup, run `$grunt watch` in the project directory and start editing the LESS code in browser.  

### Advantages:

This is a great addition to your workflow because:

- It automatically converts your LESS to CSS and you could also minify
  them for production usage at the time of saving the file. 
- It saves a lot of time and helps you write better CSS code (in
  LESS).

### Resources and References

- Chrome DevTools: https://developers.google.com/chrome-developer-tools/
- Using Grunt: http://gruntjs.com/getting-started
- NPM Basic tutorial: http://dreamerslab.com/blog/en/npm-basic-commands/


