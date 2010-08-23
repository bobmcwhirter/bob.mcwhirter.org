---
title: "Multiple instances of AS on OSX"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jboss, osx ]
---
Rysiek asked me to elucidate my clustering on OSX...

By default, it seems that OSX provides exactly 1 localhost address, unlike RHEL.  I normally make use of 127.0.0.1/24 when I'm deploying on Linux, and figured I'd do the same on OSX.

To accomplish this, you need to create some new localhost IPs to play with.
<pre>
  <code>
sudo ifconfig lo0 alias 127.0.0.10 up
sudo ifconfig lo0 alias 127.0.0.11 up
sudo ifconfig lo0 alias 127.0.0.12 up
</code>
</pre>
Now, when you run your AS with <code>./run.sh</code>, just pass <code>-b 127.0.0.10</code> or <code>-b 127.0.0.11</code> etc, and the entire stack will bind to that IP address.

At this point, I'm allowing each AS instance to share a work directory and such, which is probably not exactly the safest thing to be doing.  Normally each cluster node would be a discrete machine with its own <code>JBOSS_HOME</code>.

For the apache config, in <code>/private/etc/apache2/httpd.conf</code>, I uncommented the line to allow vhost file loading:
<pre>
  <code>
# Virtual hosts
Include /private/etc/apache2/extra/httpd-vhosts.conf
</code>
</pre>

Then, in the <code>httpd-vhosts.conf</code> file I fixed it up to include my virtual host for the head-end load-balancing stuff.

The <code>&lt;VirtualHost&gt;</code> is only barely conformant, and even the <code>DocumentRoot</code> is gratuitous, really.  It looks like this:

<pre style="overflow:auto;font-size:90%">
  <code>
&lt;VirtualHost *:80&gt;
  ServerName app.local.ballast
  DocumentRoot "/Users/bob/public_html"

  RewriteEngine on

  RewriteMap    lb      'prg:/Users/bob/bin/load_balancer local.ballast 1 3'
  RewriteRule   ^/(.*)$ ${lb:$1}           [P,L]
&lt;/VirtualHost&gt;
</code>
</pre>
What that is doing is passing each requested path to the <code>load_balancer</code> script I've borrowed from I-don't-know-'where.  It returns an augmented URL pointing to one of my localhost-bound nodes.
<pre style="overflow:auto;font-size:90%">
  <code>
#!/usr/bin/env perl
##
##  lb.pl -- load balancing script
##

$| = 1;

$name   = $ARGV[0];         # the hostname base
$first  = $ARGV[1];         # the first server (not 0 here, because 0 is myself)
$last   = $ARGV[2];         # the last server in the round-robin

$cnt = 0;
while (&lt;STDIN&gt;) {
    $server = sprintf("node%d.%s", $cnt+$first, $name);
    $cnt = (($cnt+1) % ($last+1-$first));
    print "http://$server:8080/$_";
}
</code>
</pre>
If a path of <code>/foo/bar</code> is handed to it on STDIN, it'll return something in the format of <code>http://node1.local.ballast:8080/foo/bar</code> or <code>http://node2.local.ballast:8080/foo/bar</code>.

Through the magic of <code>/etc/hosts</code> those friendly names point to the localhost bound AS cluster nodes, along with <code>app.local.ballast</code> pointing to good old traditional 127.0.0.1, where httpd is normally listening.  That's my head-end from the <code>httpd-vhosts.conf</code>.
<pre>
  <code>
127.0.0.1       localhost app.local.ballast

127.0.0.10      node1.local.ballast
127.0.0.11      node2.local.ballast
127.0.0.12      node3.local.ballast
</code>
</pre>

Fire up a browser and I surf to <code>http://app.local.ballast/</code>, apache answers, and immediately and invisibly proxies the request to port 8080 of one of my localhost-bound JBoss AS instances.

Nice.
