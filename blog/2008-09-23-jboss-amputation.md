---
title: "JBoss Amputation"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jboss, jbossas, rails ]
---
Since JBoss AS 5 is built on top of Microcontainer, it's effectively a network of beans just doing their respective jobs.  You have already probably noticed that it ships with 3 included configurations: <strong>minimal</strong>, <strong>default</strong>, and <strong>all</strong>.

Unfortunately, they're awefully far apart along the spectrum of configuration options.  The <strong>minimal</strong> configuration barely gets the container running, while the <strong>all</strong> configuration includes, well, everything.  For most apps, it's safe to start with the <strong>default</strong> configuration.  But default to who?  It's the 80% case.  But the 80% of the world who gets by with <strong>default</strong>, it still probably includes way more than they need.  Of course, each user needs a different subset of that 80%.

Given that the MC is managing a graph, it seems like we should be able to actually perform a solve to determine what is or is not required.  Or at least get a good idea.  Bonus points if someone can then twiddle conf/, deploy/ and deployers/ to tidy things up.

Anyhow, for the <a title="jboss-as-rails" href="http://github.com/bobmcwhirter/jboss-as-rails/tree/master">jboss-as-rails</a> project, I'm kicking it old-school, and going with default.  I'm jamming it into git, and hopefully with some help, we can get it pared down to what we need.

The <a title="jboss-as-rails" href="http://github.com/bobmcwhirter/jboss-as-rails/tree/master">jboss-as-rails</a> project is simply a configuration of AS that includes only what we need, along with the jboss-rails.deployer from the <a title="jboss-rails" href="http://github.com/bobmcwhirter/jboss-rails/tree/master">jboss-rails</a> project (notice the subtle naming difference...).

Here's a picture to see how it'll all ultimately fit together.

<a href="http://www.fnokd.com/wp-content/uploads/2008/09/jboss-rails-stuff-10kview.png">
  <img class="aligncenter size-full wp-image-512" title="jboss-rails-stuff-10kview" src="/blog/assets/jboss-rails-stuff-10kview.png" alt="" width="329" height="328"/>
</a>

The plugin will offer rake tasks for managing the included AS, deploying your app.  I'll also produce an AS-free version of the plugin, assuming you want to manage your own AS separately.

And poke around <a title="jboss-as-rails" href="http://github.com/bobmcwhirter/jboss-as-rails/tree/master">jboss-as-rails</a>, see what we can rip out.
