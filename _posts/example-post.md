---
layout: post
categories: [javascript, code-style]
title: javascript coding style
keywords: javascript, coding, style
summary: javascript styling guide I follow for node.js. Other style guide references
author: madhums
---

This is the javascript coding style I follow

1. No Comma first
2. Two space indentation
3. No semicolon
4. Use single quotes
5. Always use `var` for variable declarations

For example

```js
var express = require('express')
var User = mongoose.model('User')
var auth = require('./authorization')
var arr = [1, 2, 3, 4]

User
.findOne({ name: 'abc' })
.run(function (err, user) {
  if (err) return res.send(400)
  if (!user) {
    // do something
    return res.send(403)
  }
  res.json(user)
})
```

Other styling guides out there:

1. [npm coding style](http://npmjs.org/doc/coding-style.html)
2. [Google javascript styling guide](http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml)
3. [Github javascript styling guide](https://github.com/styleguide/javascript)
4. [idiomatic.js](https://github.com/rwldrn/idiomatic.js#readme)
5. [Felix's node.js style guide](http://nodeguide.com/style.html)

When I am developing on the server side (node.js) I don't use semicolons, otherwise on the client side I mostly do.
