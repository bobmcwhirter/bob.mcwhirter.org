---
title: "Parasitic Community Growth"
author: 'Bob McWhirter'
layout: blog
tags: [ community, jboss, jbossorg, opensource ]
---
<img width="103" height="110" align="right" alt="tick.jpg" id="image192" title="tick.jpg" src="/blog/assets/tick.jpg"/>Sure, you see the word "parasitic" and the first thing that pops to mind is probably "ewww."

But parasitic behavior is actually a good strategy for new communities, as long as they don't ultimately kill their host.

Last night Rysiek pinged me about some thoughts on how to improve JBoss Portal, by allowing the core team to work on the core portal, and perhaps have another team that focuses on just writing portlets.  He pointed me to <a title="Portlet wishlist" href="http://wiki.jboss.org/wiki/Wiki.jsp?page=JBossPortalProjects">a nice wishlist of portlets</a> that would be great to have.

We could certainly put some labor into it, but that wouldn't help leverage our community.

He and I conversationally strolled around the problem for a while, and came up with some conclusions.
<h4>Complimentary instead of stand-alone</h4>
It's hard enough getting someone to build some software you want.  Finding a guy who wants to build it, and build it as a portlet is even harder.  Instead, perhaps take a strategy of "portalizing" existing non-portal applications.

The thing is it's hard to start a community from scratch with a brand new project. You might have a large potential community, but you initially have 0 adopters and no easy way to convince people to try your stuff.

If you create complimentary projects that add value to an existing community, the road is much easier. These folks are easier to find and more receptive, since you've come to them with a solution that fits their current environment, instead of convincing them your project solves a problem they didn't even know they had.

For example, everyone loves the various JIRA macros in Confluence.  That's somewhat portlet-like. In fact, JBoss could easily write a few portlets against the JIRA API.
<h4>Glom onto an existing community</h4>
Now, we don't have to build a community from scratch.  We can find the JIRA community pretty easily.  Some subset of that community probably uses some portal somewhere and might enjoy a good JIRA portlet. I'm sure only a subset of those portal people use JBoss Portal at this point, though.

So, we make sure our JIRA portlets are easy to use and are compatible with <strong>all</strong> portals out there, not just JBoss. This broadens our own potential community, for one.  And secondly, it actually creates pressure for eXo, Liferay, and other portals to <strong>not</strong> create their own JIRA portlets.
<h4>Plant some seeds</h4>
Now, if we throw out a small handful of JIRA portlets, let's say, which solve some of the hard problems (like the JIRA SOAP interface being "interesting" at times) and provide examples, we've made it easy for the community (the JIRA+Any-Java-Portal subset) to extend our initial seed.  And a portlet-creating community grows.

After a suitable amount of time and effort giving to their community, they'll eventually turn around and give back.
<h4>Marketplaces  Communities</h4>
Rysiek pointed out the existing <a title="JBoss Portlet Swap" href="http://labs.jboss.com/portal/portletswap/?prjlist=false">JBoss Portlet Swap</a>, which has quite a few things in it.  But he comments that the associated forums are almost dead.  JBoss Portal Swap is a marketplace where the cost of transactions is zero.

I'm not surprised, given the nature of the Portlet Swap.  The actual distributables in it are quite diverse, with a single thing in common: they're <span style="font-weight: bold">portlets</span>.  The stronger side of each of these projects is the non-portlet value-add.  Most of the conversation there will occur within the primary community (for example, JIRA's community, Pentaho's community).  Else, they are simple and not necessarily community-invoking (for example, the calculator portlet, or the flash portlet).

Portlet Swap (and really any marketplace type of thing) has such diversity in its members, it probably won't have much of a community.  It's ultimately infrastructure.  As humans, we might all shop at the same mall.  But I probably don't want to have a beer with you just because we've walked the same hallways and shopped at Sears.
<h4>Applicable to other realms</h4>
I've spoken in the specifics of portals, portlets and JBoss's Portlet Swap marketplace.  But this can all be generalized to any project that's extensible.

ESBs come to mind initially.  It's definition is that it's a core with a bajillion ways to interface with a bajillion different systems.  No way the core team can implement them all.  But by providing a reasonable starting point, the community is encouraged to contribute their adapters for their own weird little system.  You solve most of their problem (by providing JMS connectors or whatnot), and they fill in the gap with their odd PDP-10 message-queue connector.  The ESB project benefits from the nutball PDP-10 community.

Ultimately, by finding an existing community you can compliment and attach to, the easier it will be to reach your prospects and have them contribute back.  You can plant some seed and provide some initial value to a group that's paying attention.  With enough care and sunlight, you'll accomplish what you're trying to do.
