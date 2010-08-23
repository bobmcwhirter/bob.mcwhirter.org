---
title: "Deployers in JBoss Microcontainer"
author: 'Bob McWhirter'
layout: blog
tags: [ deployers, java, jboss, microcontainer ]
---
In order to deploy a Rails app, I've had to learn the innards of Microcontainer's deployer framework.  After a few wrong turns, I feel like I've finally gotten a handle on it.

While we're all used to dropping in an .ear or a .war, and might think in terms of deploying these archive formats, that's ultimately one step removed from true deployment through MC.

Within MC, when you deploy a .war or an exploded WAR directory, the first step is something recognizes that the chunk you're deploying is roughly shaped like a WAR.  I'll address that phase of deployment in a future post.

Knowing that the deployment is a WAR also tells MC to look in WEB-INF/ for meta-data descriptors, such as <strong>web.xml</strong> and <strong>jboss-web.xml</strong>.  This is where true deployment of components starts.  Deployment runs through a series of stages, with deployers setup to match particular files and stages, doing the right things at the right time.

One of the earliest stages is the <strong>PARSE</strong> stage.  A deployer can be bound to this stage to be given an early chance to match, parse, and act upon any meta-data file.  For normal WAR deployment, the <strong>WebAppParsingDeployer</strong> does exactly that.  There's a nice hierarchy of classes to make parsing XML descriptors such as web.xml super simple.

The <strong>WebAppParsingDeployer</strong> is the bridge from a web.xml file sitting on the filesystem or in an archive to the <strong>MetaData</strong> deployment bits. The parser reads web.xml, and produces a <strong>WebMetaData</strong> object associated with the deployment.  The <strong>WebMetaData</strong> is simply a nice object-tree representing anything you can denote in web.xml.

We also might have a jboss-web.xml meta-data in our WAR, and that is parsed during the <strong>PARSE</strong> stage by the <strong>JBossWebAppParsingDeployer</strong>.  This deployer, like the previous, reads the XML file and creates, in this case, a <strong>JBossWebMetaData</strong> object.

Once we've parsed these .xml files, the container has enough information to build up the classpath for the component.  Some of these deployers have also thrown off or modified some <strong>ClassLoadingMetaData</strong>, which describe paths that should be added to the classpath.

As the container enters the <strong>CLASSLOADER</strong> stage of deployment, other magic occurs to actually set up the classpath.

In the end, it's the <strong>JBossWebMetaData</strong> that drives the ultimate deployment, but what if we don't have a jboss-web.xml?  That's where the <strong>MergedJBossWebMetaDataDeployer</strong> comes in.  It looks for a <strong>WebMetaData</strong>, and a <strong>JBossWebMetaData</strong> if one has been parsed, and merges them into a singular <strong>JBossWebMetaData</strong>.  I think it also mixes in any defaults that you have set for server-wide settings.

Additionally, as jboss-web.xml is parsed by <strong>JBossWebAppParsingDeployer</strong>, it will perform the merge itself.  Additionally, magic is occuring to merge any annotation-based meta-data.

I'm a little fuzzy on the ins and outs of the <strong>CLASSLOADER</strong> stage at this point, but magic occurs there.

And our app still isn't deployed yet.  But we're getting there.

Finally, we enter the REAL stage of deployment, which fittingly-enough, is where the actual deployment occurs.  Hooray!

Our <strong>TomcatDeployer</strong> is hanging out there, waiting for <strong>JBossWebMetaData</strong> objects to appear.  When it sees one, it goes to work setting up information for Tomcat to deploy a web-app.  It configures everything in Tomcat from the information other deployers figured out from web.xml and jboss-web.xml and embodied in the MetaData.

It jams it into Tomcat, hits the big red "go" button, and port 8080 is serving you web-app.

Finally.

In general, to deploy in AS5 using Microcontainer, you need some MetaData bits, and perhaps a bag of files/classes/resources.  Nothing says they have to be bundled into a .war, or include some j2ee XML deployment descriptor.  If you have other magical ways of bundling MetaData and resources, you're good to go.

Of course, Ales or Adrian may tell me I'm completely wrong.  That's always a possibility.  In fact, I'm sure I've got some things wrong, in reverse order, and otherwise mixed-up.

Here's a picture for you, though.

<a href="http://www.fnokd.com/wp-content/uploads/2008/09/war-deployment.png">
  <img class="aligncenter size-medium wp-image-474" title="war-deployment" src="/blog/assets/war-deployment-292x300.png" alt="" width="292" height="300"/>
</a>

<strong>Update:</strong>

While discussing this on the <a title="Forum post" href="http://www.jboss.com/index.html?module=bb&amp;op=viewtopic&amp;t=142550">Microcontainer user's forum</a>, I discovered that there are indeed several errors and inconsistencies in the above.

<strong>Update #2:</strong>

New image, slightly new text to match the image better.  Comments and clarifications still welcomed.
