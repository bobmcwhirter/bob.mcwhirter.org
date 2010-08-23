---
title: "Identity and OpenID"
author: 'Bob McWhirter'
layout: blog
tags: [ identity, social, technology, web-20 ]
---
<img align="right" alt="Picture 15.png" id="image260" title="Picture 15.png" style="width: 196px; height: 129px" src="/blog/assets/Picture%2015.png"/>In a <a title="TSS on OpenID" href="http://www.theserverside.com/news/thread.tss?thread_id=45610">thread on TheServerSide</a>, commentors are discussing how much trust you can put into an OpenID identity.  Even the <a title="OpenID" href="http://openid.net/">OpenID</a> literature speaks of a server that returns <strong>true</strong> to all queries.  The argument seems to be that since you don't control the OpenID server, you can't trust the identity returned, making it useless.

In the grand scheme of things, does your average app ever truly identify the user?  About the best we do is identify an email address that can be used to reach the user <em>today</em>.  There is virtually no positive identification going on.  On the internet, your identity is simple who you claim to be.

Unless you're a bank or someone with an out-of-band real-world tie to your customer, really, what are your use-cases for "identity?"

For things I've worked with, they seem to be primarily the following
<ol>
	<li>Keeping "my" stuff separate from "your" stuff.  Identity isn't overly important here.  Knowing who "you" are isn't as important as knowing that "you" simply are different than "me" and "you" should keep the heck away from my things.</li>
	<li>Being able to contact users who don't necessarily visit the site or use the app often. This normally means a verified email address.  Once again, identity isn't as important as simply being able to contact the owner of some bundle of stuff, whoever he may be.</li>
</ol>
From my point of view, OpenID satisfies the first case easily enough, assuming the OpenID server is implemented honestly.  And if it isn't, then that's ultimately the user's problem for selecting a crappy identity provider.

OpenID does have a conduit for delivering a user's email address, using the <a title="OpenID sreg" href="http://openid.net/specs/openid-simple-registration-extension-1_0.html">Simple Registration extension</a>.  I would <strong>not</strong> trust that address, so OpenID does not solve my 2nd use-case.  But then again, neither does simply collecting an email address at sign-up on my own site.  People change jobs, ISPs, universities and spouses.  An email address isn't a permanent definite thing.  Even if I collect email addresses, I need to periodically verify they are still valid, and have a strategy for dealing with those that aren't.  If out-of-band communication is even honestly necessary.

Taking this view of email addresses, it would appear they make poor identities for users, since they could so easily be stripped of it.  I like the <a title="LinkedIn" href="http://linkedin.com/">LinkedIn</a> method of managing user accounts and email addresses, though.  I can associate multiple email addresses for my account.  And I can login with any of them.  I can remove them.  My account does not have to be tied to a single non-changing email address.

Given all of this, I think OpenID helps with use-case #1, and no centralized standard will help with use-case #2.
