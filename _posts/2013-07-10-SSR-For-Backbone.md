---
layout: post
categories: [javascript, backbone, node.js]
title: Server Side Rendering for Backbone.js App
keywords: javascript, backbone, node.js
summary: If you need indexing for your full single-page Backbone.js app,
author: rubenstolk
---

The following is work in progress, especially because of performance issues.

Should you have a full single-page app using Backbone.js (or possibly other javascript framework) and
you use require.js, this helps to easily make your page server-rendered, taking into account the URL et
cetera.

We used node.js with Express, hence the following is to be used as a middleware in Express.

This mechanism is useful if you have an app that does everything on the client, especially templating.

Because of the current performance cost, I would suggest to only load the app on the server when serving
to Google/Facebook etc, e.g. only when necessary.

The idea is very simple, use jsdom to load the HTML on the client, start the javascript-app and fetch the
resulted HTML, serve this to the client. We create one app-window and keep it in memory, then use that app
to route each request that comes in and feed the response with the rendered HTML.

See the code below, annotated with some comments. You'll have to do quite some changes to make it work
for your own scenario!

I've also set up a small example project which shows the code in use:

[https://github.com/rubenstolk/backbone-ssr](https://github.com/rubenstolk/backbone-ssr)

Good luck!

```js

// this should ideally be done through some configuration...
var root = 'http://localhost:4000'

// define a middleware function that is given the path of our public files directory 'public'
exports.ssr = function (public) {

  // load some modules
  var fs = require('fs')
    , jsdom = require('jsdom').jsdom
    , html5 = require('html5')

    // jsdom by default doesn't have XMLHttpRequest
    , XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest

    , path = '/'

    // read the main html file that is normally served to our client
    , html = fs.readFileSync(public + 'main.html').toString()
               .replace(/((href|src)=")\//g, '$1' + root + '/')

    // create our 'document', don't load external stuff like google-analytics
    , document = jsdom(html, null, {
        features: {
          SkipExternalResources: /(cloudfront\.net|google)/
        }
      })
    , window = document.createWindow(null, null, {
        parser: html5
      })
    , staticFileCache = {}

  // keep some loaded files in memory
  window.getStaticFile = function(url) {
    staticFileCache[url] = staticFileCache[url] || fs.readFileSync(public + url).toString()
    return staticFileCache[url]
  }

  // nice for debugging, when we use console.log in our client app, it will be logged to the terminal
  window.console.log = function() {
    console.log.apply(global, Array.prototype.slice.call(arguments, 0))
  }

  // Do our require.js magic
  window.onload = function() {
    window.XMLHttpRequest = XMLHttpRequest
    window.requirejs.config({
      baseUrl: root + '/app/'
    })
  }

  // In our client-side app we can easily check if we're in server scope or not
  window.server = true

  // Make our 'window' believe we're on the actual URL
  window.document.location.href = root + path
  window.document.location.host = root
  window.document.location.pathname = document.location.path = path

  // the actual middleware function for express
  return function(req, res, next) {

    var path = req.url

    // Update the window URL based on the incoming request
    window.document.location.href = root + path
    window.document.location.host = root
    window.document.location.pathname = path

    // Make our $.ajax use session stuff
    if(req.user) {
      var headers = window.$.ajaxSetup().headers || {}
      headers['X-Auth-Token'] = req.user.token
      window.$.ajaxSetup({
        headers: headers
      })
    }

    // I use Backbone.LayoutManager which has a great 'afterRender' event
    // Use this event to get the document's outerHTML and serve that to our client
    window.$(window).one('afterRender', function() {
      res.set('Content-Type', 'text/html')
      var html = window.document.outerHTML
      html = html.replace(/^\n+/, '<!doctype html>\n')
      html = html.replace(/<script[^>]*?data-requiremodule[^>]*?><\/script>/g, '')
      res.send(html)
      window.Backbone.history.stop()
    })

    // Now tell Backbone to follow the incoming request URL
    window.Backbone.history.loadUrl(path)

  }
}
```
