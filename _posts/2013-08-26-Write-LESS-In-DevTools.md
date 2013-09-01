---
layout: post
categories: [LESS, CSS, Chrome DevTools]
title: Write And Edit Less In Chrome DevTools
keywords: Less, Chrome, DevTools, CSS, Grunt
summary: Don't repeat urself while writing CSS Code
author: vinitkumar
---

At Changer, we always use LESS to write stylesheets. Our
workflow comprises of these three steps:

- Debug CSS in Chrome Devtools as per the design.
- Then write it in  LESS in the code editor(say Sublime).
- Finally, compile LESS to CSS for use in production.

Well, It is possible to avoid these three steps and write LESS directly in Chrome DevTools. Currently,DevTools provies built-in support for live editing CSS and SASS.

The latest versions of Chrome and Chrome Canary have the feature of Workspace. It means browser's DevTools can get the write access to the project directory. So any changes done to the file gets saved.

### Installation

- Add the project directory to Workspace.
- Install Node, NPM and Grunt.
- Modify package.json and gruntfile.js in order to work with the project.

It will require these two files to work:

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
After saving these files, run `npm install` to get the dependencies and
grunt plugins.

Here are some screenshots of this workflow:

- Adding the project to workspace.
![workspace](public/images/workspace.png)
- Editing the LESS code in the source tab of DevTools.
![LESS](public/images/less.png)
- The LESS code gets compiled to CSS everytime the file is saved.
![CSS](public/images/less.png)

### Usage

Once done with this setup, run `$grunt watch` in the project directory and start editing the LESS code in browser.  

### Advantages:

This is a great addition to your workflow because:

- It automatically converts LESS to CSS and could also minify
  them for production usage at the time of saving the file. 
- It saves a lot of time and help write better CSS code (in
  LESS).

### Resources and References

- Chrome DevTools: https://developers.google.com/chrome-developer-tools/
- Using Grunt: http://gruntjs.com/getting-started
- NPM Basic tutorial: http://dreamerslab.com/blog/en/npm-basic-commands/


