---
title: "Stumbling through technology"
author: 'Bob McWhirter'
layout: blog
tags: [ ec2, java, jboss, puppet, thincrust, virtualization ]
---
It can sometimes be funny, the paths we take.

Once I'd verified that a Rails app deployed on JBoss <a title="Clustering Rails on JBoss" href="/blog/jbor-will-it-cluster">would indeed cluster</a>, I sat in my farmhouse, looking at my lone little Mac.  Not much of a cluster to play with.

So I started looking at <a title="Amazon EC2" href="http://aws.amazon.com/ec2/">Amazon EC2</a>, which is truly very nice, particularly when paired with <a title="Elasticfox happiness" href="/blog/elasticfox-osx-and-iterm">Elasticfox</a>.

Of course, firing up a cluster on EC2 requires a nicely-produced, ready-to-boot machine image or a lot of manual configuration on each node.

<a title="Sacha's blog" href="http://sacha.labourey.com/">Sacha</a> pointed me to another group within Red Hat: <a title="Thincrust" href="http://thincrust.net/">Thincrust</a>.

Thincrust configures a Fedora disk image with "just enough" OS bits, and provides a way to add/update applications on it.  It's a happy mixture of Kickstart, <a title="Puppet" href="http://reductivelabs.com/projects/puppet/">Puppet</a> and Yum.

The goal is to make it easy to produce <a title="Example Thincrust appliances" href="http://thincrust.net/ace-examples.html">"appliance" images</a> that could be flung onto machines, real or virtual.  Need a Git server?  Fire up the Git appliance on the cloud.  Need a Drupal server?  Fire one of those up.  Need a JBoss server or cluster?  We're working on that..

Thincrust is built upon Fedora.  My Mac is not.  But <a title="VMWare Fusion" href="http://www.vmware.com/products/fusion/">VMWare Fusion</a> lets me run Fedora.  So I can create Fedora-based Thincrust images.  Which I'll deploy on EC2.  Which is running Xen, probably on RHEL.  And ultimately allowing you to run your Ruby-on-Rails applications on a Java stack.

There are times I can't remember exactly which OS, language, or virtualization environment I should be thinking in.
