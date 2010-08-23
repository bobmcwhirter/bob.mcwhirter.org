---
title: "GitHub Mirrors for some JBoss Projects"
author: 'Bob McWhirter'
layout: blog
tags: [ git, github, java, jboss, jruby, svn ]
---
In addition to the previously-mentioned JRuby mirror from Codehaus SVN to GitHub, I'm now also mirroring:
<ul>
	<li><a title="JBoss Microcontainer on GitHub" href="http://github.com/bobmcwhirter/microcontainer/tree/vendor">JBoss Microcontainer</a></li>
	<li><a title="JBoss AS5 on GitHub" href="http://github.com/bobmcwhirter/jbossas/tree/vendor">JBoss AS5</a></li>
	<li><a title="JRuby on GitHub" href="http://github.com/bobmcwhirter/jruby/tree/vendor">JRuby</a></li>
</ul>
All are trunk-only mirrors, not picking up branches or tags.  Since the JBoss repository path has about 77,000 subversion revisions, and at one point held any and all JBoss software ever written, I have not mirrored it in its entirety.  Instead, I've only grabbed http://anonsvn.jboss.org/repos/jbossas/trunk back to revision 77,200.  It'll mirror going forward, but the github repository does not include any ancient history.

For those of you playing along at home, the way to fetch just a cauterized "tip" from SVN to a git repository is to mirror <a title="Mirroring SVN to GitHub" href="/blog/mirroring-svn-repository-to-github">as before</a>, but for the initial "git svn fetch" command, add a SVN-style revision range
<blockquote>git svn fetch -r77200:HEAD</blockquote>
For me, at least, trying to fetch the tip revision for the directory resulted in failure.  Going back a few revisions, and using a range that includes HEAD worked much better.  Then just push to GitHub has normal, and start your rebase/push cronjob.

The JBoss projects are updated from SVN every 15 minutes.  But we're updating from the anonymous SVN repository at JBoss, which itself is delayed from the developer repository by some amount of time.  So, ultimately, the GitHub mirror should be mostly up-to-date, but could lag behind actual developer commits by up to and hour, I reckon.

If you're wanting to track these repositories using my git mirror, only track the vendor branch.  I make no claims about the stability or sanity of the 'master' ref at any point in time.  I will make sure 'vendor' exactly matches the Subversion history, though.
