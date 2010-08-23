---
title: "Print like you mean it"
author: 'Bob McWhirter'
layout: blog
tags: [ eclipse, enscript, java, printing ]
---
When digging through code, I find it's good to print it out, wander off away from the machine, and do some reading.

But if you print any reasonable-sized chunk of code from Eclipse, you'll be carrying around several reams of paper, since Eclipse apparently thinks we're all blind illiterates.

For the past decade, my friend &amp; mentor <a title="Jim's blog" href="http://escx.blogspot.com/">Jim Crossley</a> and I have been passing the same encscript alias back and forth.  I recently had to request it from him again.  (Mental note: put it in SCM somewhere...)
<pre>
  <code style="font-size: 100%; font-weight: bold;">alias print='enscript --color=blackwhite -E -T4 -M Letterdj -C -2 -fCourier@5/5 -r $*'
</code>
</pre>
It'll spew out your code in landscape mode, syntax-highlighted, two columns of 90 lines each (180 lines total per page), with line-numbers and a nice-looking header.

Many times, this allows you to fit an entire class on a single sheet without any gratuitous wrapping due to Eclipse's 24pt font usage.

<a href="/blog/assets/picture-25.png">
  <img class="aligncenter size-full wp-image-507" title="picture-25" src="/blog/assets/picture-25.png" alt="" width="431" height="185"/>
</a>
