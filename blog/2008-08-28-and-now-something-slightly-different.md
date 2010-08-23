---
title: "And now, something slightly different"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jboss, jbossorg, job, jruby, ruby ]
---
Back in May, I was a manager.

I feebly attempted to direct 8 great guys and gals to further the goals of JBoss.org.  After the Codehaus, you'd think I'd be able to help build an opensource community with fun and flair.  But I came to realize that it's hard to build a community as an active effort.  Instead, I think community develops as a by-product of a useful and well-run project.  And that's under the control of the project leaders and contributors, not necessarily some external third party.

Back in May, I gave up being a manger.

Now, the day after Labor Day, fittingly enough, I'll be jumping back into the world of JBoss.  But <strong>not as a manager</strong>. When I was burned out and felt like resigning, <a title="Proctor's Drools blog" href="http://blog.athico.com/">Mark Proctor</a> and <a title="Sacha's Blog" href="http://sacha.labourey.com/">Sacha Labourey</a> instead talked me into taking a sabbatical.  And I'm truly grateful to them.  Now, after unwinding for a few months, I asked to rejoin the team as an engineer.  Through Sacha's patience and budget manipulation, I'm once again excited to go to work.  I think JBoss should definitely be held up as a company that takes care of its people.  They could've easily given me the boot, but instead they've been extremely kind and accommodating.

So, what will I be doing?

After talking to Java developers and Rubyists alike, my first goals are to look at Rails as just-another-way to write J2EE apps (or "JEE" I reckon, these days...).  Yes, I know about (and plan to use) things like <a title="Warbler" href="http://blog.nicksieger.com/articles/2007/09/04/warbler-a-little-birdie-to-introduce-your-rails-app-to-java">Warbler</a> and <a title="JRuby-Rack" href="http://blog.nicksieger.com/articles/2008/05/08/introducing-jruby-rack">JRuby-Rack</a>.  Both are good things.

But I also have full control of the deployment environment, to build a stack to make it happier than "build and deploy a WAR".

Through the miracle of <a title="JBossAS" href="http://www.jboss.org/jbossas/">AS5</a> built on <a title="JBossMC" href="http://www.jboss.org/jbossmc/">JBossMicrocontainer</a>, along with the awesome <a title="JBossVFS" href="http://repository.jboss.org/maven2/org/jboss/jboss-vfs/">VFS</a> bits, it should be possible to deploy a Rails app in-situ, right from your working directory.  There should be no reason to have to build a WAR while you're hacking a rails app.  And deployment to a server should still involve capistrano (in my opinion).  Stick to the Rails way of doing things, but make it Java under the covers.

Various blog posts have shown Rails apps on Glassfish in 12, 10, or 5 steps.  My goal is to get it down to 1 step. And you should magically be able to pick up and use all the wonderful JEE bits that maps to the Rails functionality the Railers of the world enjoy, without having to be aware of the JEE bits.

Speaking with Mark Newton (the guy who runs JBoss.org now), it seems sensible to view Rails as simply yet-another-programming-model for writing Java apps.  The idea is to avoid leaky abstractions, so we're not having to write some psuedo RubyJava application.

Once we've got that base covered, then we can make fun and exciting Ruby bindings to all the powerful JBoss tools, such as Drools, ESB, Cache or MQ.

I expect to have a bit of fun with this.  More fun than being a manager, certainly.
