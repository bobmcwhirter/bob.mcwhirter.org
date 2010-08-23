---
title: "Run level, run!"
author: 'Bob McWhirter'
layout: blog
tags: [ ec2, linux, runlevels, xen ]
---
Trying to debug why my init scripts weren't initing on EC2, I checked all the normal places.

The <code>chkconfig</code> tool reported that my services should be on at runlevel 3:
<pre>
  <code>
jboss   0:off   1:off   2:off   3:on    4:off   5:on    6:off
</code>
</pre>
My /etc/inittab says I was booting to runlevel 3:
<pre>
  <code>
id:3:initdefault:
</code>
</pre>
Yet the console did not show my things to be spinning.  A little googling around, I found the <code>runlevel</code> command (I'm not a linux expert...) which explained to me I was in runlevel 4.
<pre>
  <code>
N 4
</code>
</pre>
4?  Really?  4?  I wasn't expecting that.

Apparently this is just how EC2/Xen work.  They force you up into runlevel 4.

What does 4 mean?  Asking the Wikipedia, you'll see a pattern:
<ul>
	<li>Typical linux: unused</li>
	<li>Debian/Ubuntu: same as 2,3 and 5, weirdos</li>
	<li>RHEL/Fedora: unused/user-definable</li>
	<li>SUSE: unused/user-definable</li>
	<li>Slackware/Gentoo: Same as 3, which implies graphics, even</li>
	<li>Sys-V: seems to imply multi-user with graphics</li>
</ul>
I had no idea that runlevels were all over the map.  I also had no idea that EC2 would disregard my inittab and make up their own ideas.

Thanks, guys.  Another hour-long round of RPMing, kickstarting, and image-creation ahead of me...
