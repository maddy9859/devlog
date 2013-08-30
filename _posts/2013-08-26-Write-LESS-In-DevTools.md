---
layout: post
categories: [LESS, CSS, Chrome DevTools]
title: Write And Edit Less In Chrome DevTools
keywords: Less, Chrome, DevTools, CSS, Grunt
summary: Don't repeat urself while writing CSS Code
author: vinitkumar
---

At Changer, we almost always use LESS to write CSS code. Usually, our
workflow comprises of these three steps:

- Use Devtools to debug the CSS.
- Write the code in LESS during development.
- Compiles LESS to CSS at the final stage before deploying or pushing to the repo.

It is possible to write LESS in Chrome DevTools. Currently,DevTools provies
built-in support for live editing CSS and SASS. But it is perfectly possible to write LESS in it as well.

Lets see how it to configure DevTools to do it:

The latest versions of Chrome and Chrome Canary
comes with the concept of workspaces. It means you can add your project directory to DevTools and it would have write access to the
code.So whatever changes you do in the browser persists in the code.

- Add the project directory to Workspace.
- Install Nodejs, NPM and grunt if you don't have them already.
- Modify the package.json and gruntfile.js in order to work for your project.


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

- Once done with this setup, run `$grunt watch` in the project and start editing the LESS code in browser.  

### Advantages:

This is helpful because:

- It is not needed to write CSS to test in browser and then write in LESS
  in your project. 
- It saves you a lot of time and helps you write better CSS code (in
  LESS).

### Resources and References

- Chrome DevTools: https://developers.google.com/chrome-developer-tools/
- Using Grunt: http://gruntjs.com/getting-started
- NPM Basic tutorial: http://dreamerslab.com/blog/en/npm-basic-commands/


