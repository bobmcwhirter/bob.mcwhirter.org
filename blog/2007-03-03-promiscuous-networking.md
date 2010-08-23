---
title: "Promiscuous Networking"
author: 'Bob McWhirter'
layout: blog
tags: [ network, technology, traveling ]
---
<img width="182" height="182" align="right" title="addhealth.gif" id="image183" alt="addhealth.gif" src="/blog/assets/addhealth.gif"/>This has been an interesting week in terms of networking. Actual TCP/IP networking, that is.  First, there's the normal jumping between the hotel and office networks.  The hotel, nicely enough, was completely free.  The office was also free, after entering what seemed to be an 480-character security key and avoiding the other 9 visible secure WAPs in the vicinity of my desk.  One was at least amusingly named "Magical Monkeys".

I've spent the cost of a nice meal across 4 airport encounters for probably a sum total of  45 minutes online.  Austin's WayPort network is at least cheaper than a day-pass on T-Mobile's in Dallas.  Though, a single T-Mobile day-pass should in theory work in multiple airports over a single day, assuming they all have T-Mobile.

Once I finally got home, I discovered my wifi wasn't connecting.  "Oh yeah," says the wife, "the internet's down."

<em>Of course it is! </em>

After a few reboots of the router, I notice that way too many lights are blinking.  Not a good sign.

I think my house was built upon an ancient router burial ground.  The router gods are angry at us for desecrating the <a title="7 layer dip" href="http://en.wikipedia.org/wiki/OSI_model">7 layers</a> of buried networking equipment.  I've somehow burned through no less than 5 routers in the past 18 months.  The most recent D-Link has definitely been heartier than the previous four steaming piles bearing the Cisco name. But even it met its demise in a little less than 6 months.

A little creative re-cabling later, the MacBook is jacked straight into the DSL thing-a-ma-bob flinging <a title="PPPop goes the weasel" href="http://en.wikipedia.org/wiki/Pppoe">PPPoE</a>.  And boy does it feel naked to not have a firewall between me and the interwebs.  Thank jebus I'm on a Mac.

Firing up the Cisco VPN software exposes a fancy OSX/Intel/PPP bug with this specific version of the client.  And Cisco, in its infinite wisdom, puts updates of the client software behind a password-protected site.

<em>Cisco is not my favorite company today.</em>

I finally have to head upstairs to basically climb the radio tower and see if a neighbor's WAP is visible.  Alas, I'm now blazing along with 1 bar (27% signal), but at least the VPN works.  If you're on a Mac, I can highly recommend <a title="iStumbler" href="http://www.istumbler.net/">iStumbler</a> for locating connection opportunities.

Tomorrow, I'll be off to the store to buy another router to sacrifice to the networking gods.  This one, perhaps I'll plug into the UPS.
