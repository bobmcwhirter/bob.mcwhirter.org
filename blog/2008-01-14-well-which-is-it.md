---
title: "Well, which is it?"
author: 'Bob McWhirter'
layout: blog
tags: [ java, jira, maven, usability ]
---
I've been working on compiling JIRA plugins lately, with <a href="http://maven.apache.org/" title="Mavenrific!">maven-2</a>.

And I see this go scrolling by:
<p style="border: 1px dotted #999999; padding: 1em; font-family: monospace; font-size: 10pt; text-align: left"> [<strong style="color: red">WARNING</strong>] *** CHECKSUM <strong style="color: red">FAILED</strong> - <strong style="color: red">Error</strong> retrieving checksum file for webwork/jars/webwork-30Apr07-jiratld.jar - <strong style="color: red">IGNORING</strong></p>
In that single line, I get confused, as there are 4 hot words right there.
<ol>
	<li><strong>WARNING</strong>: Hey, something bad happened, but it's not <em>super</em> bad.</li>
	<li><strong>FAILED</strong>: Well, crap, it just plain <strong>did not work</strong>.</li>
	<li><strong>ERROR</strong>: Yep, it still didn't work, and that's a <strong>bad bad thing</strong>.</li>
	<li><strong>IGNORING</strong>: But apparently I shouldn't care <em>too</em> much, because maven surely isn't giving it much thought anymore.</li>
</ol>
Should I take corrective action?  Is there anything I can do?  I got all hyped up about being warned of the error of failing, only to be told it's no big deal.

Of course, I had to babysit the first build like a crack-baby delivered in the 2nd trimester.  Maven attempts to download the world from Atlassian's repository which likes to take a nap after downloading a dozen .pom files.  I'd have to go <em>Control-C</em> all over it, and start over, to get a running start at the next dozen .poms.  Fun!
