---
title: "Boot up JBoss"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jboss, rails, thincrust, virtualization, vmware ]
---
On my path towards clustering a Rails app on JBoss on EC2, I <a title="Stumbling into the Thincrusties" href="/blog/stumbling-through-technology">stumbled across</a> Bryan Kearney and the other <a title="Thincrust" href="http://thincrust.net/">Thincrust</a> guys. With their help, I now have a JBoss AS5 + jboss-rails "appliance" ready to roll.

Grab the <a title="Raw image" href="http://fnokd.com/~bob/jboxx/jboxx5-0.1-preview-1-raw.tar.gz">raw image</a> or the <a title="JBoxx VMWare image" href="http://fnokd.com/~bob/jboxx/jboxx5-0.1-preview-1-vmware.tar.gz">VMWare image</a>, and play along at home.

Fire up the image in your favorite virtualization environment. I give my virtual machine at least a gig of RAM. Marvel at the pretty Grub splash screen, courtesy of <a title="James Cobb" href="http://www.insectengine.com/wordpress/">James Cobb</a> (JBoss.org designer).

<a href="/blog/assets/picture-6.png">
  <img class="aligncenter size-full wp-image-551" title="Grub" src="/blog/assets/picture-6.png" alt="" width="456" height="339"/>
</a>

Let it boot on up, and you'll notice a handful of things:
<ul>
	<li>Very few things roll across during boot.  The image is an assembly of "just enough" OS bits.</li>
	<li>Before JBoss boots, "Installing Appliance" or "Updating Appliance" will scroll by.  This is the Thincrust magic that allows adjustment of the appliance in a consistent and controlled manner (via Puppet).</li>
	<li>JBoss AS 5 (with rails deployer) starts at boot.</li>
</ul>
You can login with root password of <strong>thincrust</strong>.

The login prompt will tell you the IP address of the appliance, since it probably booted off DHCP.  JBoss will be up and running at <code>
  <strong>http://&lt;IP_ADDRESS&gt;:8080/</strong>
</code>.

You can <code>
  <strong>su jboss</strong>
</code>, whose <code>$HOME</code> is <code>/opt/jboss/jboss-as5</code>, which coincidentally is <code>$JBOSS_HOME</code>.  The <code>default</code> configuration is used to start the AS.  Logs are under <code>/opt/jboss/jboss-as5/server/default/log/</code>.  And to deploy, just drop something into <code>/opt/jboss/jboss-as5/server/default/deploy/</code> and it'll hot-deploy.

To control the service, as root:
<ul>
	<li><code>service jboss stop</code></li>
	<li><code>service jboss start</code></li>
	<li><code>service jboss status</code></li>
</ul>
I'll make the RPMs used to build this available sometime soon.  Until then, you can poke around <a title="my JBoss RPMification project" href="http://github.com/bobmcwhirter/jboss-rpm/tree/master">the bits I use to create the RPMs</a> ultimately used by Thincrust to build the appliance image.  They are packaged in a way that makes my Red Hat brethren throw up in their mouths a little bit.

Also, once I test'em on EC2, I'll throw out public AMIs for testing.

By no means is this complete.  This just marked a nice spike of a milestone along the way.  There's still plenty of things that'll poke you in the eye if you're not careful.  Always wear your safety harness.  Drink plenty of fluids.  Keep away from children.
