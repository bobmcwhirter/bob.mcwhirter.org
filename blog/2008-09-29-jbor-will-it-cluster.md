---
title: "JBoR: Will it cluster?"
author: 'Bob McWhirter'
layout: blog
tags: [ clustering, java, jboss, jbosscache, jruby, rails ]
---
JBoss on Rails will indeed cluster!

After modifying and dropping my <a href="http://github.com/bobmcwhirter/jboss-rails/tree/master">jboss-rails.deployer</a> into an 'all' configured server of JBoss AS 5, and firing up 3 instances on my localhost (non-trivial on OSX...):

<pre style="overflow: auto; font-size: 90%">
  <code>
10:43:28,409 INFO  [RPCManagerImpl] Received new cluster view: [127.0.0.10:63740|2] [127.0.0.10:63740, 127.0.0.11:63747, 127.0.0.12:63749]
10:43:28,435 INFO  [RPCManagerImpl] Cache local address is 127.0.0.12:63749
10:43:28,469 INFO  [ComponentRegistry] JBoss Cache version: JBossCache 'Poblano' 2.2.0.GA
</code>
</pre>
And I've got 3 nodes running the same Rails app, all sharing a cookie and a <a href="http://www.jboss.org/jbosscache/">JBossCache</a> cache.  Nick Sieger's <a href="http://github.com/nicksieger/jruby-rack/tree/master">JRuby-Rack</a> handles binding the Rails session to the actual servlet session, and JBossCache takes care of the rest.

A little 8-line perl round-robinning load-balancer is wired up through mod_rewrite in my Apache httpd.conf to throw requests to each of the nodes.  Anything set in the session is immediately available at the next request which lands at a different node.

Further down the line, we can look at a clustered cache for caching AR models and view fragments.  Not too shabby.

It should be fairly easy to create a nice Amazon EC2 AMI with Fedora+AS5+jboss-rails, plus some better Rake/capistrano tasks, and make for quick cluster deployment.   Any EC2 experts wanting to jump in?
