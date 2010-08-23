---
title: "Elasticfox, OSX and iTerm"
author: 'Bob McWhirter'
layout: blog
tags: [ applescript, ec2, elasticfox, osa, osx ]
---
<a title="Elasticfox" href="http://developer.amazonwebservices.com/connect/entry.jspa?externalID=609">Elasticfox</a> is a nice extension for managing your relationship with <a title="Amazon EC2" href="http://aws.amazon.com/ec2/">EC2</a> from within Firefox.  It's XUL-based, somewhat homely and odd.  But it's so much nicer than dealing with the <code>ec2-*</code> scripts directly and copying Amazon's wacky hash identifiers hither and thither.

But on OSX, the "ssh to this instance" button is wired up to Terminal.app.  I can't stand Terminal.app.  I much prefer iTerm.

So, a little AppleScript hacking, and Elasticfox now uses iTerm to connect to instances through ssh.

Instead of jamming it all into a dozen <code>-e</code> options on <code>osascript</code>, I just put it in a file, and changed my configuration.

<dl id="attachment_542" class="wp-caption aligncenter" style="width: 448px;"> <dt class="wp-caption-dt"><a href="/blog/assets/picture-26.png"><img class="size-full wp-image-542" title="Elasticfox configuration" src="/blog/assets/picture-26.png" alt="Elasticfox configuration" width="438" height="265"/></a></dt> </dl>

And the script itself:

<pre style="overflow:auto;font-size:90%;">
  <code>
on run argv
  tell application "iTerm"
    activate
    set cmd to "ssh -i " &amp; item 1 of argv &amp; " " &amp; item 2 of argv
    set myterm to the last terminal
    tell myterm
      launch session "Default Session"
      tell the last session
        write text the cmd
      end tell
    end tell
  end tell
end run
</code>
</pre>
