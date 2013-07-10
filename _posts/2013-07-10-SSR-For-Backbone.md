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
you use require.js.

We used node.js with Express, hence the following is to be used as a middleware in Express.

I might put comments or explanation if needed, ping me for help!


```js
exports.ssr = function (public) {

  var fs = require('fs')
    , jsdom = require('jsdom').jsdom
    , html5 = require('html5')
    , XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest
    , root = 'http://localhost:4000'
    , path = '/'
    , html = fs.readFileSync(public + 'main.html').toString()
               .replace(/((href|src)=")\//g, '$1' + root + '/')
    , document = jsdom(html, null, {
        features: {
          SkipExternalResources: /(cloudfront\.net|google)/
        }
      })
    , window = document.createWindow(null, null, {
        parser: html5
      })
    , staticFileCache = {}

  window.getStaticFile = function(url) {
    console.log(url, !!staticFileCache[url])
    staticFileCache[url] = staticFileCache[url] || fs.readFileSync(public + url).toString()
    return staticFileCache[url]
  }
  window.console.log = function() {
    console.log.apply(global, Array.prototype.slice.call(arguments, 0))
  }
  window.onload = function() {
    window.XMLHttpRequest = XMLHttpRequest
    window.requirejs.config({
      baseUrl: root + '/app/'
    })
  }

  window.server = true

  window.document.location.href = root + path
  window.document.location.host = root
  window.document.location.pathname = document.location.path = path

  return function(req, res, next) {

    var path = req.url

    window.document.location.href = root + path
    window.document.location.host = root
    window.document.location.pathname = path

    if(req.user) {
      var headers = window.$.ajaxSetup().headers || {}
      headers['X-Auth-Token'] = req.user.token
      window.$.ajaxSetup({
        headers: headers
      })
    }

    window.$(window).one('afterRender', function() {
      res.set('Content-Type', 'text/html')
      var html = window.document.outerHTML
      html = html.replace(/^\n+/, '<!doctype html>\n')
      html = html.replace(/<script[^>]*?data-requiremodule[^>]*?><\/script>/g, '')
      res.send(html)
      window.Backbone.history.stop()
    })

    window.app.authenticate(function() {
      window.Backbone.history.loadUrl(path)
    })

  }
}
```
