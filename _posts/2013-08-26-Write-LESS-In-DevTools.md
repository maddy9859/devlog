---
layout: post
categories: [LESS, CSS, Chrome DevTools]
title: Write And Edit Less In Chrome DevTools
keywords: Less, Chrome, DevTools, CSS, Grunt
summary: Don't repeat urself while writing CSS Code
author: vinitkumar
---


Trying to write LESS in Chrome DevTools. Currently DevTools provies
offiially support live editing for CSS and SASS. But using the hack
described below you can live edit LESS on your browser and it will
conveniently compile to CSS in real time.

This is needed because when you use DevTools to live edit some css and
your codebase is in LESS, you need to write first in CSS in your
DevTools and again you need to rewrite it in LESS(abiet in slightly
different syntax). It woul be much better if you could just live edit
LESS and your tooling takes care of its compilation and minification.  

It is quite easy to do. The latest versions of Chrome and Chrome Canary
comes with the concept of workspaces. This means you can add your
directory of code to DevTools and it would have write access to the
code. Using this very concept, combined with some Grunt hackery, it is
very much possible to write LESS directly in Chrome DevTools.

The setup requires some configuration:

- You need to know how to use grunt and some basics of node and npm.
- A Gruntfile needs to be added to the existing project directory. 
- A package.json file is also required to get the necassary npm modules.
- Moderate understanding of Chrome DevTools.

First of all setup package.json and gruntfile.js file for your projects.

Here are sample package.json and gruntfile.js files for easy reference:

###gruntfile.js:

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
###package.json:

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
Then, Add your current project directory to Workspace in your devtools.
Then click on the Sources tab of your devtools, you will see all the
files in your project when you HIT `CMD+O`. Now, return to your shell
and run `grunt watch`. This will trigger a watch on the changes in your
less and will compile your less into CSS each time you write and save
your LESS file.

* Advantages (if any)

This is helpful because:

- You don't need to write CSS to test in your browser and write in LESS
  in your project. You will now write LESS once and for all. 
- You don't need to compile and/or minify your LESS code each time you
  are done making changes. Grunt will be doing it in realtime for you.
- It saves you a lot of time and helps you write better CSS code (in
  LESS).

* Resources and References

If you don't follow all the tooling already, you should go through these
links:

Chrome DevTools: https://developers.google.com/chrome-developer-tools/
Using Grunt: http://gruntjs.com/getting-started
NPM Basic tutorial: http://dreamerslab.com/blog/en/npm-basic-commands/


