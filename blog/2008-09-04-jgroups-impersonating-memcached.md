---
title: "JGroups impersonating memcached"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jboss, jgroups, memcached ]
---
I woke up and noticed that a <a title="JGroups: memcached" href="http://www.jgroups.org/javagroupsnew/docs/memcached/memcached.html">memcached mode</a> was announced by Bela Ban, the fantastically Swiss man who jogs waaay too much.

There's a lot of things in this world that can take advantage of memcached.  Personally, I find this quite interesting, considering that memcached tends to be the cache-of-choice for lots of non-Java languages.  For instance, fragment caching and model caching in Rails supports talking to memcached.

Or now, <a title="JGroups" href="http://www.jgroups.org/javagroupsnew/docs/index.html">JGroups</a>.
