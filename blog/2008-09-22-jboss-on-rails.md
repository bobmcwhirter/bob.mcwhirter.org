---
title: "JBoss on Rails"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jboss, jbossas, rails, ruby ]
---
Tomorrow is my first real status update call with my boss, <a title="Sacha's blog" href="http://sacha.labourey.com/">Sacha Labourey</a>.  I've been anxious to deliver something, to prove I hadn't gone <em>completely</em> pudding-brained during my tenure as management.

This morning, it all finally came together in a pleasing fashion, causing me to hoot and holler loud enough to scare the cats and probably some cows.

<a href="/blog/assets/picture-22.png">
  <img class="aligncenter size-full wp-image-485" title="Cows" src="/blog/assets/picture-22.png" alt="" width="229" height="134"/>
</a>

I've just <a title="jboss-rails" href="http://github.com/bobmcwhirter/jboss-rails/tree/master">pushed an ugly-but-working deployer</a> targeting <a title="JBoss-AS" href="http://www.jboss.org/jbossas/downloads/">JBoss-AS 5.0.0.CR2</a> (the latest and greatest!)

It's not very consumable at this point, as it's just a deployer, not a nice Rails plugin with a set of Rake tasks.  Heck, it doesn't even <em>undeploy</em> yet.

But adding the deployer to your server's <code>deployers/</code> directory allows you symlink live <code>RAILS_ROOT</code>s into your <code>deploy/</code> directory, and be running on JBoss.

Live.  In-situ.  Edit your controllers or views as you like, and your changes are immediately reflected in the running instance.  Just like with <code>./script/server</code>.  It does not even have to redeploy your app.  The rails framework is handling the magic reloading.

<a href="/blog/assets/picture-21.png">
  <img class="aligncenter size-full wp-image-484" title="Hello World" src="/blog/assets/picture-21.png" alt="" width="237" height="55"/>
</a>

It's taken me some time to dig through the innards of JBoss-Microcontainer, and a few false starts, but I finally figured out a super simple deployment process.

I'd previously been trying to manipulate a <code>RAILS_ROOT</code> into a synthetic Java WAR archive, and shoe-horn things around that.  But I have the freedom to go lower than that, so the jboss-rails deployer just sets up a Catalina context appropriately, without regard to <code>WEB-INF</code> or other non-Rails stuff.  There's no need for that cruft.  Likewise, I can directly control and manipulate the classpath, so the <code>RAILS_ROOT</code> does not even have to have any JRuby bits in it.

The example application (<a title="ballast test application" href="http://github.com/bobmcwhirter/jboss-rails/tree/master/src/test/ballast">src/test/ballast</a>) is a virgin rails app with ActiveRecord disabled so I don't have to deal with database-driver gems just yet.

Once deployed, a Rails app looks like pretty much any other web-app.  The jboss.rails.deployment domain contains deployment objects for each rails app.  And jboss.web contains all the webby bits floating around.

<a href="/blog/assets/picture-20.png">
  <img class="aligncenter size-full wp-image-483" title="Deployment MBean" src="/blog/assets/picture-20.png" alt="" width="217" height="101"/>
</a>I need to go  back and remove the dead-end code I've left in my wake, and update the tests I'd disabled while in a coding flury (bad Bob!)  I plan to put together an easy-to-consume plugin gem which contains an nicely-configured AS along with the jboss-rails deployer pre-installed, along with rake tasks to start/stop AS, and deploy your app.  I'd also like to give clustering a whirl, and see what we can do.

It's been an excellent 3 weeks back as an engineer.
